package com.java501.S20230401.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.ArticleMember;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.ReplyMember;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.CommService;
import com.java501.S20230401.service.RegionService;
import com.java501.S20230401.service.ReplyService;

import lombok.RequiredArgsConstructor;

//@Controller
@RequiredArgsConstructor
public class ArticleController {
	private final ArticleService as;
	private final RegionService rs;
	private final CommService cs;
	private final ReplyService reps;
	
	private Integer getBoardIdByBoardName(String boardName) {
		switch(boardName) {
			case "together": return 1000;
			case "dutchpay": return 1100;
			case "share": return 1200;
			case "community": return 1300;
			case "information": return 1400;
			case "customer": return 1500;
			default: return null;
		}
	}
	
	@GetMapping(value = "/board/{boardName}/write")
	public String writeArticle(@PathVariable String boardName, @RequestParam(required = false) Integer brd_id,
							   @RequestParam(required = false) Integer pageNum,
							   @AuthenticationPrincipal MemberDetails memberDetails,
							   Model model) {
		String[] trades = { "together", "dutchpay", "share" };
		boolean isTradeBoard = Arrays.stream(trades).anyMatch(boardName::equals);
		if (isTradeBoard) {
			Map<Region, List<Region>> regionHierachy = new HashMap<Region, List<Region>>();
			List<Region> superRegions = rs.getSuperRegions();
			for (Region sups : superRegions) regionHierachy.put(sups, rs.getChildRegions(sups.getReg_id()));
			model.addAttribute("superRegions", superRegions);
			model.addAttribute("regions", regionHierachy);
		}
		model.addAttribute("isTradeBoard", isTradeBoard);
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("boardName", boardName);
		int boardId = brd_id == null ? getBoardIdByBoardName(boardName) : brd_id;
		model.addAttribute("brd_id", boardId);
		if (pageNum != null) model.addAttribute("pageNum", pageNum);
		
		List<Comm> categoryList = cs.getCategoryListBySuper(getBoardIdByBoardName(boardName));
		model.addAttribute("categories", categoryList);
		
		return "writeArticleForm";
	}
	
