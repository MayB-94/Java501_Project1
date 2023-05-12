package com.java501.S20230401.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.Paging;
import com.java501.S20230401.service.ReplyService;
import com.sun.net.httpserver.Authenticator.Result;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 커뮤니티 페이지 계열 컨트롤러 : 백준
@Controller
@RequiredArgsConstructor
@Slf4j
public class CommunityController {
	private final ArticleService as;
	private final ReplyService rs;
	
	@RequestMapping(value = "board/community")
	public String communityList(@AuthenticationPrincipal MemberDetails memberDetails, Article article, 
														int category, String currentPage, Model model) 
	{
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		article.setBrd_id(category);
		int brd_id = category;
		System.out.println("CommunityController 시작");
		int totalArticle = as.totalArticle(category);
		System.out.println("CommunityController totalArticle->"+totalArticle);
		
		model.addAttribute("totalArticle", totalArticle);
		Paging page = new Paging(totalArticle, currentPage);
		System.out.println("page"+page);
		article.setStart(page.getStart());
		article.setEnd(page.getEnd());
		
		Map<Integer, String> boardMap = new HashMap<>();
	    boardMap.put(1310, "일상수다");
	    boardMap.put(1320, "자랑하기");
	    boardMap.put(1330, "홍보하기");
	    boardMap.put(1340, "질문/요청");
	    model.addAttribute("boardMap", boardMap);
	    model.addAttribute("totalArticle", totalArticle);
	    model.addAttribute("page", page);
	    model.addAttribute("brd_id", brd_id);
	    model.addAttribute("category", category);
	    
	    article.setBrd_id(brd_id);
		if(brd_id == 1300) {
			List<Article> listArticle = as.articleTotal(article);
			model.addAttribute("listArticle", listArticle);
		}else {
			List<Article> menuArticle = as.articleMenu(article);
		    model.addAttribute("listArticle", menuArticle);
		}
		
		
		return "community/communityIndex";
	}
	
	@RequestMapping(value = "board/community/bjSearch")
	public String bjSearch(@AuthenticationPrincipal MemberDetails memberDetails, Article article,
													int category, String currentPage, Model model) 
	{
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("검색 컨트롤러 시작");
		
		int totalArticle = as.totalArticle(article.getBrd_id());
		model.addAttribute("totalArticle", totalArticle);
		
		Paging page = new Paging(totalArticle, currentPage);
		System.out.println("page"+page);
		article.setStart(page.getStart());
		article.setEnd(page.getEnd());
		
		Map<Integer, String> boardMap = new HashMap<>();
	    boardMap.put(1310, "일상수다");
	    boardMap.put(1320, "자랑하기");
	    boardMap.put(1330, "홍보하기");
	    boardMap.put(1340, "질문/요청");
	    model.addAttribute("boardMap", boardMap);
	    
		List<Article> bjSearch = as.bjArtSearch(article);
	    model.addAttribute("listArticle", bjSearch);
	    model.addAttribute("article", article);
	    model.addAttribute("page", page);
	    model.addAttribute("category", category);
	    
		
		return "community/communityIndex";
	}
	
