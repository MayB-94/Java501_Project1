package com.java501.S20230401.controller;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.Paging;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 같이사요 페이지 계열 컨트롤러 : 김진현
@Controller
@RequiredArgsConstructor
@Slf4j
public class DutchpayController {
	private final ArticleService as;
	
	@RequestMapping(value = "/board/dutchpay") // 대분류 같이사요 + 중분류 하위카테고리 이동 및 List조회  
	public String dutchpayList(Article article,int category, String currentPage, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		String viewName;
		 String boardName;
	      switch(category) { //카테고리 이동
	      case 1110: viewName = "dutchpayFoodList"; boardName = "FoodList"; break;
	      case 1120: viewName = "dutchpayClothesList"; boardName = "ClothesList"; break;
	      case 1130: viewName = "dutchpayHouseStuffList"; boardName = "HouseStuffList"; break;
	      case 1140: viewName = "dutchpayOverseasList"; boardName = "OverseasList"; break;
	      case 1150: viewName = "dutchpayEtcList"; boardName = "EtcList"; break;
	      default: viewName = "dutchpayList"; boardName = "List"; break;
	      }
	      List<Article> dutchpayList = as.getDutchpayList(boardName);
	      System.out.println("controller dutchpayList size() -> "+dutchpayList.size());
	      model.addAttribute("dutchpayList", dutchpayList);
	      
	      // 페이징
	      int totalAticle = as.totalArticle();
	      System.out.println("컨트롤러 페이징 totalArticle -> "+totalAticle);
	      
	      Paging page = new Paging(totalAticle, currentPage);
	      article.setStart(page.getStart());
	      article.setEnd(page.getEnd());
	      
	      return "dutchpay/" + viewName;
	}
	
	@RequestMapping(value ="/dutchpay/dutchpayDetail") //상세 게시글    
	public String dutchpayDetail(Article article, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		int read = as.DeatilRead1(article); // 조회수

		
		Article detail = as.detail1(article); //상세페이지
		model.addAttribute("detail", detail);
		System.out.println("controller detail brd_id -> "+detail.getBrd_id());
		System.out.println("controller detail art_id -> "+detail.getArt_id());
		System.out.println("controller detail trd_id -> "+detail.getTrd_id());
		
		
		article.setTrd_id(detail.getTrd_id()); // 공구 참가자(수락 확정된) 명단 보여주기
		List<Article> joinList  = as.joinList1(article); 
		model.addAttribute("joinList", joinList);
		System.out.println("joinList.trd_id -> "+detail.getTrd_id());
		
		
		article.setTrd_id(detail.getTrd_id()); // 공구 참가자(수락 미확정) 대기열 명단 보여주기
		List<Article> waitList = as.waitList1(article);
		model.addAttribute("waitList", waitList);
		System.out.println("waitList.trd_id -> "+detail.getTrd_id());
		
		
		List<Article> repList = as.repList1(article); // 댓글리스트 조회
		model.addAttribute("repList", repList);

		
		return "/dutchpay/dutchpayDetail";
	}

	

	@RequestMapping(value = "dutchpay/dutchpayWriteForm") //글쓰기 폼 
	public String dutchpayWriteForm(Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		System.out.println("dutchpay/dutchpayWriteForm start..");
		
		List<Comm> category = as.category1();
		for (Comm c : category) System.out.println(c.getComm_id() + " : " + c.getComm_value());
		System.out.println("dutchpay/dutchpayWriteForm category.size()- >"+category.size());
		List<Region> loc = as.loc1();
		//for (Region l : loc) System.out.println(l.getReg_id() + " : " + l.getReg_name());
		System.out.println("dutchpay/dutchpayWriteForm loc.size() ->"+loc.size());
	
		model.addAttribute("categories", category);
		model.addAttribute("loc", loc);
		
		return "dutchpay/dutchpayWriteForm";
	}
	
	

	@RequestMapping(value = "dutchpay/dutchpayUpdateForm") //업데이트(수정) 폼 + 드롭다운 
	public String dutchpayUpdateForm(Article article, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		System.out.println("dutchpay/dutchpayUpdateForm start..");
		System.out.println("controller updateForm brd_id  -> "+article.getBrd_id());
		System.out.println("controller updateForm art_id  -> "+article.getArt_id());
		Article updateForm = as.updateForm1(article);
		model.addAttribute("updateForm", updateForm);
		
		List<Region> loc_ud = as.loc_ud1();
		//for (Region l : loc_ud) System.out.println(l.getReg_id() + " : " + l.getReg_name());
		System.out.println("dutchpay/dutchpayUpdateForm loc_ud.size()- >"+loc_ud.size());
		
		model.addAttribute("loc_ud", loc_ud);
		
		return "dutchpay/dutchpayUpdateForm";
	}
	
