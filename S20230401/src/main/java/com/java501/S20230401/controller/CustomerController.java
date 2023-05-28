package com.java501.S20230401.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.CommService;
import com.java501.S20230401.service.Paging;
import com.java501.S20230401.service.ReplyService;

import lombok.RequiredArgsConstructor;

// 고객센터 페이지 계열 컨트롤러 : 최승환
//@Controller
@RequiredArgsConstructor
public class CustomerController {
	
	private final ArticleService 	as;
	private final ReplyService 		rs;
	private final CommService 		cs;
	
	// 고객센터 목록 + 검색
	@RequestMapping(value = "/board/customer")
	public String customerList(@AuthenticationPrincipal MemberDetails mD, 
								Article article, Integer category, String currentPage, Model model ) {
		System.out.println("CustomerController Start customerList..." );
		
		// 유저 정보
		
		if (mD != null) {
			model.addAttribute("memberInfo", mD.getMemberInfo());
		}
		
		// category 값 -> brd_id
		article.setBrd_id(category);
		
		//
		// 접속한 게시판의 카테고리 목록 가져오기
		List<Comm> commList = cs.commList((category / 100 * 100));
		// 접속한 게시판과 카테고리 식별
		String boardName = cs.categoryName(category);
		String categoryName = cs.categoryName(article.getBrd_id());
		//
		
		// 전체 게시글
		int totalCustomer = as.totalCustomer(article);
		System.out.println("CustomerController totalCustomer=>" + totalCustomer);
		
		// Paging 작업
		Paging page = new Paging(totalCustomer, currentPage);
		// Parameter article --> Page만 추가 Setting
		article.setStart(page.getStart());	// 시작시 1
		article.setEnd(page.getEnd());		// 시작시 10
		
		// 게시글 리스트
		List<Article> listCustomer = as.listCustomer(article);
		
		/*
		 * if(brd_id == 1500) { List<Article> listCustomer = as.listCustomer(article);
		 * model.addAttribute("listCustomer", listCustomer); }else { List<Article>
		 * listCustomerMenu = as.listCustomerMenu(article);
		 * System.out.println("컨트롤러 리스트커스터머메뉴"+ listCustomerMenu);
		 * model.addAttribute("listCustomer", listCustomerMenu); }
		 */
			
//		model.addAttribute("brd_id", brd_id);
		model.addAttribute("articleList", listCustomer);
		model.addAttribute("totalArt", totalCustomer);
		model.addAttribute("page", page);
		model.addAttribute("category", category);
		model.addAttribute("boardName", boardName);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("commList", commList);
		
		return "/customer/customerIndex";
	}
	
	// 게시글, 댓글
//	@GetMapping(value = "/board/customer/detailCustomer")
	@GetMapping(value = "/board/customer/{art_id}")
	public String detailCustomer(@AuthenticationPrincipal MemberDetails mD, @PathVariable("art_id") String art_id,
								HttpServletRequest request, HttpServletResponse response,
								Article article, Integer category, Model model) {
		
		// url
		try {
		    article.setArt_id(Integer.parseInt(art_id));
		} catch (NumberFormatException e) {
			 System.out.println("오류확인");
		}
		
		// 유저 정보
//		String mem_id = "";   //쿠키
		MemberInfo memberInfo = null;
		if (mD != null) {
			memberInfo = mD.getMemberInfo();
//			mem_id = Integer.toString(memberInfo.getMem_id());
			model.addAttribute("memberInfo", memberInfo);
		}
	
		System.out.println("CustomerController Start detailCustomer...");
		
		as.customerViewCount(article);
		
		Article customerDetail = as.detailCustomer(article);
		

		System.out.println("댓글 갯수세기 시작");
		// 댓글 총갯수세기
		// 댓글 목록
		System.out.println("아티클수"+article);
		Reply reply = new Reply();
		reply.setArt_id(article.getArt_id());
		reply.setBrd_id(article.getBrd_id());
		
		category = article.getBrd_id();
		int replyCount = rs.shReplyCount(reply);
		
		// 댓글 정보
		List<Reply> replyList = rs.replyList(article);
		
		// 접속한 게시판과 카테고리 식별
		String boardName = cs.categoryName(category);
		String categoryName = cs.categoryName(article.getBrd_id());
		
		model.addAttribute("article", customerDetail);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("replyList",replyList);
		model.addAttribute("category", category);
		model.addAttribute("boardName", boardName);
		model.addAttribute("categoryName", categoryName);
		
		System.out.println("댓글카운트"+replyCount);
		System.out.println("댓글리스트"+replyList);
		System.out.println("카테고리"+category);
		
		return "/customer/detailCustomer";
	}
	
