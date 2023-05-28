package com.java501.S20230401.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.Join;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.Trade;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.CommService;
import com.java501.S20230401.service.FavoriteService;
import com.java501.S20230401.service.JoinService;
import com.java501.S20230401.service.Paging;
import com.java501.S20230401.service.RegionService;
import com.java501.S20230401.service.ReplyService;
import com.java501.S20230401.service.WaitingService;

import lombok.RequiredArgsConstructor;
// 함께해요 페이지 계열 컨트롤러 : 임동빈
//@Controller
@RequiredArgsConstructor
public class TogetherController {
	/**

	private final ArticleService as;
	private final ReplyService rs;
	private final CommService cs;
	private final FavoriteService fs;
	private final JoinService js;
	private final WaitingService ws;
	private final RegionService rgs;	

	@RequestMapping(value = "/board/together")
	public String articleList(@AuthenticationPrincipal MemberDetails memberDetails, // 세션의 로그인 유저 정보
			Article article, int category, String currentPage, Model model) {

		// 유저 정보를 다시 리턴 //memberDetails.getMemberInfo() DB의 유저와 대조 & 권한 확인
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());

		// category 값을 brd_id에 할당.
		article.setBrd_id(category);

		// 전체 게시글 개수 Count
		int totalArticle = as.dbtotalArticle(article);

		// Paging 작업
		Paging page = new Paging(totalArticle, currentPage);
		article.setStart(page.getStart()); // 시작시 1
		article.setEnd(page.getEnd());
		
		// 카테고리 리스트
		List<Comm> categoryList = as.categoryName();
		model.addAttribute("categories", categoryList);
		
		// 카테고리 이름
		String categoryName = cs.categoryName(category);

		// 게시글 리스트 작업
		List<Article> listArticle = as.dbListArticle(article);
		
		model.addAttribute("article", article);
		model.addAttribute("totalArticle", totalArticle);
		model.addAttribute("listArticle", listArticle);
		model.addAttribute("category", category);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("page", page);

		return "together/listArticle";
	}
	
	

	@RequestMapping(value = "/board/together/{art_number}")
	public String detailArticle(@AuthenticationPrincipal MemberDetails memberDetails,
								 @PathVariable String art_number,						// 세션의 로그인 유저 정보
								 Article article, Join join, 
								 HttpServletRequest request,
								 HttpServletResponse response,
								 Model model,
								 Integer category) {
		// url의 글번호 저장
		article.setArt_id(Integer.parseInt(art_number));
		
		
		
		int art_id = article.getArt_id();
		int brd_id = article.getBrd_id();

		// 내가 만든 쿠키 (조회수)
		Cookie oldCookie = null;	// oldCookie 객체 생성
	    Cookie[] cookies = request.getCookies();	// cookies 배열에 모든 쿠키를 담는다.
	    if (cookies != null) {			// 쿠키가 있으면?
	         for (Cookie cookie : cookies) {	// 쿠키들로 반복문을 돌려서
	            if (cookie.getName().equals("viewArticle")) {	// 이름이 viewArticle인 쿠키가 있으면?
	               oldCookie = cookie;	// 쿠키를 내 oldCookie에 담는다.
	            }
	         }
	      }
	    
	      if (oldCookie != null) {	// oldCookie가 있으면 그걸 가져와서 값을 설정해준다.
	          if (!oldCookie.getValue().contains(String.format("[%s_%s]", art_id, brd_id))) {
	        	 as.dbReadArticleCnt(article); // 조회수 올리는 메서드
	             oldCookie.setValue(oldCookie.getValue() + String.format("[%s_%s]", art_id, brd_id));
	             oldCookie.setPath("/");
	             oldCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
	             response.addCookie(oldCookie);
	          } 
	      } else {		// oldCookie가 없으면 newCookie를 새로 만든다.
	        	  as.dbReadArticleCnt(article); // 조회수 올리는 메서드
	              Cookie newCookie = new Cookie("viewArticle", String.format("[%s_%s]", art_id, brd_id));
	              newCookie.setPath("/");
	              newCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
	              response.addCookie(newCookie);
	      }
		
		// 상세게시글 요소 구현
		Article detailArticle = as.dbdetailArticle(article);
		model.addAttribute("detailArticle", detailArticle);

		article.setTrd_max(detailArticle.getTrd_max());
		article.setTrd_id(detailArticle.getTrd_id());
		System.out.println(detailArticle.getReg_id());
		
		if (detailArticle.getTrd_status() != 404) {
			// 인원 다 차면 게시글 상태 변경 (진행중)
			as.dbChangeStatus(article);
			// 날짜 다 지나면 게시글 상태 변경 (거래 완료)
			as.dbChangeEndStatus(article);
		}
		
		// 게시글 별 댓글 리스트
		List<Article> replyList = as.dbreplyList(article);
		model.addAttribute("replyList", replyList);
		
		
		// 게시글 별 신청자 리스트
		List<Article> joinList =  as.dbTradeJoinMember(article);
		model.addAttribute("joinList", joinList);
		
		
		// 게시글 별 신청 대기자 리스트
		List<Article> waitingList =  as.dbTradeWaitingMember(article);
		model.addAttribute("waitingList", waitingList);
		
		
		MemberInfo memberInfo = null;
		if (memberDetails != null) {
				memberInfo = memberDetails.getMemberInfo();
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		// 로그인 유저의 정보
		Article shareUser = new Article();
		shareUser.setArt_id(article.getArt_id());
		shareUser.setBrd_id(article.getBrd_id());
		shareUser.setMem_id(memberInfo.getMem_id());
		// 찜 목록 확인
		int userFavorite = fs.dgUserFavorite(shareUser);
		// 대기열 확인
		int userWaiting = ws.dgUserWaiting(shareUser);
		// 거래 목록 확인
		int userJoin = js.shareUserJoin(shareUser);
		
		model.addAttribute("userJoin", userJoin);
		model.addAttribute("userFavorite", userFavorite);
		model.addAttribute("userWaiting", userWaiting);
		}
		
		model.addAttribute("category", category);

		return "together/detailArticle";
	}

	
	
	
	@RequestMapping(value = "/board/together/writeFormArticle")
	public String writeFormArticle(@AuthenticationPrincipal MemberDetails memberDetails,
									Article article, Integer category, Model model) {
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		
		Map<Region, List<Region>> regionHierachy = new HashMap<Region, List<Region>>();
		List<Region> superRegions = rgs.getSuperRegions();
		for (Region sups : superRegions) regionHierachy.put(sups, rgs.getChildRegions(sups.getReg_id()));
		
		// 카테고리별 콤보박스
		List<Comm> categoryList = as.categoryName();
		model.addAttribute("categories", categoryList);

		// 성별 콤보박스
		List<Comm> genderList = as.genderName();
		model.addAttribute("genders", genderList);

		// 지역별 콤보박스
//		List<Region> regionList = as.regionName();
//		model.addAttribute("regions", regionList);

//		// 지역별 부모 콤보박스
//		List<Region> parentRegionList = as.parentRegionName();
//		model.addAttribute("parentRegions", parentRegionList);

		model.addAttribute("superRegions", superRegions);
		model.addAttribute("regions", regionHierachy);
		model.addAttribute("category", category);
		
		return "together/writeFormArticle";
	}

	
	
	@RequestMapping(value = "/board/together/writeArticle")
	public String writeArticle(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Model model,
			@RequestParam("trd_endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date trd_endDate) {
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());

		article.setTrd_enddate(trd_endDate);
		article.setMem_id(memberDetails.getMemberInfo().getMem_id());

		// 프로시저 Insert_Article 이용 => 게시글 작성
		as.dbWriteArticle(article);
		int insertResult = article.getInsert_result();
		int brd_id = article.getBrd_id();
		
		model.addAttribute("insertResult", insertResult);
		model.addAttribute("article", article);

		if (insertResult > 0) {
			return "redirect:/board/together?category=" + brd_id;
		} else {
			model.addAttribute("msg", "입력실패");
			return "forward:/board/together/writeFormArticle";
		}

	}

	@RequestMapping(value = "/board/together/deleteArticle")
	public String deleteArticle(@AuthenticationPrincipal MemberDetails memberDetails, // 세션의 로그인 유저 정보
			Article article, Model model) {

		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		int brd_id = article.getBrd_id();

		// 게시글 삭제 (isdelete = 0 => 1)
		int deleteresult = as.dbdeleteArticle(article);
		model.addAttribute("result", deleteresult);

		return "redirect:/board/together?category="+brd_id;
	}

	
	@RequestMapping(value = "/board/together/updateFormArticle")
	public String updateFormArticle(@AuthenticationPrincipal MemberDetails memberDetails, // 세션의 로그인 유저 정보
			Article article, Integer category, Model model) {

		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		// 게시글 수정 양식 (상세 게시글 값 가져오기)
		Article updateFormArticle = as.dbdetailArticle(article);
		System.out.println(updateFormArticle.getReg_id());
		model.addAttribute("article", updateFormArticle);
		
		Map<Region, List<Region>> regionHierachy = new HashMap<Region, List<Region>>();
		List<Region> superRegions = rgs.getSuperRegions();
		for (Region sups : superRegions) regionHierachy.put(sups, rgs.getChildRegions(sups.getReg_id()));

		// 카테고리별 콤보박스
		List<Comm> categoryList = as.categoryName();
		model.addAttribute("categories", categoryList);

		// 성별 콤보박스
		List<Comm> genderList = as.genderName();
		model.addAttribute("genders", genderList);

		// 지역별 콤보박스
		//List<Region> regionList = as.regionName();
		//model.addAttribute("regions", regionList);

		// 지역별 부모 콤보박스
		List<Region> parentRegionList = as.parentRegionName();
		model.addAttribute("parentRegions", parentRegionList);
		
		// 조인리스트
		List<Article> joinList =  as.dbTradeJoinMember(updateFormArticle);
		model.addAttribute("joinList", joinList);
		
		model.addAttribute("isAnyoneJoined", joinList.size()>1 ? true:false);
		model.addAttribute("superRegions", superRegions);
		model.addAttribute("regions", regionHierachy);
		model.addAttribute("category", category);

		return "together/updateFormArticle";
	}

	@RequestMapping(value = "/board/together/updateArticle")
	public String updateArticle(@AuthenticationPrincipal MemberDetails memberDetails, // 세션의 로그인 유저 정보
								Article article, Trade trade, Model model, Integer category,
								@RequestParam("trd_endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date trd_endDate) {

		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());

		article.setTrd_enddate(trd_endDate);
		
		// 게시글 수정 (프로시저 사용 => Update_Article)
		as.dbUpdateArticle(article);
		
		int updateArticle = article.getInsert_result();
		int brd_id = article.getBrd_id();

		model.addAttribute("article", article);

		if (updateArticle > 0) {
			return "redirect:/board/together?category=" + brd_id;
		} else {
			model.addAttribute("msg", "입력실패");
			return "forward:/board/updateFormArticle";
		}
	}

	// 댓글 입력
	@RequestMapping(value = "/board/insertReply")
	public String insertReply(@AuthenticationPrincipal MemberDetails memberDetails, // 세션의 로그인 유저 정보
			Reply reply, Model model) {

		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());

		reply.setMem_id(memberDetails.getMemberInfo().getMem_id());

		int insertReply = rs.dbInsertReply(reply);

		int art_id = reply.getArt_id();
		int brd_id = reply.getBrd_id();

		model.addAttribute("insertReply", insertReply);

		return "redirect:/board/together/" + art_id +"?brd_id="+ brd_id + "&category=1000";
	}
	
	
	// 댓글 삭제
	@RequestMapping(value = "/board/deleteReply")
	public String deleteReply(@AuthenticationPrincipal MemberDetails memberDetails, // 세션의 로그인 유저 정보
			Reply reply, Model model) {
		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());

		int deleteReply = rs.dbDeleteReply(reply);

		int art_id = reply.getArt_id();
		int brd_id = reply.getBrd_id();
		model.addAttribute("deleteReply", deleteReply);

		return "redirect:/board/together/" + art_id +"?brd_id="+ brd_id + "&category=1000";
	}

	// 댓글 수정
	@RequestMapping(value = "/board/updateReply")
	@ResponseBody
	public String updateReply(@AuthenticationPrincipal MemberDetails memberDetails, // 세션의 로그인 유저 정보
			@RequestBody Reply reply, Model model) {

		JSONObject jsonObj = new JSONObject();

		if (memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());

		int updateReply = rs.dbUpdateReply(reply);
		// String updateReply = Integer.toString(updateReply);

		// int art_id = reply.getArt_id();
		// int brd_id = reply.getBrd_id();

		model.addAttribute("updateReply", updateReply);

		jsonObj.append("result", updateReply);
		jsonObj.append("content", reply.getRep_content());

		return jsonObj.toString();
	}

	// 게시글 신고폼
	 @RequestMapping(value="/board/ArticleReportForm")
	 public String reportFormArticle(@AuthenticationPrincipal MemberDetails memberDetails
			 						, @RequestParam int art_id
			 						, @RequestParam int brd_id
			 						, @RequestParam(required = false, value="report_id") Integer report_id
			 						, Model model) {
	 
	 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());

	 Article article = new Article();
	 article.setArt_id(art_id);
	 article.setBrd_id(brd_id);
	 article.setReport_id(report_id);
	 
	 model.addAttribute("article", article);
	 
	 return "together/ArticleReportForm";

	 }
	 
	 // 게시글 신고 (ajax 사용)
	 @RequestMapping(value="/board/ArticleReport")
	 @ResponseBody
	 public String reportArticle(@AuthenticationPrincipal MemberDetails memberDetails,
			 					 @RequestBody Article article, Model model) {
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 
		 
		 as.dbReportArticle(article);
		 int result = article.getInsert_result();
		 System.out.println(result);
		 
		 jsonObj.append("result", result);
		 jsonObj.append("content", article.getReport_content());
		 
		 return jsonObj.toString();
	 }
	 
	// 댓글 신고폼
	 @RequestMapping(value="/board/ReplyReportForm")
	 public String reportFormReply(@AuthenticationPrincipal MemberDetails memberDetails
			 						, @RequestParam int art_id
			 						, @RequestParam int brd_id
			 						, @RequestParam int rep_id
			 						, @RequestParam(required = false, value="report_id") Integer report_id
			 						, Model model) {
	 
	 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());

	 Article article = new Article();
	 article.setArt_id(art_id);
	 article.setBrd_id(brd_id);
	 article.setRep_id(rep_id);
	 article.setReport_id(report_id);

	 model.addAttribute("article", article);
	 
	 return "together/ReplyReportForm";

	 }
	 
	 // 댓글 신고 (ajax 사용)
	 @RequestMapping(value="/board/ReplyReport")
	 @ResponseBody
	 public String reportReply(@AuthenticationPrincipal MemberDetails memberDetails,
			 				   @RequestBody Article article, Model model) {
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 
		 as.dbReportReply(article);
		 int result = article.getInsert_result();
		 
		 jsonObj.append("result", result);
		 jsonObj.append("content", article.getReport_content());
		 
		 return jsonObj.toString() ;
	 }
	 
	 // 거래 신청하기 폼
	 @RequestMapping(value="/board/TradeJoinForm")
	 public String TradeJoinForm(@AuthenticationPrincipal MemberDetails memberDetails
			 						, @RequestParam int art_id
			 						, @RequestParam int brd_id
			 						, Model model) {
	 
	 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());

	 Article article = new Article();
	 article.setArt_id(art_id);
	 article.setBrd_id(brd_id);
	 Article detailArticle = as.dbdetailArticle(article);
	 
	 // article.setMem_id(memberDetails.getMemberInfo().getMem_id());
	 
	 model.addAttribute("article", detailArticle);
	 
	 return "together/TradeJoinForm";

	 }
	 
	 // 거래 신청 (ajax 사용)
	 @RequestMapping(value="/board/TradeWaiting")
	 @ResponseBody
	 public String TradeWaiting(@AuthenticationPrincipal MemberDetails memberDetails,
			 					 @RequestBody Article article, Model model) {
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 
		  int TradeWaiting = as.dbTradeWaiting(article);
		 
		  jsonObj.append("result", TradeWaiting);
		 
		 return jsonObj.toString() ;
	 }
	 
	 // 거래 대기자 -> 거래 신청자 수락 (ajax 사용)
	 @RequestMapping(value="/board/joinAccept")
	 @ResponseBody
	 public String TradeJoinAccept(@AuthenticationPrincipal MemberDetails memberDetails,
			 					   @RequestBody Article article, Model model) {
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 
		  int TradeJoinAccept = as.dbTradeJoinAccept(article);
		 
		  jsonObj.append("result", TradeJoinAccept);
		 
		 return jsonObj.toString();
	 }
	 
	 
	 // 거래 대기자 -> 거래 신청자 거절 (ajax 사용)
	 @RequestMapping(value="/board/joinRefuse")
	 @ResponseBody
	 public String TradeJoinRefuse(@AuthenticationPrincipal MemberDetails memberDetails,
			 					   @RequestBody Article article, Model model) {
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 
		  int TradeJoinRefuse = as.dbTradeJoinRefuse(article);
		 
		  jsonObj.append("result", TradeJoinRefuse);
		 
		 return jsonObj.toString();
	 }
	 
	 // 거래 신청자 (Join) -> 취소 (삭제) (ajax)
	 @RequestMapping(value="/board/joinDelete")
	 @ResponseBody
	 public String joinDelete(@AuthenticationPrincipal MemberDetails memberDetails,
			 					   @RequestBody Article article, Model model) {
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 
		 int joinDelete = as.dbJoinDelete(article);
		 
		 jsonObj.append("result", joinDelete);
		 
		 return jsonObj.toString();
	 }
	 
	 // 관심목록 등록
	 @RequestMapping(value="/board/favoriteArticle")
	 @ResponseBody
	 public String favoriteArticle(@AuthenticationPrincipal MemberDetails memberDetails,
	                                @RequestBody Article article, Model model) {
	    
		 String resultStr = "";
	         if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());

	         int favoriteArticle = as.dbfavoriteArticle(article);
	         
	         resultStr =  Integer.toString(favoriteArticle);
	        
	     return resultStr;
	 }
	 
	 // 관심목록 삭제
	 @RequestMapping(value="/board/favoriteArticleDelete")
	 @ResponseBody
	 public String favoriteArticleDelete(@AuthenticationPrincipal MemberDetails memberDetails,
	                                @RequestBody Article article, Model model) {
	    
		 String resultStr = "";
	         if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());

	         int favoriteArticleDelete = as.dbFavoriteArticleDelete(article);
	         
	         resultStr =  Integer.toString(favoriteArticleDelete);
	        
	     return resultStr;
	 }
	 
	 
	 
	// 작성자가 거래를 취소 (거래 취소)
	 @RequestMapping(value="/board/tradeCancel")
	 @ResponseBody
	 public String tradeCancel(@AuthenticationPrincipal MemberDetails memberDetails, @RequestBody Article article, Model model) {	
		 
		String resultStr = "";

		if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());

		int changeCancelStatus = as.dbChangeCancelStatus(article);
		
		resultStr = Integer.toString(changeCancelStatus);
		
		return resultStr;
	 }
	 
	// 게시글 추천 Up
	 @RequestMapping(value="/board/articleGoodUp")
	 @ResponseBody
	 public String ArticleGoodUp(@AuthenticationPrincipal MemberDetails memberDetails,
			 					 @RequestBody Article article, 
			 					 HttpServletRequest request,
								 HttpServletResponse response,
								 Model model) {
		 
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 int art_id = article.getArt_id();
		 int brd_id = article.getBrd_id();
		 int mem_id = memberDetails.getMemberInfo().getMem_id();
		 
			Cookie oldCookie = null;	// oldCookie 객체 생성
		    Cookie[] cookies = request.getCookies();	// cookies 배열에 모든 쿠키를 담는다.
		    if (cookies != null) {			// 쿠키가 있으면?
		         for (Cookie cookie : cookies) {	// 쿠키들로 반복문을 돌려서
		            if (cookie.getName().equals("ArticleGoodUp")) {	// 이름이 viewArticle인 쿠키가 있으면?
		               oldCookie = cookie;	// 쿠키를 내 oldCookie에 담는다.
		            }
		         }
		      }
		    
		    
		      if (oldCookie != null) {				// oldCookie가 있으면 그걸 가져와서 값을 설정해준다.
		          if (!oldCookie.getValue().contains(String.format("[%s_%s_%s]", art_id, brd_id, mem_id))) {
		        	  int ArticleGoodUp = as.dbArticleGoodUp(article); // 추천수 올리는 메서드
		              oldCookie.setValue(oldCookie.getValue() + String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
		              oldCookie.setPath("/");
		              oldCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(oldCookie);
		              jsonObj.append("result", ArticleGoodUp);
		          } 
		      } else {								// oldCookie가 없으면 newCookie를 새로 만든다.
		    	  	  int ArticleGoodUp = as.dbArticleGoodUp(article); // 추천수 올리는 메서드
		              Cookie newCookie = new Cookie("ArticleGoodUp", String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
		              newCookie.setPath("/");
		              newCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(newCookie);
		              jsonObj.append("result", ArticleGoodUp);
		      }
		 
		 return jsonObj.toString();
	 }
	 
		// 게시글 비추천 Up
	 @RequestMapping(value="/board/articleBadUp")
	 @ResponseBody
	 public String ArticleBadUp(@AuthenticationPrincipal MemberDetails memberDetails,
			 					 @RequestBody Article article, 
			 					 HttpServletRequest request,
								 HttpServletResponse response,
								 Model model) {
		 
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 int art_id = article.getArt_id();
		 int brd_id = article.getBrd_id();
		 int mem_id = memberDetails.getMemberInfo().getMem_id();
		 
			Cookie oldCookie = null;	// oldCookie 객체 생성
		    Cookie[] cookies = request.getCookies();	// cookies 배열에 모든 쿠키를 담는다.
		    if (cookies != null) {			// 쿠키가 있으면?
		         for (Cookie cookie : cookies) {	// 쿠키들로 반복문을 돌려서
		            if (cookie.getName().equals("articleBadUp")) {	// 이름이 viewArticle인 쿠키가 있으면?
		               oldCookie = cookie;	// 쿠키를 내 oldCookie에 담는다.
		            }
		         }
		      }
		    
		      if (oldCookie != null) {				// oldCookie가 있으면 그걸 가져와서 값을 설정해준다.
		          if (!oldCookie.getValue().contains(String.format("[%s_%s_%s]", art_id, brd_id, mem_id))) {
		        	  int articleBadUp = as.dbArticleBadUp(article); // 추천수 올리는 메서드
		              oldCookie.setValue(oldCookie.getValue() + String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
		              oldCookie.setPath("/");
		              oldCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(oldCookie);
		              jsonObj.append("result", articleBadUp);
		          } 
		      } else {								// oldCookie가 없으면 newCookie를 새로 만든다.
		    	  	  int articleBadUp = as.dbArticleBadUp(article); // 추천수 올리는 메서드
		              Cookie newCookie = new Cookie("articleBadUp", String.format("[%s_%s_%s]", art_id, brd_id, mem_id));
		              newCookie.setPath("/");
		              newCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(newCookie);
		              jsonObj.append("result", articleBadUp);
		      }
		 
		 return jsonObj.toString();
	 }
	 
	// 댓글 추천 Up
	 @RequestMapping(value="/board/replyGoodUp")
	 @ResponseBody
	 public String ReplyGoodUp(@AuthenticationPrincipal MemberDetails memberDetails,
			 					 @RequestBody Article article, 
			 					 HttpServletRequest request,
								 HttpServletResponse response,
								 Model model) {
		 
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 int art_id = article.getArt_id();
		 int brd_id = article.getBrd_id();
		 int rep_id = article.getRep_id();
		 int mem_id = memberDetails.getMemberInfo().getMem_id();
		 
			Cookie oldCookie = null;	// oldCookie 객체 생성
		    Cookie[] cookies = request.getCookies();	// cookies 배열에 모든 쿠키를 담는다.
		    if (cookies != null) {			// 쿠키가 있으면?
		         for (Cookie cookie : cookies) {	// 쿠키들로 반복문을 돌려서
		            if (cookie.getName().equals("replyGoodUp")) {	// 이름이 viewArticle인 쿠키가 있으면?
		               oldCookie = cookie;	// 쿠키를 내 oldCookie에 담는다.
		            }
		         }
		      }
		    
		      if (oldCookie != null) {				// oldCookie가 있으면 그걸 가져와서 값을 설정해준다.
		          if (!oldCookie.getValue().contains(String.format("[%s_%s_%s_%s]", art_id, brd_id, rep_id, mem_id))) {
		        	  int replyGoodUp = as.dbReplyGoodUp(article); // 추천수 올리는 메서드
		              oldCookie.setValue(oldCookie.getValue() + String.format("[%s_%s_%s_%s]", art_id, brd_id, rep_id, mem_id));
		              oldCookie.setPath("/");
		              oldCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(oldCookie);
		              jsonObj.append("result", replyGoodUp);
		          } 
		      } else {								// oldCookie가 없으면 newCookie를 새로 만든다.
		    	  	  int replyGoodUp = as.dbReplyGoodUp(article); // 추천수 올리는 메서드
		              Cookie newCookie = new Cookie("replyGoodUp", String.format("[%s_%s_%s_%s]", art_id, brd_id, rep_id, mem_id));
		              newCookie.setPath("/");
		              newCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(newCookie);
		              jsonObj.append("result", replyGoodUp);
		      }
		 
		 return jsonObj.toString();
	 }
	 
	 
		// 댓글 비추천 Up
	 @RequestMapping(value="/board/replyBadUp")
	 @ResponseBody
	 public String ReplyBadUp(@AuthenticationPrincipal MemberDetails memberDetails,
			 					 @RequestBody Article article, 
			 					 HttpServletRequest request,
								 HttpServletResponse response,
								 Model model) {
		 
		 JSONObject jsonObj = new JSONObject();
		 
		 if (memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		 int art_id = article.getArt_id();
		 int brd_id = article.getBrd_id();
		 int rep_id = article.getRep_id();
		 int mem_id = memberDetails.getMemberInfo().getMem_id();
		 
			Cookie oldCookie = null;	// oldCookie 객체 생성
		    Cookie[] cookies = request.getCookies();	// cookies 배열에 모든 쿠키를 담는다.
		    if (cookies != null) {			// 쿠키가 있으면?
		         for (Cookie cookie : cookies) {	// 쿠키들로 반복문을 돌려서
		            if (cookie.getName().equals("replyBadUp")) {	// 이름이 viewArticle인 쿠키가 있으면?
		               oldCookie = cookie;	// 쿠키를 내 oldCookie에 담는다.
		            }
		         }
		      }
		    
		      if (oldCookie != null) {				// oldCookie가 있으면 그걸 가져와서 값을 설정해준다.
		          if (!oldCookie.getValue().contains(String.format("[%s_%s_%s_%s]", art_id, brd_id, rep_id, mem_id))) {
		        	  int replyBadUp = as.dbReplyBadUp(article); // 추천수 올리는 메서드
		              oldCookie.setValue(oldCookie.getValue() + String.format("[%s_%s_%s_%s]", art_id, brd_id, rep_id, mem_id));
		              oldCookie.setPath("/");
		              oldCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(oldCookie);
		              jsonObj.append("result", replyBadUp);
		          } 
		      } else {								// oldCookie가 없으면 newCookie를 새로 만든다.
		    	  	  int replyBadUp = as.dbReplyBadUp(article); // 추천수 올리는 메서드
		              Cookie newCookie = new Cookie("replyBadUp", String.format("[%s_%s_%s_%s]", art_id, brd_id, rep_id, mem_id));
		              newCookie.setPath("/");
		              newCookie.setMaxAge(60 * 60); // 1시간 (초 * 분 * 시간)
		              response.addCookie(newCookie);
		              jsonObj.append("result", replyBadUp);
		      }
		 
		 return jsonObj.toString();
	 }
	 
	 // 검색
	 @RequestMapping(value = "board/together/listSearch")
		public String listSearch(@AuthenticationPrincipal MemberDetails memberDetails,
				Article article, int category, String currentPage, Model model) {
			
			
//			  if (memberDetails != null) model.addAttribute("memberInfo",
//			  memberDetails.getMemberInfo());
//			  
//			  // category 값을 brd_id에 할당. article.setBrd_id(category); int number =
//			  article.getBrd_id();
//			  
//			  System.out.println("board/listSearch number->"+number); // Article 전체 Count
//			  int condArticleCnt = as.dbCondArticleCnt(article);
//			  System.out.println("board/listSearch condArticleCnt->"+condArticleCnt); //
//			  Paging 작업 Paging page = new Paging(condArticleCnt, currentPage); // Parameter
//			  Article --> Page만 추가 Setting article.setStart(page.getStart()); // 시작시 1
//			  article.setEnd(page.getEnd()); // 시작시 10
//			  
//			  List<Article> listSearchArticle = as.dbListSearchArticle(article);
//			  
//			  
//			  model.addAttribute("article", article); model.addAttribute("totalArticle",
//			  condArticleCnt); model.addAttribute("listArticle", listSearchArticle);
//			  model.addAttribute("category", number); model.addAttribute("page", page);
			 
		 
		 
			try {
				return String.format("redirect:/board/together?category=%s&search=%s&keyword=%s", category, article.getSearch(), URLEncoder.encode(article.getKeyword(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				return "redirect:/board/together?category="+category;
			}
		}
	 **/
	 
}