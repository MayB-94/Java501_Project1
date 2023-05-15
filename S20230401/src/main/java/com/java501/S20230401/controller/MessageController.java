package com.java501.S20230401.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.model.Message;
import com.java501.S20230401.service.MemberService;
import com.java501.S20230401.service.MessageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MessageController {
	private final MessageService messageService;
	private final MemberService memberService;
	
	// 쪽지 팝업
	@RequestMapping(value = "message")
	public String messagePage(@AuthenticationPrincipal MemberDetails memberDetails, Model model) {
		MemberInfo memberInfo = null;
		List<Message> messageListRec = null;
		List<Message> messageListSen = null;
		if(memberDetails != null) {
			memberInfo = memberDetails.getMemberInfo();
			model.addAttribute("memberInfo", memberInfo);
			
			// 받은 쪽지
			messageListRec = messageService.dgMessageListRec(memberInfo.getMem_id());
			// 보낸 쪽지
			messageListSen = messageService.dgMessageListSen(memberInfo.getMem_id());
		
			model.addAttribute("messageListRec", messageListRec);
			model.addAttribute("messageListSen", messageListSen);
		}
		
		return "messagePopup";
	}
	// 쪽지쓰기
	@PostMapping(value = "message/writeForm")
	public String messageWrite(@AuthenticationPrincipal MemberDetails memberDetails, Message message) {
		log.info("값 {}", message);
		if(memberDetails != null)
			message.setMem_sender_id(memberDetails.getMemberInfo().getMem_id());
		messageService.dgMessageWrite(message);
		return "redirect:/message";
	}
	
	// 유저 체크
	@PostMapping(value = "message/checkUser")
	@ResponseBody
	public int checkUser(String mem_username) {
		Integer result = memberService.dgCheckUser(mem_username);
		
		return result==null? 0:result; 
	}
	
	// 보관 , 휴지통, 삭제, 읽음 처리
	@PostMapping(value = "message/{action}")
	@ResponseBody
	public boolean messageAction(@PathVariable("action")String action, Message message) {
		boolean result = false;
		log.info("값 :{} {}", action, message);
		
		if(action.equals("storage")) {
			message.setMes_status(302);
			result = messageService.dgMessageAction(message);
		}else if(action.equals("recycle")) {
			message.setMes_status(303);
			result = messageService.dgMessageAction(message);
		}else if(action.equals("delete")) {
			result = messageService.dgMessageDelete(message);
		}else if(action.equals("read")) {
			result = messageService.dgMessageRead(message);
		}
		return result;
	}
	
	
	
}