	@ResponseBody
	@PostMapping(value = "/board/{boardName}/imageUpload", produces = "application/text; charset=UTF-8")
	public void imageUploadInArticle(@PathVariable String boardName, HttpServletResponse response,
									 MultipartHttpServletRequest request) throws Exception {
		response.setCharacterEncoding("UTF-8");
		JSONObject jsonObject = null;
		PrintWriter printWriter = null;
		//MultipartFile file = request.getFile("upload");
		MultipartFile file = request.getFile("uploadFile");
		OutputStream out = null;
		if (file != null) {
			if (file.getSize() > 0 && !file.getName().isBlank() && !file.getName().isEmpty()) {
				//System.out.println(file.getContentType());
				if (file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						String fileName = file.getOriginalFilename();
						byte[] bytes = file.getBytes();
						String uploadPath = request.getSession().getServletContext().getRealPath("/uploads/article");
						//System.out.println(uploadPath);
						File uploadFile = new File(uploadPath);
						if (!uploadFile.exists()) {
							uploadFile.mkdir();
						}
						DateTimeFormatter dtf = DateTimeFormatter.ofPattern("uuuu_MM_dd_HH_mm_ss");
						String uuid = UUID.randomUUID().toString();
						String dateStr = dtf.format(LocalDateTime.now());
						uploadPath += "/" + uuid + "_" + dateStr + "_" + fileName;
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);
						String fileUrl = request.getContextPath() + "/uploads/article/" + uuid + "_" + dateStr + "_" + fileName;
						//System.out.println(fileUrl);
						jsonObject = new JSONObject();
						jsonObject.append("uploaded", 1);
						jsonObject.append("fileName", fileName);
						jsonObject.append("url", fileUrl);
						//jsonObject.append("url", uploadPath);
						printWriter = response.getWriter();
						printWriter.println(jsonObject.toString());
						printWriter.flush();
					} catch(Exception e) {
						e.printStackTrace();
					} finally {
						if (printWriter != null) printWriter.close();
					}
				}
			}
		}
	}

	@PostMapping(value = "/board/{boardName}/writeProc")
	public String writeArticleProcess(Article article, @RequestParam int brd_idLink,
									  @PathVariable String boardName,
									  String articleEditor,
									  @AuthenticationPrincipal MemberDetails memberDetails) {
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		int result = as.insertArticle(article);
		return "redirect:/board/" + boardName + "?brd_id=" + brd_idLink;
	}
	
	@GetMapping(value = "/board/{boardName}/{art_id}")
	public String viewArticle(@AuthenticationPrincipal MemberDetails memberDetails,
							  @PathVariable String boardName,
							  @PathVariable int art_id, @RequestParam int brd_id,
							  @RequestParam Integer category,
							  String currentPage,
							  HttpServletRequest request,
							  HttpServletResponse response,
							  Model model) {
		String baseUrl = ServletUriComponentsBuilder.fromRequestUri(request)
										            .replacePath(null)
										            .build()
										            .toUriString();
		model.addAttribute("baseUrl", baseUrl);
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		Article searcher = new Article();
		searcher.setArt_id(art_id);
		searcher.setBrd_id(brd_id);
		// 쿠키 구워서 조회수 증가시키는 로직
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("viewArticle")) {
					oldCookie = cookie;
				}
			}
		}
		if (oldCookie != null) {
			if (!oldCookie.getValue().contains(String.format("[%s_%s]", art_id, brd_id))) {
				as.hgIncreaseReadCount(searcher); // 조회수 올리는 메서드
				oldCookie.setValue(oldCookie.getValue() + String.format("&[%s_%s]", art_id, brd_id));
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(oldCookie);
			}
		} else {
			as.hgIncreaseReadCount(searcher); // 조회수 올리는 메서드
			Cookie newCookie = new Cookie("viewArticle", String.format("[%s_%s]", art_id, brd_id));
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie);
		}
		// 쿠키 끝!
		ArticleMember article = as.getArticleMemberById(searcher);
		MemberInfo writerInfo = as.getMemberInfoById(article.getMem_id());
		if (category.intValue() != brd_id) model.addAttribute("board", cs.getCommById(brd_id).getComm_value());
		else model.addAttribute("board", null);
		String boardScope = cs.getValueById(category);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("boardScope", boardScope);
		model.addAttribute("boardName", boardName);
		model.addAttribute("writerInfo", writerInfo);
		model.addAttribute("article", article);
		model.addAttribute("brd_id", brd_id);
		//return "viewArticle_Backup";
		return "viewArticle";
	}
	
	@ResponseBody
	@PostMapping(value = "/board/{boardName}/{art_id}/recommend")
	public String recommend(@AuthenticationPrincipal MemberDetails memberDetails,
							@PathVariable String boardName,
							@PathVariable int art_id,
							HttpServletRequest request,
							HttpServletResponse response,
							@RequestBody Map<String, Object> data) {
		JSONObject jsonObj = new JSONObject();
		if (memberDetails == null) {
			jsonObj.append("result", -1);
			return jsonObj.toString();
		}
		int brd_id = (int)data.get("brd_id");
		boolean isGood = (boolean)data.get("isGood");
		Article searcher = new Article();
		searcher.setArt_id(art_id);
		searcher.setBrd_id(brd_id);
		searcher.setArt_good(0);
		searcher.setArt_bad(0);
		if (isGood) searcher.setArt_good(1);
		else searcher.setArt_bad(1);
		// 쿠키 구워서 추천 | 비추천 수 증가시키는 로직
		Cookie oldCookie = null;
		String typeName = isGood ? "recommendArticle" : "deprecatedArticle";
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(typeName)) {
					oldCookie = cookie;
				}
			}
		}
		int result = 0;
		if (oldCookie != null) {
			if (!oldCookie.getValue().contains(String.format("[%s_%s]", art_id, brd_id))) {
				result = as.hgRecommendArticle(searcher); // 추천 | 비추천 수 올리는 메서드
				oldCookie.setValue(oldCookie.getValue() + String.format("&[%s_%s]", art_id, brd_id));
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(oldCookie);
			}
		} else {
			result = as.hgRecommendArticle(searcher); // 추천 | 비추천 수 올리는 메서드
			Cookie newCookie = new Cookie(typeName, String.format("[%s_%s]", art_id, brd_id));
			newCookie.setPath("/");
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie);
		}
		// 쿠키 끝!
		Article affectedArticle = as.getArticleById(searcher);
		jsonObj.append("result", result);
		jsonObj.append("value", isGood ? affectedArticle.getArt_good() : affectedArticle.getArt_bad());
		return jsonObj.toString();
	}
	
	@PostMapping(value = "/board/{boardName}/{art_id}/replies")
	public String viewReply(@AuthenticationPrincipal MemberDetails memberDetails,
			  				@PathVariable String boardName,
			  				@PathVariable int art_id,
			  				@RequestBody Map<String, Object> data,
			  				Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		int brd_id = (int)data.get("brd_id");
		Article article = new Article();
		article.setArt_id(art_id);
		article.setBrd_id(brd_id);
		List<ReplyMember> replies = reps.getReplyByArticle(article);
		model.addAttribute("replies", replies);
		return "replyMiddleView";
	}
	
	@ResponseBody
	@PostMapping(value = "/board/{boardName}/{art_id}/replyWrite")
	public String writeReply(@AuthenticationPrincipal MemberDetails memberDetails,
			  				 @PathVariable String boardName,
							 @PathVariable int art_id,
							 @RequestBody Map<String, Object> data) {
		JSONObject result = new JSONObject();
		int brd_id = (int)data.get("brd_id");
		int mem_id = (int)data.get("mem_id");
		String rep_content = "<xmp>" + (String)data.get("rep_content") + "</xmp>";
		String reply_add = null;
		String display_whose = null;
		Integer rep_parent = null;
		if (data.get("reply-add") != null) reply_add = (String)data.get("reply-add");
		if (data.get("display-whose") != null) display_whose = (String)data.get("display-whose");
		if (data.get("rep_parent") != null) rep_parent = (int)data.get("rep_parent");
		if (reply_add != null) rep_content = "<a style=\"cursor: pointer; font-size: 16px; font-weight: bold; color: var(--subtheme);\" onclick=\"$('#" + reply_add + "')[0].scrollIntoView({behavior : 'smooth'});\">" + display_whose + "</a><br>" + rep_content;
		Reply reply = new Reply();
		reply.setArt_id(art_id);
		reply.setBrd_id(brd_id);
		reply.setMem_id(mem_id);
		reply.setRep_content(rep_content);
		if (rep_parent != null) reply.setRep_parent(rep_parent);
		int ajaxResult = reps.hgInsertReply(reply);
		result.append("result", ajaxResult);
		result.append("art_id", art_id);
		result.append("brd_id", brd_id);
		return result.toString();
	}
}