	//게시글쓰기
	
	@RequestMapping(value = "/board/customer/write")
	public String customerWriteForm(@AuthenticationPrincipal MemberDetails mD,
									Article article, Integer category, Model model) {
		
		// 로그인 유저 정보
		if (mD != null) {
			model.addAttribute("memberInfo", mD.getMemberInfo());
		}
		//
		System.out.println("CustomerController customerWriteForm start");
		
		model.addAttribute("category", category);
		return "/customer/customerWriteForm";
	}
	
	//게시글 작성
	@PostMapping(value = "/board/customer/writeArticleForm")
	public String writeCustomer(@AuthenticationPrincipal MemberDetails mD,
								RedirectAttributes redirectAttributes,
								Article article, Integer category, Model model) {
		
		MemberInfo memberInfo = null;
		redirectAttributes.addFlashAttribute("category", category);
		//
		if(mD != null) {
			memberInfo = mD.getMemberInfo(); 					// 유저 정보 저장
			redirectAttributes.addFlashAttribute("memberInfo", memberInfo);	// 유저 정보 리턴
			article.setMem_id(memberInfo.getMem_id());
		}else {
			System.out.println("로그인 하세요");
			return "redirect:/login";
		}
		//
		
		System.out.println("CustomerController writeCustomer start");
		
		model.addAttribute("category", category);
		int insertResult = as.insertCustomer(article);
		if(insertResult > 0) 
			return "redirect:/board/customer?category="+article.getBrd_id();
		else {
			model.addAttribute("msg","입력 실패 확인해 보세요");
			return "forward:/board/customer/writeCustomer";
		}	
	}
	
	//댓글작성
	
	@PostMapping(value = "/board/customer/replyForm")
	public String customerWriteReply(@AuthenticationPrincipal MemberDetails mD,
									RedirectAttributes redirectAttributes,
									Reply reply, Integer category, Model model) {
		//
		MemberInfo memberInfo = null;
		redirectAttributes.addFlashAttribute("category", category);
		
		if (mD != null) {
			memberInfo = mD.getMemberInfo(); 					// 유저 정보 저장
			redirectAttributes.addFlashAttribute("memberInfo", memberInfo);	// 유저 정보 리턴
			reply.setMem_id(memberInfo.getMem_id());
		}		
		//
		System.out.println("CustomerController customerWriteReply start");
		int result = rs.customerWriteReply(reply);
		System.out.println(result >  0? "댓글성공" : "댓글실패");
		
		return "redirect:/board/customer/"+reply.getArt_id()+"?brd_id="+reply.getBrd_id()+"&category="+category;   
	}
	
	// 댓글 삭제
	@RequestMapping(value = "/board/customer/customerDeleteReply")
	public String customerDeleteReply(@AuthenticationPrincipal MemberDetails mD,
									RedirectAttributes redirectAttributes,
									Reply reply, Model model, Integer category) {
		MemberInfo memberInfo = null;
		if (mD != null) {
			memberInfo = mD.getMemberInfo(); 	
			redirectAttributes.addFlashAttribute("memberInfo", memberInfo);
			reply.setMem_id(memberInfo.getMem_id());
		}else {
			System.err.println("로그인 확인하세요");
			return "redirect:/board/customer/"+reply.getArt_id()+"?brd_id="+reply.getBrd_id()+"&category="+category;
		}	
		System.out.println("customerDeleteReply start");
		int deleteResult = rs.customerDeleteReply(reply);
		model.addAttribute("deleteResult", deleteResult);
		System.out.println(deleteResult >  0? "댓삭성공" : "댓삭실패");
		
		return "redirect:/board/customer/"+reply.getArt_id()+"?brd_id="+reply.getBrd_id()+"&category="+category;
	}
	
	// 댓글 수정
	
	@RequestMapping(value = "/board/customer/customerUpdateReply")
	public String customerUpdateReply(@AuthenticationPrincipal MemberDetails mD,
									  Integer category, Model model, Reply reply) {
		
		if (mD != null) {
			model.addAttribute("memberInfo", mD.getMemberInfo());
		}
		model.addAttribute("category", category);
		model.addAttribute("reply", reply);
		
		// 업데이트
		int result = rs.customerUpdateReply(reply);

		return "redirect:/board/customer/"+ reply.getArt_id()+ "?brd_id=" +reply.getBrd_id()+ "&category=" + category;
	
		
	}
	
