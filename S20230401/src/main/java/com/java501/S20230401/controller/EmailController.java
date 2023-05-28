package com.java501.S20230401.controller;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.java501.S20230401.model.Authentications;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.service.AuthenticationsService;
import com.java501.S20230401.service.EmailService;
import com.java501.S20230401.service.MemberDetailsService;
import com.java501.S20230401.service.MemberService;
import com.java501.S20230401.util.EmailMessage;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EmailController {
	private final EmailService es;
	private final MemberService ms;
	private final MemberDetailsService mds;
	private final AuthenticationsService as;
	
	@RequestMapping(value = "/mail/JoinAuthentification")
	public String sendJoinAuth(@AuthenticationPrincipal MemberDetails memberDetails, HttpServletRequest request) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		Member member = null;
		if (memberDetails == null) member = (Member)flashMap.get("member");
		else member = ms.getMemberById(memberDetails.getMemberInfo().getMem_id());
		String emailAddress = member.getMem_email();
		String rawUrl = request.getRequestURL().toString();
		String baseUrl = rawUrl.replace("/mail/JoinAuthentification", "");
		EmailMessage msg = EmailMessage.builder().to(emailAddress).subject("[ShareGo] 회원가입 인증을 완료해주세요").build();
		String code = es.sendMail(msg, "thymeleaf/join", baseUrl);
		as.setAuthentication(member, code);
		return "redirect:/";
	}
	
	@RequestMapping(value = "/mail/PasswordReset")
	public String sendPasswordReset(HttpServletRequest request) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		Member member = (Member)flashMap.get("member");
		//member.setMem_email(((Member)flashMap.get("member")).getMem_email());
		String emailAddress = member.getMem_email();
		String rawUrl = request.getRequestURL().toString();
		String baseUrl = rawUrl.replace("/mail/PasswordReset", "");
		EmailMessage msg = EmailMessage.builder().to(emailAddress).subject("[ShareGo] 비밀번호 재설정").build();
		String code = es.sendMail(msg, "thymeleaf/pwreset", baseUrl);
		as.setAuthentication(member, code);
		return "redirect:/";
	}
	
	@GetMapping(value = "/MemberAuthentication")
	public String authentication(@AuthenticationPrincipal MemberDetails memberDetails, @RequestParam String v, RedirectAttributes redirectAttributes) {
		Authentications auth = as.getAuthentication(v);
		// 아래에 링크 만료 여부에 따른 액션 넣기...
		if (auth != null) {
			System.out.println(auth.getAuth_expiredate().compareTo(new Date()));
			if (auth.getAuth_expiredate().compareTo(new Date()) < 0) {
				redirectAttributes.addFlashAttribute("msg", "인증이 만료되었습니다");
				as.deleteAuthentication(auth.getAuth_id());
				return "redirect:/justPopup";
			}
			ms.setAuthority(auth.getMem_id(), 103);
			// 아래 세션 인증 정보 변경
			if (memberDetails != null) {
				Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
				MemberDetails newMemberDetails = (MemberDetails)authentication.getPrincipal();
				SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication, newMemberDetails.getUsername()));
			}
		} else {
			redirectAttributes.addFlashAttribute("msg", "인증 정보가 없습니다");
			return "redirect:/justPopup";
		}
		as.deleteAuthentication(auth.getAuth_id());
		return "redirect:/";
	}
	// 새로운 인증 정보 생성
	protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
		UserDetails newPrincipal = mds.loadUserByUsername(username);
		UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		newAuth.setDetails(currentAuth.getDetails());
		return newAuth;
	}
	
	@GetMapping(value = "/resetPassword")
	public String passwordReset(@RequestParam String v, RedirectAttributes redirectAttributes, Model model) {
		Authentications auth = as.getAuthentication(v);
		// 아래에 링크 만료 여부에 따른 액션 넣기...
		if (auth != null) {
			System.out.println(auth.getAuth_expiredate().compareTo(new Date()));
			if (auth.getAuth_expiredate().compareTo(new Date()) < 0) {
				redirectAttributes.addFlashAttribute("msg", "비밀번호 재설정 시간이 만료되었습니다");
				as.deleteAuthentication(auth.getAuth_id());
				return "redirect:/justPopup";
			}
			model.addAttribute("v", v);
			return "resetPassword";
		} else {
			redirectAttributes.addFlashAttribute("msg", "비밀번호 재설정 정보가 없습니다");
			return "redirect:/justPopup";
		}
	}
	
	@PostMapping(value = "/resetPasswordProc")
	public String passwordResetProc(@RequestParam Map<String, Object> data) {
		String v = (String)data.get("v");
		Authentications auth = as.getAuthentication(v);
		Integer mem_id = auth.getMem_id();
		
		Member member = new Member();
		member.setMem_id(mem_id);
		member.setMem_password(new BCryptPasswordEncoder().encode((String)data.get("password")));
		int result = ms.hgUpdatePassword(member);
		
		if (result > 0) as.deleteAuthentication(auth.getAuth_id());
		return "redirect:/";
	}
	
	@RequestMapping(value = "/justPopup")
	public String justPopup(HttpServletRequest request, Model model) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		model.addAttribute("msg", (String)flashMap.get("msg"));
		return "justPopup";
	}
}
