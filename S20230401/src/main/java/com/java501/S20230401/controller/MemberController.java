package com.java501.S20230401.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.ArticleMember;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.model.ReplyMember;
import com.java501.S20230401.model.Trade;
import com.java501.S20230401.model.TradeInfo;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.CommService;
import com.java501.S20230401.service.MemberDetailsService;
import com.java501.S20230401.service.MemberService;
import com.java501.S20230401.service.RegionService;
import com.java501.S20230401.service.ReplyService;
import com.java501.S20230401.service.TradeService;
import com.java501.S20230401.util.EmailMessage;
import com.java501.S20230401.util.MemberSearchKeyword;
import com.java501.S20230401.util.TradeType;

import lombok.RequiredArgsConstructor;

// 유저 페이지 계열 컨트롤러 : 유현규
@Controller
@RequiredArgsConstructor
public class MemberController {
	private final MemberService ms;
	private final RegionService rs;
	private final ArticleService as;
	private final ReplyService reps;
	private final TradeService ts;
	private final CommService cs;
	private final MemberDetailsService mds;
	
	@RequestMapping(value = "/login")
	public String memberLogin(@AuthenticationPrincipal MemberDetails memberDetails,
							  HttpServletRequest request,
							  HttpServletResponse response) {
		String referer = request.getHeader("Referer");
		if (memberDetails != null)
			try { response.sendRedirect(referer); }
			catch (IOException e) { e.printStackTrace(); }
		if (request.getSession().getAttribute("prevPage") == null) request.getSession().setAttribute("prevPage", referer);
		return "loginForm";
	}
	
	@RequestMapping(value = "/join")
	public String memberJoin(Model model) {
		model.addAttribute("now", new Date());
		
		Map<Region, List<Region>> regionHierachy = new HashMap<Region, List<Region>>();
		List<Region> superRegions = rs.getSuperRegions();
		for (Region sups : superRegions) regionHierachy.put(sups, rs.getChildRegions(sups.getReg_id()));
		model.addAttribute("superRegions", superRegions);
		model.addAttribute("regions", regionHierachy);
		
		return "joinForm";
	}
	
	@RequestMapping(value = "/user/userinfo")
	public String modifyMemberInformation(@AuthenticationPrincipal MemberDetails memberDetails, Model model) {
		model.addAttribute("now", new Date());
		
		Map<Region, List<Region>> regionHierachy = new HashMap<Region, List<Region>>();
		List<Region> superRegions = rs.getSuperRegions();
		for (Region sups : superRegions) regionHierachy.put(sups, rs.getChildRegions(sups.getReg_id()));
		model.addAttribute("superRegions", superRegions);
		model.addAttribute("regions", regionHierachy);
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		return "user/userInformation";
	}
	
