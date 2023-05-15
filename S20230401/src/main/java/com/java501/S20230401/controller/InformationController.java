package com.java501.S20230401.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.Favorite;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.Report;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.CommService;
import com.java501.S20230401.service.FavoriteService;
import com.java501.S20230401.service.Paging;
import com.java501.S20230401.service.ReplyService;
import com.java501.S20230401.service.ReportService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 정보공유 페이지 계열 컨트롤러 : 김찬영
@Controller  
@RequiredArgsConstructor
@Slf4j
public class InformationController {
		
	private final ArticleService as;
	private final ReplyService rs;
	private final FavoriteService fs;
	private final ReportService ps;
	private final CommService 		commService;
	
	
	// 리스트 조회 
	@RequestMapping(value="/board/information")
	public String articleList(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, String currentPage, Model model) {
		// 유저 정보를 다시 리턴  //memberDetails.getMemberInfo() DB의 유저와 대조 & 권한 확인
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		String viewName = "infoindex";
		System.out.println("ArticleController Start listArticle...");
		article.setBrd_id(category);
		//전체 게시글
		int cytotalArticle = as.cytotalArticle();
		System.out.println("ArticleController totalArticle=>" + cytotalArticle);
		
		List<Comm> commList = commService.commList((category / 100 * 100));
		// 접속한 게시판과 카테고리 식별
		String boardName = commService.categoryName(category);
		String categoryName = commService.categoryName(article.getBrd_id());
		
		//페이징
		Paging page = new Paging(cytotalArticle, currentPage);		//전통방식
		article.setStart(page.getStart());
		article.setEnd(page.getEnd());
		
		List<Article> listArticle = as.cylistArticle(article);
		System.out.println("ArticleController list listArticle.size()=>" + listArticle.size());
		
		
		model.addAttribute("article", article);
		model.addAttribute("cytotalArticle", cytotalArticle);
		model.addAttribute("listArticle", listArticle);
		model.addAttribute("page", page);
		model.addAttribute("category", category);
		model.addAttribute("commList", commList);
		//검색 폼 추가
		model.addAttribute("searchForm", true);

		return "information/" + viewName;
		
	}

	
//	// 상세페이지 확인 (원본)
	@RequestMapping(value="/board/information/{art_number}")
	public String detail(@AuthenticationPrincipal MemberDetails memberDetails, @PathVariable("art_number")String art_number, Article article, Reply reply, Integer category, Model model, HttpServletRequest request, HttpServletResponse response) {
		Integer art_id = Integer.parseInt(art_number);
		Integer brd_id = null;
		Integer mem_id = null;
	    if (memberDetails != null) {
	    	MemberInfo memberInfo = memberDetails.getMemberInfo();
	        model.addAttribute("memberInfo", memberInfo);
	        mem_id = memberInfo.getMem_id();
	    }
	    article.setArt_id(art_id);
	    reply.setArt_id(art_id);
	    
	    brd_id = article.getBrd_id();
	    
	    Article articleDetail = as.cyArticlereadDetail(article); // DB에서 불러오기
	    System.out.println("controller detail; Article result" + articleDetail);
	    System.out.println("detail Start...");

	    // 쿠키를 이름(name) 중복 확인
		Cookie oldCookie = null;	// oldCookie 객체 생성
	    Cookie[] cookies = request.getCookies();	// cookies 배열에 모든 쿠키를 담는다.
	    if (cookies != null) {			// 쿠키가 있으면?
	         for (Cookie cookie : cookies) {	// 쿠키들로 반복문을 돌려서
	            if (cookie.getName().equals("ArticleView")) {	// 이름이 viewArticle인 쿠키가 있으면?
	               oldCookie = cookie;	// 쿠키를 내 oldCookie에 담는다.
	            }
	         }
	      }
	    // 쿠키 값(value) 중복 확인
	     if (oldCookie != null) {				// oldCookie가 있으면 그걸 가져와서 값을 설정해준다.
	          if (!oldCookie.getValue().contains(String.format("[%s_%s_%s]", art_id, brd_id, mem_id))) {
	        	  articleDetail.setArt_read(articleDetail.getArt_read() + 1); // 조회수 증가
	        	as.cyupdateView(article);
	        	  
	        	oldCookie.setValue(oldCookie.getValue() + String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
	            oldCookie.setPath("/");
	            oldCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
	            response.addCookie(oldCookie);
	          } 
	      } else {								// oldCookie가 없으면 newCookie를 새로 만든다.
	    	  articleDetail.setArt_read(articleDetail.getArt_read() + 1); // 조회수 증가
	    	  	as.cyupdateView(article);
	    	  	Cookie newCookie = new Cookie("ArticleView", String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
	              
	            newCookie.setPath("/");
	            newCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
	            response.addCookie(newCookie);
	      }
	    
	    // 댓글 리스트
	    List<Reply> replyAll = rs.replyAll(reply);
	    System.out.println("ArticleController 댓글 리스트 replyAll.size()=>" + replyAll.size());

	    model.addAttribute("replyAll", replyAll);
	    model.addAttribute("reply", reply);
	    model.addAttribute("category", category);
	    model.addAttribute("article", articleDetail);
	    return "/information/detail";
	}
	
	//댓글 작성
	@PostMapping(value="/board/information/replyWrite")
	public String write(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply, Model model, Integer category, RedirectAttributes redirectAttributes) throws Exception {
		MemberInfo memberInfo = null;
		redirectAttributes.addFlashAttribute("category", category);
		
		if(memberDetails != null) {
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
			reply.setMem_id(memberDetails.getMemberInfo().getMem_id());
		}
		System.out.println("reply write Start...");
		
		int result = rs.cywriteReply(reply);
		System.out.println("댓글작성 시작");
//		log.info("값 확인 {}", reply);
		return "redirect:/board/information/"+reply.getArt_id()+ "?brd_id=" +reply.getBrd_id()+ "&category=" + category;
	}
	
	
	//댓글 삭제
	@RequestMapping(value="/board/information/replydelete")
	public String delete(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply, Model model, Integer category) throws Exception {
		// 유저 정보를 다시 리턴  //memberDetails.getMemberInfo() DB의 유저와 대조 & 권한 확인
		if(memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("reply delete Start...");
		
		System.out.println(reply);
		log.info("\n글번호 {} \n게시판번호 {} \n댓글번호 {} ",reply.getArt_id(), reply.getBrd_id(), reply.getRep_id());
		
		
		int result = rs.cydeleteReply(reply);
		System.out.println("댓글삭제 시작");
		return "redirect:/board/information/"+reply.getArt_id()+ "?brd_id=" +reply.getBrd_id()+ "&category=" + category;
	}
	
	
	//댓글 수정
	@RequestMapping(value="/board/information/updateReply", method = RequestMethod.POST)
	public String update(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply, Model model, Integer category) throws Exception {
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("reply update Start...");
		model.addAttribute("category", category);
		model.addAttribute("reply", reply);
		System.out.println(reply);
		log.info("\n글번호 {} \n게시판번호 {} \n댓글번호 {}  \n댓글내용 {} ",reply.getArt_id(), reply.getBrd_id(), reply.getRep_id(), reply.getRep_content());
		
		
		int result = rs.cyupdateReply(reply);
		System.out.println("댓글수정 시작");
		return "redirect:/board/information/detail?art_id=" +reply.getArt_id()+ "&brd_id=" +reply.getBrd_id()+ "&category=" + category;
	}
	

	//댓글 추천(좋아요)
	@RequestMapping(value="/board/information/replyupdategood")
	public String replyupdategood(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply, Integer category, Model model) {
		if(memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		int result = rs.replyupdategood(reply);
		model.addAttribute("category", category);
		model.addAttribute("reply", reply);
		System.out.println("rep_good Start...");
		int brd_id = reply.getBrd_id();
		int art_id = reply.getArt_id();
		return "redirect:/board/information/"+reply.getArt_id()+ "?brd_id=" +reply.getBrd_id()+ "&category=" + category;
	}
	
	
	
	// 댓글 비추천(싫어요)
	@RequestMapping(value="/board/information/replyupdatebad")
	public String replyupdatebad(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply, Integer category, Model model) {
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		int result = rs.replyupdatebad(reply);
		model.addAttribute("category", category);
		model.addAttribute("article", result);
		System.out.println("art_bad Start...");
		int brd_id = reply.getBrd_id();
		int art_id = reply.getArt_id();
		return "redirect:/board/information/"+reply.getArt_id()+ "?brd_id=" +reply.getBrd_id()+ "&category=" + category;
	}
	
	
//	// 추천
//	@RequestMapping(value="/board/information/updategood")
//	public String updategood(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, Model model) {
//		if(memberDetails != null)
//		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
//
//		int result = as.cyupdateGood(article);
//		model.addAttribute("category", category);
//		model.addAttribute("article", article);
//		System.out.println("art_good Start...");
//		int brd_id = article.getBrd_id();
//		int art_id = article.getArt_id();
//		return "redirect:/board/information/detail?art_id=" + art_id + "&brd_id=" + brd_id + "&category=" + category;
//	}
//	
//	// 추천
	@RequestMapping(value="/board/information/updategood")
	public String updategood(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, Model model, HttpServletRequest request, HttpServletResponse response) {
		Integer art_id = article.getArt_id();
		Integer brd_id = article.getBrd_id();
		Integer mem_id = null;
		 if (memberDetails != null) {
		    	MemberInfo memberInfo = memberDetails.getMemberInfo();
		        model.addAttribute("memberInfo", memberInfo);
		        mem_id = memberInfo.getMem_id();
		  }
		    
		    Article updategood = as.cyArticlereadDetail(article); // DB에서 불러오기
		    System.out.println("controller detail; Article result" + updategood);
		    System.out.println("detail Start...");
		    
			model.addAttribute("category", category);
			model.addAttribute("article", article);
			System.out.println("art_good Start...");
		
			// 쿠키를 이름(name) 중복 확인
			Cookie oldCookie = null;	// oldCookie 객체 생성
		    Cookie[] cookies = request.getCookies();	// cookies 배열에 모든 쿠키를 담는다.
		    if (cookies != null) {			// 쿠키가 있으면?
		         for (Cookie cookie : cookies) {	// 쿠키들로 반복문을 돌려서
		            if (cookie.getName().equals("ArticleGood")) {	// 이름이 viewArticle인 쿠키가 있으면?
		               oldCookie = cookie;	// 쿠키를 내 oldCookie에 담는다.
		            }
		         }
		      }
		    // 쿠키 값(value) 중복 확인
		     if (oldCookie != null) {				// oldCookie가 있으면 그걸 가져와서 값을 설정해준다.
		          if (!oldCookie.getValue().contains(String.format("[%s_%s_%s]", art_id, brd_id, mem_id))) {
		        	  updategood.setArt_read(updategood.getArt_good() + 1); // 조회수 증가
		        	as.cyupdateGood(article);
		        	  
		        	oldCookie.setValue(oldCookie.getValue() + String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
		            oldCookie.setPath("/");
		            oldCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		            response.addCookie(oldCookie);
		          } 
		      } else {								// oldCookie가 없으면 newCookie를 새로 만든다.
		    	  updategood.setArt_read(updategood.getArt_good() + 1); // 조회수 증가
		    	  	as.cyupdateGood(article);
		    	  	Cookie newCookie = new Cookie("ArticleGood", String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
		              
		            newCookie.setPath("/");
		            newCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		            response.addCookie(newCookie);
		      }
		    
		
		
		return "redirect:/board/information/detail?art_id=" + art_id + "&brd_id=" + brd_id + "&category=" + category;
	}
	
	// 비추천
	@RequestMapping(value="/board/information/updatebad")
	public String updatebad(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, Model model) {
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		int result = as.cyupdateBad(article);
		model.addAttribute("category", category);
		model.addAttribute("article", result);
		System.out.println("art_bad Start...");
		int brd_id = article.getBrd_id();
		int art_id = article.getArt_id();
		return "redirect:/board/information/detail?art_id=" + art_id + "&brd_id=" + brd_id + "&category=" + category;
	}
		
	
	
	
	
	// 상세페이지에서 지우기	
	@RequestMapping(value="/board/information/delete")
	public String delete(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, Model model) {
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		Article result = as.cyArticledelete(article);
		System.out.println("delete Start...");
		return "redirect:/board/information?category=1400";
	}
	
	
	// 수정 상세페이지 update로 이동 
	@RequestMapping(value="/board/information/update", method = RequestMethod.GET)
	public String update(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, Model model) {
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		System.out.println("controller updateform Start.. >" + article);
		
		Article result = as.cyArticlereadDetail(article);	//DB에서 불러오기
		
		System.out.println("result = " + result.toString());
		
		model.addAttribute("category", category);
		model.addAttribute("article", result);
		
		
		
		System.out.println("update Start...");
		return "information/update";
		
	}
	
	//게시물 수정 	
	@RequestMapping(value="/board/information/modify", method = RequestMethod.POST)
	public String updateForm(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, Model model)throws Exception{
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		System.out.println("updateform Start..");
		
		model.addAttribute("category", category);
		int result = as.cyArticlemodify(article);
		
		
		return "redirect:/board/information/"+article.getArt_id()+ "?brd_id=" +article.getBrd_id()+ "&category=" + category;
	}
	
	
	//게시물 작성 GET
	@RequestMapping(value = "/board/information/write", method = RequestMethod.GET)
	public String getwrite(@AuthenticationPrincipal MemberDetails memberDetails, Article article,Integer category, Model model) throws Exception {
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("작성 겟 Start...");
		return "information/write";
	}
	
	//게시물 작성POST
	@RequestMapping(value = "/board/information/insert", method = RequestMethod.POST)
	public String insert(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Integer category, Model model) throws Exception {
		if(memberDetails != null) {
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
			article.setMem_id(memberDetails.getMemberInfo().getMem_id());
		}
		System.out.println("작성 포스트 Start...");
		System.out.println("Article =" + article);

		int result = as.cyArticleinsert(article);
		return "redirect:/board/information?category=1400";
	}
	
	//신고하기 
	@RequestMapping(value = "/board/information/report", method = RequestMethod.GET)
	public String report(@AuthenticationPrincipal MemberDetails memberDetails, Integer category, Model model) throws Exception {
		if(memberDetails != null)
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("신고하기...");
		return "information/report";
	}
	
	//신고작성 
	@RequestMapping(value = "/board/information/reportinsert", method = RequestMethod.POST)
	public String reportinsert(@AuthenticationPrincipal MemberDetails memberDetails, Report report, Integer category,  Model model) throws Exception {
		System.out.println("11");
		boolean isReported = true;
		model.addAttribute("isReported", isReported);
		if(memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		System.out.println("신고하기 작성...");
		int result = ps.cyReportinsert(report); 
		// member의 report_id에 생성된 report_id를 넣어주어야 함(update)
		return "information/report";
	}
	
	
	//관심 버튼 
	@ResponseBody
	@RequestMapping(value = "/board/information/favorite", method = RequestMethod.POST)
	public String favorite(@AuthenticationPrincipal MemberDetails memberDetails, @RequestBody Favorite favorite, Integer category, Model model) throws Exception {
		if(memberDetails != null) {
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
			favorite.setMem_id(memberDetails.getMemberInfo().getMem_id());
		}
		System.out.println("관심클릭...");
		JSONObject jsonObj = new JSONObject();
		int result = 0;
		if (memberDetails != null) result = fs.cyFavorite(favorite);
		jsonObj.append("result", result);
		return jsonObj.toString();
	}







}