	@GetMapping(value = "board/community/detailContent")
	public String detailContent(HttpServletRequest request, @AuthenticationPrincipal MemberDetails memberDetails, 
										Article article, int category, Model model, HttpServletResponse response) 
	{
	    if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
	    System.out.println("CommunityController detail 시작");
	    System.out.println("아티클정보"+article);
//	    Integer readCount = as.upreadCount(article);
//	    System.out.println("업데이트 결과  =>"+readCount);
	    
	    // 쿠키 중복 체크
	    Cookie oldCookie = null;
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("readcookie")) {
	                oldCookie = cookie;
	                log.info("\n쿠키 이름 {} 쿠키 값 {}",cookie.getName(), cookie.getValue());
	            }
	        }
	    }

	    if (oldCookie == null) {
	        as.upreadCount(article); // 조회수 업데이트
	        Cookie newCookie = new Cookie("readcookie", "[" + article.getArt_id() + "_" + article.getBrd_id() + "]");
	        newCookie.setPath("/");
	        				// 60초  60분  24시간
	        newCookie.setMaxAge(60 * 60 * 24);
	        response.addCookie(newCookie); // 쿠키 저장
	    }else if (!oldCookie.getValue().contains("[" + article.getArt_id() + "_" + article.getBrd_id() + "]")) {
	    	as.upreadCount(article); // 조회수 업데이트
	    	oldCookie.setValue(oldCookie.getValue()+("[" + article.getArt_id() + "_" + article.getBrd_id() + "]"));
	    	oldCookie.setPath("/");
	    	// 60초  60분  24시간
	    	oldCookie.setMaxAge(60 * 60 * 24);
	    	response.addCookie(oldCookie); // 쿠키 저장
	    }

	    Article detailCon = as.detailContent(article);
	    Reply reply = new Reply();
	    reply.setArt_id(article.getArt_id());
	    reply.setBrd_id(article.getBrd_id());
	    // 댓글 갯수
	    Reply countReply = rs.replyCount(reply);
	    // 댓글 정보
	    List<Reply> replyMain = rs.replyMain(reply);
	    System.out.println("detailContent art_id 값"+article);

	    model.addAttribute("article", detailCon);
	    model.addAttribute("reply", countReply);
	    model.addAttribute("replyMain", replyMain);
	    model.addAttribute("category", category);

	    return "community/detailContent";
	}

	
	
	@RequestMapping(value = "board/community/communityWrite")
	public String communityFormWrite(@AuthenticationPrincipal MemberDetails memberDetails,int category, Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("커뮤니티 폼 라이트 시작");
		
//		List<Article> articleList = as.listMagnager();
//		model.addAttribute("listMagnager", articleList);

//		System.out.println("리스트 아티클"+ articleList);
		model.addAttribute("category", category);
		
		return "community/communityWrite";
	}
	
	@PostMapping(value = "board/community/bjcommunitywrite")
	public String communityWrite(@AuthenticationPrincipal MemberDetails memberDetails,int category, Article article, Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("커뮤니티 라이트 시작");

		System.out.println("커뮤니티 아티클"+article);
		
		int writeResult = as.bjWriteArticle(article);
		model.addAttribute("category", category);
		System.out.println("라이트리절트"+writeResult);
		if(writeResult > 0 ) {
			System.out.println("라이트리절트값"+writeResult);
			return "redirect:/board/community?category="+category;
		}
		else {
			model.addAttribute("msg", "입력 실패 확인하세요");
			return "forward:/board/community/communityWrite";
		}
	}
	
	@GetMapping(value = "board/community/updateForm")
	public String updateForm(@AuthenticationPrincipal MemberDetails memberDetails,int category ,Article article, Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("업데이트 폼 시작");
		
		Article formUpdate = as.detailContent(article);
		
		model.addAttribute("article", formUpdate);
		model.addAttribute("category", category);
		System.out.println("업데이트폼 아티클값"+formUpdate);
		
		return "community/updateForm";
	}
	
	@PostMapping(value = "board/community/bjUpdate")
	public String update(@AuthenticationPrincipal MemberDetails memberDetails,int category, Article article , Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("업데이트 시작");
		
		int updateCount = as.bjUpdateArticle(article);
		
		model.addAttribute("uptCnt", updateCount);
		model.addAttribute("category", category);
		
		return "redirect:/board/community/detailContent?art_id="
												+article.getArt_id()+"&brd_id="+article.getBrd_id()+"&category="+category;
	}
	
	
	@RequestMapping(value = "board/community/bjDelte")
	public String delete(Article article, int category, Model model) {
		System.out.println("삭제 업데이트 시작");
		int delResult = as.delete(article);
		model.addAttribute("category", category);
		
		return "redirect:/board/community?category="+category;
	}
	
	@PostMapping(value = "board/community/bjReplyWrite")
	public String replyWrite(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply , Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("댓글쓰기 컨트롤러 시작");
		int reWrite = as.replyWrite(reply);
		System.out.println("reply 값 ->" + reply);
		model.addAttribute("reply", reWrite);
		
		return "redirect:/board/community/detailContent?art_id="
												+reply.getArt_id()+"&brd_id="+reply.getBrd_id()+"&category="+reply.getBrd_id();   
		
	}
	
	@RequestMapping(value = "board/community/bjReplyDelete")
	public String replyDelete(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply , Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		int reDelete = as.replyDelete(reply);

		return "redirect:/board/community/detailContent?art_id="
												+reply.getArt_id()+"&brd_id="+reply.getBrd_id()+"&category="+reply.getBrd_id();  
	}
	
	@PostMapping(value = "board/community/bjreReply")
	public String bjreReply(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply , Model model) {
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		int reReply = rs.bjreReply(reply);
		
		model.addAttribute("reply", reply);
		System.out.println("대댓글 reply 값 ->" +reply);
		return "redirect:/board/community/detailContent?art_id="
												+reply.getArt_id()+"&brd_id="+reply.getBrd_id()+"&category="+reply.getBrd_id();
	}
	
	@ResponseBody
	@RequestMapping(value = "board/community/bjGood" )
	public Map<String, Object> bjGood(	@AuthenticationPrincipal MemberDetails memberDetails, 
							@RequestBody Article article,
							Model model , HttpServletResponse response,HttpServletRequest request) 
	{
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		Map<String, Object> result = new HashMap<>();

		Cookie oldCookie = null;
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("bjGood")) {
	                oldCookie = cookie;
	                log.info("\n쿠키 이름 {} 쿠키 값 {}",cookie.getName(), cookie.getValue());
	            }
	        }
	    }

	    if (oldCookie == null) {
	    	as.bjGood(article); 
	        Cookie newCookie = new Cookie("bjGood", "[" + article.getArt_id() + "_" + article.getBrd_id() + "]");
	        newCookie.setPath("/");
	        				// 60초  60분  24시간
	        newCookie.setMaxAge(60 * 60 * 24);
	        response.addCookie(newCookie); 
	        result.put("bjGsuccess" , true );
		    result.put("bjGoodCnt" , article.getArt_good() );
		    System.out.println("추천 아작스 쿠키 1 ->"+result);
	    }else if (!oldCookie.getValue().contains("[" + article.getArt_id() + "_" + article.getBrd_id() + "]")) {
	    	as.bjGood(article);
	    	oldCookie.setValue(oldCookie.getValue()+("[" + article.getArt_id() + "_" + article.getBrd_id() + "]"));
	    	oldCookie.setPath("/");
	    	// 60초  60분  24시간
	    	oldCookie.setMaxAge(60 * 60 * 24);
	    	response.addCookie(oldCookie); // 쿠키 저장
	    	result.put("bjGsuccess" , true );
		    result.put("bjGoodCnt" , article.getArt_good() );
		    System.out.println("추천 아작스 쿠키 2 ->"+result);
	    }else {
	    	result.put("success" , false );
	    	log.info("추천 아작스 쿠키 3 ->{}"+result);
	    }
	    log.info("추천 아작스 쿠키 4 ->{}"+result);
	    return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "board/community/bjBad" )
	public Map<String, Object> bjBad(	@AuthenticationPrincipal MemberDetails memberDetails, 
			@RequestBody Article article,
			Model model , HttpServletResponse response,HttpServletRequest request) 
	{
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		Map<String, Object> result = new HashMap<>();
		
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("bjBad")) {
					oldCookie = cookie;
					log.info("\n쿠키 이름 {} 쿠키 값 {}",cookie.getName(), cookie.getValue());
				}
			}
		}
		
		if (oldCookie == null) {
			as.bjBad(article); 
			Cookie newCookie = new Cookie("bjBad", "[" + article.getArt_id() + "_" + article.getBrd_id() + "]");
			newCookie.setPath("/");
			// 60초  60분  24시간
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie); 
			result.put("bjBsuccess" , true );
			result.put("bjBadCnt" , article.getArt_good() );
			System.out.println("비추천 아작스 쿠키 1 ->"+result);
		}else if (!oldCookie.getValue().contains("[" + article.getArt_id() + "_" + article.getBrd_id() + "]")) {
			as.bjBad(article);
			oldCookie.setValue(oldCookie.getValue()+("[" + article.getArt_id() + "_" + article.getBrd_id() + "]"));
			oldCookie.setPath("/");
			// 60초  60분  24시간
			oldCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(oldCookie); // 쿠키 저장
			result.put("bjBsuccess" , true );
			result.put("bjBadCnt" , article.getArt_good() );
			System.out.println("비추천 아작스 쿠키 2 ->"+result);
		}else {
			result.put("success" , false );
			log.info("비추천 아작스 쿠키 3 ->{}"+result);
		}
		log.info("비추천 아작스 쿠키 4 ->{}"+result);
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "board/community/bjReGood" )
	public Map<String, Object> bjReGood(	@AuthenticationPrincipal MemberDetails memberDetails, 
			@RequestBody Reply reply,
			Model model , HttpServletResponse response,HttpServletRequest request) 
	{
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		Map<String, Object> result = new HashMap<>();
		
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("bjReGood")) {
					oldCookie = cookie;
					log.info("\n쿠키 이름 {} 쿠키 값 {}",cookie.getName(), cookie.getValue());
				}
			}
		}
		
		if (oldCookie == null) {
			rs.bjReGood(reply); 
			Cookie newCookie = new Cookie("bjReGood", "[" + reply.getArt_id() + "_" + reply.getBrd_id() + reply.getRep_id()+"]");
			newCookie.setPath("/");
			// 60초  60분  24시간
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie); 
			result.put("bjReGsuccess" , true );
			result.put("bjReGoodCnt" , reply.getRep_good() );
			System.out.println("댓글추천 아작스 쿠키 1 ->"+result);
		}else if (!oldCookie.getValue().contains("[" + reply.getArt_id() + "_" + reply.getBrd_id() + reply.getRep_id()+"]")) {
			rs.bjReGood(reply);
			oldCookie.setValue(oldCookie.getValue()+("[" + reply.getArt_id() + "_" + reply.getBrd_id() + reply.getRep_id()+ "]"));
			oldCookie.setPath("/");
			// 60초  60분  24시간
			oldCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(oldCookie); // 쿠키 저장
			result.put("bjReGsuccess" , true );
			result.put("bjReGoodCnt" , reply.getRep_good() );
			System.out.println("댓글추천 아작스 쿠키 2 ->"+result);
		}else {
			result.put("success" , false );
			log.info("댓글추천 아작스 쿠키 3 ->{}"+result);
		}
		log.info("댓글추천 아작스 쿠키 4 ->{}"+result);
		return result;
	}
	@ResponseBody
	@RequestMapping(value = "board/community/bjReBad" )
	public Map<String, Object> bjReBad(	@AuthenticationPrincipal MemberDetails memberDetails, 
			@RequestBody Reply reply,
			Model model , HttpServletResponse response,HttpServletRequest request) 
	{
		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		Map<String, Object> result = new HashMap<>();
		
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("bjReBad")) {
					oldCookie = cookie;
					log.info("\n쿠키 이름 {} 쿠키 값 {}",cookie.getName(), cookie.getValue());
				}
			}
		}
		
		if (oldCookie == null) {
			rs.bjReBad(reply); 
			Cookie newCookie = new Cookie("bjReGood", "[" + reply.getArt_id() + "_" + reply.getBrd_id() + reply.getRep_id()+"]");
			newCookie.setPath("/");
			// 60초  60분  24시간
			newCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(newCookie); 
			result.put("bjReBsuccess" , true );
			result.put("bjReBadCnt" , reply.getRep_bad() );
			System.out.println("댓글비추천 아작스 쿠키 1 ->"+result);
		}else if (!oldCookie.getValue().contains("[" + reply.getArt_id() + "_" + reply.getBrd_id() + reply.getRep_id()+"]")) {
			rs.bjReBad(reply); 
			oldCookie.setValue(oldCookie.getValue()+("[" + reply.getArt_id() + "_" + reply.getBrd_id() + reply.getRep_id()+ "]"));
			oldCookie.setPath("/");
			// 60초  60분  24시간
			oldCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(oldCookie); // 쿠키 저장
			result.put("bjReBsuccess" , true );
			result.put("bjReBadCnt" , reply.getRep_bad() );
			System.out.println("댓글비추천 아작스 쿠키 2 ->"+result);
		}else {
			result.put("success" , false );
			log.info("댓글비추천 아작스 쿠키 3 ->{}"+result);
		}
		log.info("댓글비추천 아작스 쿠키 4 ->{}"+result);
		return result;
	}
	
	
	
	
	
	
//	@RequestMapping(value = "bjReport")
	
}