	@PostMapping(value = "/joinProc")
	public String memberJoinProcess(@RequestParam(value = "image-file", required = false) MultipartFile file, @RequestParam Map<String, String> params, MultipartHttpServletRequest request, RedirectAttributes redirectAttributes) {
		Member member = new Member();
		member.setMem_username(params.get("username"));
		member.setMem_password(new BCryptPasswordEncoder().encode(params.get("password")));
		member.setMem_nickname(params.get("nickname"));
		member.setMem_email(params.get("email"));
		member.setMem_tel(params.get("tel1") + params.get("tel2") + params.get("tel3"));
		int year = Integer.parseInt(params.get("year"));
		int month = Integer.parseInt(params.get("month"));
		int day = Integer.parseInt(params.get("day"));
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month, day);
		Date birthday = calendar.getTime();
		member.setMem_birthday(birthday);
		member.setMem_gender(cs.getCommByName(params.get("gender")).getComm_id());
		String[] regions = { params.get("region1-value").trim(), params.get("region2-value").trim() };
		for (String reg : regions) {
			if (!reg.trim().isEmpty()) {
				int regionCode = Integer.parseInt(reg);
				if (member.getMem_region1() == null) member.setMem_region1(regionCode);
				else member.setMem_region2(regionCode);
			}
		}
		String savedName = file.getOriginalFilename();
		String realPath = request.getSession().getServletContext().getRealPath("/uploads/profile");
		try {
			savedName = uploadFile(realPath, savedName, file.getBytes());
			member.setMem_image(savedName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int result = ms.registMember(member);
		Member readMember = ms.getMember(member.getMem_username(), MemberSearchKeyword.USERNAME);
		readMember.setMem_password(null);
		redirectAttributes.addFlashAttribute("member", readMember);
		return "redirect:/mail/JoinAuthentification";
	}
	
	@PostMapping(value = "/updateMemberProc")
	public String memberUpdateProcess(@AuthenticationPrincipal MemberDetails memberDetails,@RequestParam(value = "image-file", required = false) MultipartFile file, @RequestParam Map<String, String> params, MultipartHttpServletRequest request, RedirectAttributes redirectAttributes) {
		Member member = new Member();
		member.setMem_id(memberDetails.getMemberInfo().getMem_id());
		member.setMem_nickname(params.get("nickname"));
		member.setMem_tel(params.get("tel1") + params.get("tel2") + params.get("tel3"));
		int year = Integer.parseInt(params.get("year"));
		int month = Integer.parseInt(params.get("month"));
		int day = Integer.parseInt(params.get("day"));
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month, day);
		Date birthday = calendar.getTime();
		member.setMem_birthday(birthday);
		member.setMem_gender(cs.getCommByName(params.get("gender")).getComm_id());
		String[] regions = { params.get("region1-value").trim(), params.get("region2-value").trim() };
		for (String reg : regions) {
			if (!reg.trim().isEmpty()) {
				int regionCode = Integer.parseInt(reg);
				if (member.getMem_region1() == null) member.setMem_region1(regionCode);
				else member.setMem_region2(regionCode);
			}
		}
		String savedName = file.getOriginalFilename();
		String realPath = request.getSession().getServletContext().getRealPath("/uploads/profile");
		try {
			savedName = uploadFile(realPath, savedName, file.getBytes());
			member.setMem_image(savedName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int result = ms.hgUpdateMember(member);
		// 아래 세션 인증 정보 변경
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberDetails newMemberDetails = (MemberDetails)authentication.getPrincipal();
		SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication, newMemberDetails.getUsername()));
		
		return "redirect:/";
	}
	// 새로운 인증 정보 생성
	protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
		UserDetails newPrincipal = mds.loadUserByUsername(username);
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		newAuth.setDetails(currentAuth.getDetails());
		return newAuth;
	}
	
	private String uploadFile(String realPath, String originalName, byte[] fileData) throws Exception {
		UUID uuid = UUID.randomUUID();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu_MM_dd_HH_mm_ss");
		String savedName = uuid.toString() + "_" + dtf.format(LocalDateTime.now()) + "_" + originalName;
		File target = new File(realPath, savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}
	
	@ResponseBody
	@PostMapping(value = "/getMember")
	public Map<String, Object> getMember(@AuthenticationPrincipal MemberDetails memberDetails, @RequestBody Map<String, Object> data){
		Map<String, Object> resp = new HashMap<String, Object>();
		String type = (String)data.get("type");
		String value = (String)data.get("value");
		Boolean except = (Boolean)data.get("except");
		MemberSearchKeyword searchType = Enum.valueOf(MemberSearchKeyword.class, type.toUpperCase());
		Member member = null;
		if (!except) member = ms.getMember(value, searchType);
		else {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("value", value);
			param.put("except", memberDetails.getMemberInfo().getMem_id());
			member = ms.hgGetMemberWithExcept(param, searchType);
		}
		resp.put("value", member);
		return resp;
	}
	
	/* 마이 페이지 관련 컨트롤러 */
	@RequestMapping(value = "/user/mypage")
	public String myPage(@AuthenticationPrincipal MemberDetails memberDetails,
						 HttpServletRequest request, HttpServletResponse response,
						 Model model) {
		
		if (memberDetails == null)
			try { response.sendRedirect(request.getHeader("Referer")); }
			catch (IOException e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("now", new Date());
		
		int mem_id = memberDetails.getMemberInfo().getMem_id();
		// Article 최신 리스트 가져오기
		List<ArticleMember> articles = as.hgGetArticlesOfMember(mem_id);
		model.addAttribute("articles", articles);
		// Reply 최신 리스트 가져오기
		List<ReplyMember> replies = reps.hgGetRepliesOfMember(mem_id);
		model.addAttribute("replies", replies);
		HashMap<Integer, HashMap<Integer, ArticleMember>> repParents = new HashMap<Integer, HashMap<Integer,ArticleMember>>();
		for (ReplyMember reply : replies) {
			Article searcher = new Article();
			int art_id = reply.getArt_id();
			int brd_id = reply.getBrd_id();
			searcher.setArt_id(art_id);
			searcher.setBrd_id(brd_id);
			ArticleMember am = as.getArticleMemberById(searcher);
			if (repParents.get(brd_id) == null) {
				repParents.put(brd_id, new HashMap<Integer, ArticleMember>());
			}
			repParents.get(brd_id).put(art_id, am);
		}
		model.addAttribute("repParents", repParents);
		// Trade 항목 별 최신 리스트 가져오기
		Trade searcher = new Trade();
		searcher.setMem_id(mem_id);
		Map<String, Map<Integer, List<TradeInfo>>> trades = new HashMap<String, Map<Integer,List<TradeInfo>>>();
		for (TradeType type : TradeType.values()) {
			String mainKey = type.toString();
			Map<Integer, List<TradeInfo>> trdList = new HashMap<Integer, List<TradeInfo>>();
			for (Integer status : new Integer[] { 401, 402, 403, 404 }) {
				searcher.setTrd_status(status);
				trdList.put(status, ts.hgGetTradesByType(searcher, type));
			}
			trades.put(mainKey, trdList);
		}
		model.addAttribute("trades", trades);
		
		return "user/myPage";
	}
	
	@RequestMapping(value="/user/passwordCheck")
	public String reAuth(@AuthenticationPrincipal MemberDetails memberDetails, @RequestParam String go,
						 Model model) {
		if (memberDetails == null) return "redirect:/";
		model.addAttribute("go", go);
		return "user/reAuth";
	}
	
	@RequestMapping(value="/user/comparePW")
	public String reAuthProcess(@AuthenticationPrincipal MemberDetails memberDetails, @RequestParam String go,
								@RequestParam String password) {
		if (memberDetails == null) return "redirect:/";
		//if (memberDetails.getPassword().equals(new BCryptPasswordEncoder().encode(password)))
		if (new BCryptPasswordEncoder().matches(password, memberDetails.getPassword()))
			return "redirect:/user/" + go;
		else return "redirect:/user/passwordCheck?go=" + go;
	}
}
