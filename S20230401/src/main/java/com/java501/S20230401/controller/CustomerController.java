package com.java501.S20230401.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.Paging;
import com.java501.S20230401.service.ReplyService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 고객센터 페이지 계열 컨트롤러 : 최승환
@Controller
@Slf4j
@RequiredArgsConstructor
public class CustomerController {
	
	private final ArticleService as;
	@Autowired
	private final ReplyService rs;
	
	@RequestMapping(value = "/board/customer")
	public String customerList(Article article, int category, String currentPage, Model model) {
		System.out.println("CustomerController Start customerList..." );
		article.setBrd_id(category);
		int totalCustomer =  as.totalCustomer();
		System.out.println("CustomerController totalCustomer=>" + totalCustomer);
		// Paging 작업
		Paging page = new Paging(totalCustomer, currentPage);
		// Parameter article --> Page만 추가 Setting
		article.setStart(page.getStart());	// 시작시 1
		article.setEnd(page.getEnd());		// 시작시 10
		
		List<Article> listCustomer = as.listCustomer(article);
		System.out.println("CustomerController list listNotice.size()->"+listCustomer.size());
		
		model.addAttribute("totalCustomer", totalCustomer);
		model.addAttribute("listCustomer", listCustomer);
		model.addAttribute("page", page);
		// 설정해둔 view resolver로 리턴
		return "/customer/CustomerIndex";
	}
	
	@GetMapping(value = "/board/customer/detailCustomer")
	public String detailCustomer(Article article, Model model) {
		System.out.println("CustomerController Start detailCustomer...");

		
//		1. ArticleService안에 detailCustomer method 선언
//		   1) parameter : brd_id
//		   2) Return      Article
//
		Article customerDetail = as.detailCustomer(article);
		model.addAttribute("article", customerDetail);
		
//		2. ArticleDao   detailCustomer method 선언 
////		                    mapper ID   ,    Parameter
//		article = session.selectOne("shCustomerDetail",    brd_id);
		System.out.println("댓글 갯수세기 시작");
		// 댓글 총갯수세기
		// 댓글 목록
		System.out.println("아티클수"+article);
		Reply reply = new Reply();
		reply.setArt_id(article.getArt_id());
		reply.setBrd_id(article.getBrd_id());
		
		int replyCount = rs.replyCount(reply);
		List<Reply> replyList = rs.replyList(reply);

		model.addAttribute("replyCount", replyCount);
		model.addAttribute("replyList",replyList);
		
		System.out.println("댓글카운트"+replyCount);
		System.out.println("댓글리스트"+replyList);
		
		return "/customer/detailCustomer";
		
		
		
	}
}
	