	// 게시글 수정 폼
	@GetMapping(value = "/board/customer/updateFormC")
	public String updateFormC(@AuthenticationPrincipal MemberDetails mD,
							  Article article, Integer category, Model model) {
		if (mD != null) {
			model.addAttribute("memberInfo", mD.getMemberInfo());
		}
		System.out.println("CustomerController updateFormC start");
		
	
		Article customFormUpdate = as.detailCustomer(article);
		
		
		model.addAttribute("article", customFormUpdate);
		/* model.addAttribute("categoryList", categoryList); */
		model.addAttribute("category", category);
		
		return "/customer/updateFormC";
	}
	
	//글 수정
	
	@PostMapping(value = "/board/customer/updateCustomer")
	public String updateCustomer(@AuthenticationPrincipal MemberDetails mD, //@PathVariable("art_id") String art_id,
								Article article, Integer category, Model model) {
		
//		article.setArt_id(Integer.parseInt(art_id));
		if (mD != null) {
			model.addAttribute("memberInfo", mD.getMemberInfo());
		}
		System.out.println("CustomerController updateCustomer start");
		
		int update = as.updateCustomer(article);
		
		model.addAttribute("category", category);
		model.addAttribute("upCnt", update);
		
		
		return "redirect:/board/customer/"+article.getArt_id()+"?brd_id="+article.getBrd_id()+"&category="+category;
	}
	
	//글 삭제
	
	@RequestMapping(value = "/board/customer/deleteCustomer")
	public String deleteCustomer(@AuthenticationPrincipal MemberDetails mD,
								 Article article, Integer category, Model model) {
		
		System.out.println("CustomerController deleteCustomer start");
		int dresult = as.deleteCustomer(article);
		model.addAttribute("category", category);
		model.addAttribute("result", dresult);
		
		/*
		 * return
		 * "redirect:/board/customer/"+article.getArt_id()+"?brd_id="+article.getBrd_id(
		 * )+"&category="+category;
		 */
		return "redirect:/board/customer?category="+category;
	}
	
	//글 검색
	
	@RequestMapping(value = "/board/customer/shSearch")
	public String shSearch(@AuthenticationPrincipal MemberDetails mD,
			 			   Article article, String currentPage, Integer category, RedirectAttributes redirectAttributes) {
//		if (mD != null) {
//			model.addAttribute("memberInfo", mD.getMemberInfo());
//		}
//		
//		System.out.println("CustomerController shSearch start");
//		
//		int totalCustomer = as.totalCustomer(article);
//		Paging page = new Paging(totalCustomer, currentPage);
//		article.setStart(page.getStart());
//		article.setEnd(page.getEnd());
//		
//		List<Article> shSearchCustomer = as.shSearchCustomer(article);
//		
//		model.addAttribute("totalCustomer", totalCustomer);
//		model.addAttribute("listCustomer", shSearchCustomer);
//		model.addAttribute("page", page);
//		model.addAttribute("category", category);
		redirectAttributes.addFlashAttribute("article", article);
		return "redirect:/board/customer?category="+category;
	}
	
	// 추천
	@ResponseBody
	@RequestMapping(value = "/board/customer/shcustomLike")
	public int customLike(@AuthenticationPrincipal MemberDetails mD,
							Article article, Integer category, Model model,		
							RedirectAttributes redirectAttributes,
							HttpServletRequest request, HttpServletResponse response) {
		if (mD != null) {
			model.addAttribute("memberInfo", mD.getMemberInfo());
		}
		
		System.out.println("CustomerController customLike start");
		
		int result = as.customLike(article);
		
//		int brd_id = article.getBrd_id();
//		int art_id = article.getArt_id();
		model.addAttribute("article", article);
		model.addAttribute("category", category);
		
		return result;
	}
	
	// 비추천
	@ResponseBody
	@RequestMapping(value = "/board/customer/shcustomDislike")
	public int customDislike(@AuthenticationPrincipal MemberDetails mD,
							Article article, Integer category, Model model,		
							RedirectAttributes redirectAttributes,
							HttpServletRequest request, HttpServletResponse response) {
		if (mD != null) {
			model.addAttribute("memberInfo", mD.getMemberInfo());
		}
		
		System.out.println("CustomerController customDislike start");
		
		int result = as.customDislike(article);
		
//		int brd_id = article.getBrd_id();
//		int art_id = article.getArt_id();
		model.addAttribute("article", article);
		model.addAttribute("category", category);
		
		return result;
	}

}




