	@PostMapping(value = "dutchpay/dutchpayWritePro") // 글내용 삽입 (insert) 
	public String insert(Article article ,RedirectAttributes ra, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)  // 로그인한 mem_id를 가지고 글쓰기
			model.addAttribute("memberInfo", memberDetails.getMemberInfo()); 
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		
		System.out.println("start insert button");
		System.out.println(article);
		System.out.println("controller insert brd_id  -> "+article.getBrd_id());
		as.dutchpayInsert1(article);
		ra.addFlashAttribute("article", article);  //model.addAttribute와 다른점은 컨트롤러 내에서 매핑할 시 이렇게 사용하는게 좋음
		int brd_id = article.getBrd_id(); //확인 버튼 누르면 드롭다운(카테고리) 에서 고른 해당카테고리로 이동 
		return "redirect:/board/dutchpay?category="+brd_id;
	}
	
	//detail에서 쓰던 brd_id,article_id,trd_id들을 가져온 updateForm에서 그것들을 사용해 update
	@PostMapping(value = "dutchpay/dutchpayUpdatePro") //글내용 수정(update)
	public String update(Article article, RedirectAttributes ra, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		
		System.out.println("start update button");
		System.out.println(article);
		System.out.println("controller update brd_id -> "+article.getBrd_id());
		System.out.println("controller update art_id -> "+article.getArt_id());
		as.dutchpayUpdate1(article);
		ra.addFlashAttribute("article", article);  
		int brd_id = article.getBrd_id();
		return "redirect:/board/dutchpay?category="+brd_id;
	}
	
	@PostMapping(value = "/dutchpay/dutchpayDelete") //게시글 삭제
	public String delete(Article article, RedirectAttributes ra, Model model , @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		
		System.out.println("start delete button");
		System.out.println("controller delete brd_id -> "+article.getBrd_id());
		System.out.println("controller delete isdelete -> "+article.getIsdelete());
		as.dutchpayDelete1(article);
		ra.addFlashAttribute("article",article);
		int brd_id = article.getBrd_id();
		return "redirect:/board/dutchpay?category="+brd_id;
	}

	@RequestMapping("/joinForm") // 상세게시글의 신청하기 버튼 (새창 띄우기)
	public String joinForm(Article article, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		
		Article detail = as.detail1(article); 
		model.addAttribute("detail", detail);
		System.out.println("controller confirm brd_id -> "+detail.getBrd_id());
		System.out.println("controller confirm art_id -> "+detail.getArt_id());
		System.out.println("controller confirm trd_id -> "+detail.getTrd_id());
	    return "dutchpay/JoinForm";
	}
	
	@PostMapping(value = "/dutchpay/ApplyInsert") // 신청서의 신청하기 버튼 (waiting테이블에 insert)
	public String Apply(Article article, Model model, RedirectAttributes ra, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		
		as.applyInsert1(article);
		model.addAttribute("article", article);
//		ra.addFlashAttribute("article", article);

		int brd_id = article.getBrd_id();
		int art_id = article.getArt_id(); 
//		"redirect:/board/dutchpay?category="+brd_id+"&art_id="+art_id;
		return "/dutchpay/ApplyInsert"; // 창이 닫히도록 설정
	}
	
	@PostMapping(value = "dutchpay/applyCancel") // 신청서의 신청취소하기 버튼 (waiting테이블에 delete)
	public String applyCancel(int trd_id, Article article, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		
		int cancel = as.applyCancel1(trd_id);
		
		int brd_id = article.getBrd_id();
		int art_id = article.getArt_id(); 
		return "redirect:/dutchpay/dutchpayDetail?brd_id="+brd_id+"&art_id="+art_id;
	}
	
	@GetMapping(value = "/dutchpay/JoinDeny") // 거부 버튼 (mem_id)가 따라다니도록 Detail.jsp에서 function설정
	public String joinDeny(Article article, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
//		 article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		System.out.println("Controller article -> "+article);
		
		
		Article joinDeny = as.joinDeny1(article);
		model.addAttribute("waitList",joinDeny);
		
		int brd_id = article.getBrd_id();
		int art_id = article.getArt_id(); 
		return "redirect:/dutchpay/dutchpayDetail?brd_id="+brd_id+"&art_id="+art_id;
	}
	
	@GetMapping(value = "/dutchpay/JoinAccept") // 수 버튼 (mem_id)가 따라다니도록 Detail.jsp에서 function설정
	public String joinAccept(Article article, Model model, @AuthenticationPrincipal MemberDetails memberDetails) {
		
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
//		 article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		System.out.println("Controller article -> "+article);
		
		
		Article joinAccept = as.joinAccept1(article);
		model.addAttribute("waitList",joinAccept);
		
		int brd_id = article.getBrd_id();
		int art_id = article.getArt_id(); 
		return "redirect:/dutchpay/dutchpayDetail?brd_id="+brd_id+"&art_id="+art_id;
	}
	
}
