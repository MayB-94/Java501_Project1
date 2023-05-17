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

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.Join;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.Report;
import com.java501.S20230401.model.Waiting;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.CommService;
import com.java501.S20230401.service.FavoriteService;
import com.java501.S20230401.service.JoinService;
import com.java501.S20230401.service.MemberService;
import com.java501.S20230401.service.Paging;
import com.java501.S20230401.service.RegionService;
import com.java501.S20230401.service.ReplyService;
import com.java501.S20230401.service.ReportService;
import com.java501.S20230401.service.TradeService;
import com.java501.S20230401.service.WaitingService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 나눔해요 페이지 계열 컨트롤러 : 양동균
@Controller
@RequiredArgsConstructor
@Slf4j
public class ShareController {
	private final ArticleService 	articleService;
	private final JoinService 		joinService;
	private final CommService 		commService;
	private final ReplyService 		replyService;
	private final RegionService 	regionService;
	private final FavoriteService 	favoriteService;
	private final WaitingService 	waitingService;
	private final TradeService 		tradeService;
	private final ReportService		reportService;
	private final MemberService 	memberService;
	
	
	// 나눔해요 글 목록 + 검색
	@RequestMapping(value = "board/share")
	public String totalPage(@AuthenticationPrincipal
							MemberDetails memberDetails,	// 세션의 로그인 유저 정보
							Article article,
							Integer category,
							String currentPage,
							Model model) {
		// 유저 정보를 다시 리턴  //memberDetails.getMemberInfo() DB의 유저와 대조 & 권한 확인
		if(memberDetails != null)
			model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		// brd_id 할당
		article.setBrd_id(category);
		int totalArt = 0;
		List<Article> articleList = null;
		
		// 접속한 게시판의 카테고리 목록 가져오기
		List<Comm> commList = commService.commList((category / 100 * 100));
		// 접속한 게시판과 카테고리 식별
		String boardName = commService.categoryName(category);
		String categoryName = commService.categoryName(article.getBrd_id());
		
		// 페이징 작업 (게시글 수)
		totalArt = articleService.allTotalArt(article);
		
		Paging page = new Paging(totalArt, currentPage);
		
		article.setStart(page.getStart());
		article.setEnd(page.getEnd());
		
		// 게시글 조회
		articleList = articleService.allArticleList(article);
		
		model.addAttribute("articleList", articleList);
		model.addAttribute("page", page);
		model.addAttribute("totalArt", totalArt);
		model.addAttribute("category", category);
		model.addAttribute("boardName", boardName);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("commList", commList);
		
		return "share/total";
	}
	
	
	
	// 게시글 조회, 댓글 조회 (share/article.jsp)
	@RequestMapping(value = "board/share/{art_id}")
	public String detailShareArticle(	@PathVariable("art_id")
										String art_id,
										@AuthenticationPrincipal
										MemberDetails memberDetails,
										Article article,
										Integer category,
										Model model,
										HttpServletRequest request,
										HttpServletResponse response) {
		// url의 글번호 저장
		article.setArt_id(Integer.parseInt(art_id));
		
		// 로그인 후 유저 정보
		String mem_id = "";
		MemberInfo memberInfo = null;
		if(memberDetails != null) {
			memberInfo = memberDetails.getMemberInfo();
			mem_id = Integer.toString(memberInfo.getMem_id()); // 중복 방지 유저 별 쿠키 관리
			model.addAttribute("memberInfo", memberInfo);
			
			// 로그인 유저의 찜 목록 확인
			Article shareUser = new Article();
			shareUser.setArt_id(article.getArt_id());
			shareUser.setBrd_id(article.getBrd_id());
			shareUser.setMem_id(memberInfo.getMem_id());
			// 찜 목록 확인
			int userFavorite = favoriteService.dgUserFavorite(shareUser);
			// 대기열 확인
			int userWaiting = waitingService.dgUserWaiting(shareUser);
			// 거래 목록 확인
			int userJoin = joinService.shareUserJoin(shareUser);
			
			model.addAttribute("userJoin", userJoin);
			model.addAttribute("userFavorite", userFavorite);
			model.addAttribute("userWaiting", userWaiting);
		}
		
		
		// 쿠키 체크 조회수
		if(dgCheck(request, response, article.getArt_id(), article.getBrd_id(), mem_id)) {
			articleService.readShareArticle(article);
			System.out.println("성공 조회수 증가");
		}else{
			System.out.println("실패 조회수 변동 없음");
		}
		
		// 글 정보 저장
		Article detailArticle = articleService.detailShareArticle(article);
		// 댓글 정보 저장
		List<Reply> replyList = replyService.replyShareList(article);
		// 접속한 게시판과 카테고리 식별
		String boardName = commService.categoryName(category);
		String categoryName = commService.categoryName(article.getBrd_id());
		// 거래 대기열 목록 저장
		List<Waiting> waitingList = waitingService.dgShareWaitingList(detailArticle.getTrade().getTrd_id());
		// 거래 참가자 목록 저장
		List<Join> joinList = joinService.shareJoinList(detailArticle.getTrade().getTrd_id());

		
		model.addAttribute("joinList", joinList);
		model.addAttribute("waitingList", waitingList);
		model.addAttribute("article", detailArticle);
		model.addAttribute("replyList", replyList);
		model.addAttribute("category", category);
		model.addAttribute("boardName", boardName);
		model.addAttribute("categoryName", categoryName);
		
		return "share/article";
	}
	

	
	
	// 게시글 작성 페이지 이동
	@RequestMapping(value = "board/share/write")
	public String writeForm(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Model model, Integer category) {
		// 로그인 유저 정보
		if(memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		// 지역 제한 조회
		// 이 아래는 꼭 들고 다녀야함!!!
		Map<Region, List<Region>> regionHierachy = new HashMap<Region, List<Region>>();
		List<Region> superRegions = regionService.getSuperRegions();
		for (Region sups : superRegions) regionHierachy.put(sups, regionService.getChildRegions(sups.getReg_id()));
		model.addAttribute("superRegions", superRegions);
		model.addAttribute("regions", regionHierachy);
		// 여기까지는 꼭 들고 다녀야함!!!
		//List<Region> regionList = regionService.dgRegionList();
		//model.addAttribute("regionList", regionList);
		
		model.addAttribute("category", category);
		
		return "share/writeForm";
	}
	
	
	// 게시글 수정 페이지 이동
	@RequestMapping(value = "board/share/artUpdate")
	public String updateForm(@AuthenticationPrincipal MemberDetails memberDetails, Article article, Model model, Integer category) {
		// 로그인 유저 정보
		if(memberDetails != null) model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		// 글 정보 저장
		Article detailArticle = articleService.detailShareArticle(article);
		// 지역 제한 조회
		//List<Region> regionList = regionService.dgRegionList();
		// 이 아래는 꼭 들고 다녀야함!!!
		Map<Region, List<Region>> regionHierachy = new HashMap<Region, List<Region>>();
		List<Region> superRegions = regionService.getSuperRegions();
		for (Region sups : superRegions) regionHierachy.put(sups, regionService.getChildRegions(sups.getReg_id()));
		// 여기까지는 꼭 들고 다녀야함!!!
		// 거래 참가자 목록 저장
		List<Join> joinList = joinService.shareJoinList(detailArticle.getTrade().getTrd_id());
		// 거래 상태
		List<Comm> statusList = commService.commList(400);
		// 카테고리 변경
		List<Comm> categoryList = commService.commList((category / 100 * 100));
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("statusList", statusList);
		model.addAttribute("article", detailArticle);
		//model.addAttribute("regionList", regionList);
		model.addAttribute("superRegions", superRegions);
		model.addAttribute("regions", regionHierachy);
		model.addAttribute("category", category);
		model.addAttribute("isAnyoneJoined", (joinList.size() > 0)); // 수정
		
		return "share/updateForm";
	}
	

	
	// 게시글 작성
	@PostMapping(value = "board/share/writeArticleForm")
	public String writeArticleForm(	@AuthenticationPrincipal
									MemberDetails memberDetails,
									@RequestParam(name = "trd_endDate", required = false)
									@DateTimeFormat(pattern="yyyy-MM-dd")
									Date trd_endDate,
									Article article, 
									RedirectAttributes redirectAttributes, 
									Integer category) {
		int result = 0;
		MemberInfo memberInfo = null;
		redirectAttributes.addFlashAttribute("category", category);
		
		// 마감 날짜 저장
		article.getTrade().setTrd_enddate(trd_endDate);
		
		if(memberDetails != null) {
			memberInfo = memberDetails.getMemberInfo(); 					// 유저 정보 저장
			redirectAttributes.addFlashAttribute("memberInfo", memberInfo);	// 유저 정보 리턴
			article.setMem_id(memberInfo.getMem_id());
		}else {
			System.out.println("로그인 하세요");
			return "redirect:/login";
		}
		
		log.info("글쓰기 요청 {}", article);
		
		// 글쓰기 실행
		result = articleService.writeShareArticle(article);
		System.out.println(result);
		
		redirectAttributes.addFlashAttribute("article", article);
		return getRedirectShare(category);
	}
	
	
	// 게시글 수정
	@PostMapping(value = "board/share/updateArticleForm")
	public String updateShare(@AuthenticationPrincipal MemberDetails memberDetails, @RequestParam("trd_endDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date trd_endDate, Article article, Integer category) {
		// trd_endDate 저장 (model 이슈 변수명 endDate로)
		article.getTrade().setTrd_enddate(trd_endDate);
		System.out.println(article.getArt_isnotice());
		
		// 거래 참가자 목록 저장
		List<Join> joinList = joinService.shareJoinList(article.getTrade().getTrd_id());
		article.setTrd_id(article.getTrade().getTrd_id());
		if (joinList == null || joinList.size() > 0) article.setTrade(null);
		
		int result = tradeService.updateShare(article);
		System.out.println("최종 결과 : "+result);
		
		return getRedirectArticle(article, category);
	}
	
	
	
	// 게시글 삭제
	@RequestMapping(value = "board/share/artDelete/{art_id}")
	public String deleteArticle(@PathVariable("art_id")
								String art_id,
								@AuthenticationPrincipal
								MemberDetails memberDetails,
								Article article,
								Integer category,
								RedirectAttributes redirectAttributes) {
		article.setArt_id(Integer.parseInt(art_id));
		log.info("글번호 : {} 게시판 번호 : {} 카테고리 번호 : {}", article.getArt_id(), article.getBrd_id(), category);
		int result = articleService.dgDeleteArticle(article);
		if(result != 0) {
			System.out.println("삭제 성공");
			return getRedirectShare(category);
		}else{
			System.out.println("삭제 실패");
			return getRedirectArticle(article, category);
		}
	}
	
	
	// 글 추천, 비추천
	@ResponseBody
	@RequestMapping(value = "board/share/vote/{vote}")
	public int shareVote(@PathVariable("vote")
							String vote,
							@AuthenticationPrincipal
							MemberDetails memberDetails,
							Article article,
							RedirectAttributes redirectAttributes,
							HttpServletRequest request,
							HttpServletResponse response) {
		int result = 0;
		String toRemove = "";
		Article detailArticle = articleService.detailShareArticle(article); // 글 정보
		
		// 유저 정보
		String mem_id = "";
		if(memberDetails != null) {
			redirectAttributes.addFlashAttribute("memberInfo", memberDetails.getMemberInfo());
			mem_id = Integer.toString(memberDetails.getMemberInfo().getMem_id());
		}
		
		
		// 쿠키 추천, 비추천 (중복확인)
		if(dgCheck(request, response, article.getArt_id(), article.getBrd_id(), mem_id, vote)) {
			// 추천, 비추천
			if(vote.equals("good")) {
				article.setArt_good(detailArticle.getArt_good()+1);
				result = articleService.dgVoteGood(article);
				System.err.println("추천");
				
			// 비추천
			}else if(vote.equals("bad")) {
				article.setArt_bad(detailArticle.getArt_bad()+1);
				result = articleService.dgVoteBad(article);
				System.err.println("비추천");
			}
		// 쿠키 삭제 (추천, 비추천 취소)
		}else {
			Cookie oldCookie = null;
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie cookie : cookies) {
					if (cookie.getName().equals("share|"+mem_id)) {
						oldCookie = cookie;
						
						// 삭제 요소
						toRemove = "|"+article.getArt_id()+article.getBrd_id()+vote;

						if(vote.equals("good")) {
							article.setArt_good(detailArticle.getArt_good()-1);
							result = articleService.dgVoteGood(article);
							oldCookie.setValue(oldCookie.getValue().replace(toRemove, ""));
							System.err.println("추천 취소");
							
						}
						if(vote.equals("bad")) {
							article.setArt_bad(detailArticle.getArt_bad()-1);
							result = articleService.dgVoteBad(article);
							oldCookie.setValue(oldCookie.getValue().replace(toRemove, ""));
							System.err.println("비추천 취소");
						}
						oldCookie.setPath("/");
						response.addCookie(oldCookie);
						break;
					}
				}
			}
		}
		
		System.err.println(result);
		return result;
	}
	


	
	// 댓글, 대댓글 쓰기
	@PostMapping(value = "board/share/replyForm")
	public String replyForm(@AuthenticationPrincipal MemberDetails memberDetails, Reply reply, Model model, Integer category, RedirectAttributes redirectAttributes) {
		MemberInfo memberInfo = null;
		redirectAttributes.addFlashAttribute("category", category);
		
		// 유저 정보
		if(memberDetails != null) {
			memberInfo = memberDetails.getMemberInfo(); 					// 유저 정보 저장
			redirectAttributes.addFlashAttribute("memberInfo", memberInfo);	// 유저 정보 리턴
			reply.setMem_id(memberInfo.getMem_id());
		}
		
		// 댓글 작성
		int result = replyService.writeReply(reply);
		System.out.println(result > 0? "댓글 작성 성공":"댓글 작성 실패");
		
		return getRedirectArticle(reply, category);
	}
	

	

	
	
	
	// 댓글 삭제
	@RequestMapping(value = "board/share/repDelete")
	public String deleteReply(	@AuthenticationPrincipal
								MemberDetails memberDetails,
								Reply reply,
								RedirectAttributes redirectAttributes) {
		Integer category = reply.getBrd_id();
		MemberInfo memberInfo = null;
		if(memberDetails != null) {
			memberInfo = memberDetails.getMemberInfo(); 					// 유저 정보 저장
			redirectAttributes.addFlashAttribute("memberInfo", memberInfo);	// 유저 정보 리턴
			reply.setMem_id(memberInfo.getMem_id());
		}else {
			System.err.println("로그인 안됨");
			return getRedirectArticle(reply, category);
		}
		
		int result = replyService.deleteReply(reply);
		System.out.println(result > 0? "댓글 삭제 성공":"댓글 삭제 실패");
		
		return getRedirectArticle(reply, category);
	}
	
	
	
	// 댓글 수정 (Ajax)
	@ResponseBody
	@RequestMapping(value = "board/share/update")
	public List<Reply> updateReply(	@AuthenticationPrincipal
									MemberDetails memberDetails,
									Reply reply,
									RedirectAttributes redirectAttributes) {
		// 업데이트
		int result = replyService.dgUpdateReply(reply);

		// 댓글 조회
		List<Reply> replyList = null;
		if(result != 0) {
			Article article = new Article();
			article.setArt_id(reply.getArt_id());
			article.setBrd_id(reply.getBrd_id());
			replyList = replyService.replyShareList(article);
			
			log.info("리스트 {}",replyList);
		}
		return replyList;
	}
	
	// 지역 선택 (Ajax)
	@ResponseBody
	@RequestMapping(value = "board/share/selectRegion")
	public List<Region> dgSelectRegion(Region region){
		return regionService.dgSelectRegion(region);
	}
	
	// 검색 - 글 목록으로 넘김
	@RequestMapping(value = "board/share/searchForm")
	public String shareSearch(Article article, Integer category, RedirectAttributes redirectAttributes){
//		List<Article> searchList = articleService.shareSearch(article);
//		System.out.println("결과 확인 \n"+searchList);
//		int totalArt = 0;
//		String currentPage = null;
//		List<Article> articleList = null;
//		// 페이징 작업 (게시글 수)
//		totalArt = articleService.allTotalArt(article);
//		Paging page = new Paging(totalArt, currentPage);
//		article.setStart(page.getStart());
//		article.setEnd(page.getEnd());
//		// 게시글 조회
//		articleList = articleService.allArticleList(article);
//		System.out.println(articleList);
		//log.info("\n카테고리 : {} \n키워드 : {} \n검색 내용 : {} \n널임? {}", category, article.getKeyWord(), article.getSearch());
		redirectAttributes.addFlashAttribute("article", article);
		return getRedirectSearch(article, category);
	}

	 // 찜 기능
	@RequestMapping(value = "board/share/favorite/{fav}")
	public String shareFavorite(@AuthenticationPrincipal MemberDetails memberDetails, @PathVariable("fav") String fav, Article article, Integer category, RedirectAttributes redirectAttributes) {
		int result = 0;
		// 로그인 유저 정보
		if(memberDetails != null) {
			article.setMem_id(memberDetails.getMemberInfo().getMem_id());
			
			// 찜목록 추가
			if(fav.equals("add")) result = favoriteService.shareFavoriteAdd(article);
			// 찜목록 삭제
			else if(fav.equals("del")) result = favoriteService.shareFavoriteDel(article);
		}
		return getRedirectArticle(article, category);
	}


	// 거래 신청
	@RequestMapping(value = "board/share/waiting/{wait}")
	public String shareWaiting(@AuthenticationPrincipal MemberDetails memberDetails, @PathVariable("wait") String wait, Article article, Integer category){
		if(memberDetails != null) {
			int result = 0;
			article.setMem_id(memberDetails.getMemberInfo().getMem_id());
			// 거래 대기열 추가
			if(wait.equals("add")) result = waitingService.shareWaitingAdd(article);
			// 거래 대기열 삭제
			if(wait.equals("del")) result = waitingService.shareWaitingDel(article);
		}
		return getRedirectArticle(article, category);
	}

	// 거래 승인, 거절
	@RequestMapping(value = "board/share/join/{join}")
	public String shareJoin(@PathVariable("join")String join, Article article, Integer category) {
		int result = 0;
		switch (join) {
			case "accept":
				result = joinService.shareJoinAdd(article);
				if(result > 0) {
					waitingService.shareWaitingDel(article);
					// 승인시 마다 거래 인원확인, 가득 찼을 경우 거래상태 변경
					tradeService.shareTradeStatus(article);
				}
				break;
			case "refuse": 	waitingService.shareWaitingDel(article);	break;
			case "drop":	joinService.shareJoinDel(article);			break;
			default: break;
		}
		return getRedirectArticle(article, category);
	}

	// ***************
	// 신고 Map으로 가져오기 (@RequestParam(required = false) 필요함)
	@PostMapping(value = "board/share/reportForm")
	public String shareReport(@AuthenticationPrincipal MemberDetails memberDetails, @RequestParam(required = false) Map<String, Object> data,Integer reportMem_id ,Integer category){
		
		Article article = null;
		Reply reply = null;
		Report report = null;
		Member member = null;
		int result = 0;
		ObjectMapper objectMapper = new ObjectMapper();
		MemberInfo shareUser = null;
		
		// 필드가 있는데 값이 없거나, 필드가 없는데 값이 있거나 (에러 발생시 무시)
		objectMapper.configure(DeserializationFeature.FAIL_ON_IGNORED_PROPERTIES, false);
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		article = objectMapper.convertValue(data, Article.class); // redirect
		
		
		// 로그인이 되어 있을 경우에만 신고 실행
		if(memberDetails != null) {
			shareUser = memberDetails.getMemberInfo();
			report = objectMapper.convertValue(data, Report.class); // report 객체 저장
			report.setMem_id(shareUser.getMem_id()); // 신고자 id 저장 ( 접속 유저 )
			result = reportService.shareReport(report); // report_id값 리턴

			System.out.println("report 번호 : "+result);
			if(result > 0) {
				switch (report.getType()) { // 신고 타입에 따라 실행
				case "article":
					article.setReport_id(result);
					result = articleService.dgReportArticle(article);
					break;
				case "reply":
					reply = objectMapper.convertValue(data, Reply.class);
					reply.setReport_id(result);
					result = replyService.dgReportReply(reply);
					break;
				case "member":
					member = objectMapper.convertValue(data, Member.class);
					member.setMem_id(reportMem_id); 
					member.setReport_id(result);
					result = memberService.dgReportMember(member);
					break;
				}
			}
		}
		return getRedirectArticle(article, category);
	}

	// 신고 체크
	@RequestMapping(value = "board/share/isReport")
	@ResponseBody
	public boolean isReport(@AuthenticationPrincipal MemberDetails memberDetails, Report report) {
		boolean isReport = false;
		if(memberDetails != null) {
			report.setMem_id(memberDetails.getMemberInfo().getMem_id());
			isReport = reportService.shareIsReport(report);
		}
		return isReport;
	}
	



/* 머지 후 영업 종료
	// 메인
	@RequestMapping(value = "/")
	public String indexPage() {
		return "redirect:/board/share?category=999";
	}
*/
	// Share외의 다른 카테고리 연결
	@RequestMapping(value = "board/{categoryConnect}")
	public String togetherPage(	@PathVariable("categoryConnect")
								String 	categoryConnect, 
								Article article, 
								String 	currentPage, 
								Model 	model, 
								Integer category,
								RedirectAttributes redirectAttributes) {
		log.info("현재 {}에 접속 감지 카테고리 번호 : {}", categoryConnect, category);
		redirectAttributes.addFlashAttribute("article", article);
		redirectAttributes.addFlashAttribute("currentPage", currentPage);
		return "redirect:/board/share?category="+category;
	}

	// 쿠키용 체크
	public boolean dgCheck(	HttpServletRequest request,
							HttpServletResponse response,
							Integer art_id,
							Integer brd_id,
							String mem_id,
							String... params) {
		// 추가 parameter가 있을 경우 저장 (추천,비추천)
		String addValues = "";
		for(String s : params) {
			addValues += s;
		}
		// 값 저장
		String visitArticle = "|"+art_id+brd_id+addValues;
		// 조회수 로직
		Cookie oldCookie = null;
		// 쿠키 중복 체크
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				log.info("쿠키 이름 {} & 쿠키 값 {}",cookie.getName(), cookie.getValue());
				// 쿠키에 저장된 유저 확인
				if (cookie.getName().equals("share|"+mem_id)) {
					oldCookie = cookie;
					break;
				}
			}
		}
		// 처음 방문하거나(기존 쿠키 없음), 처음 조회 하는 글일 경우 실행
		// 유저별로 쿠키 중복 관리 share|유저| - 글번호|게시판번호
		if(oldCookie == null) {
			Cookie newCookie = new Cookie("share|"+mem_id, visitArticle);
			newCookie.setMaxAge(60*60*12); // 쿠키 생명주기 12시간
			newCookie.setPath("/");
			response.addCookie(newCookie);
			return true;
			
			// 쿠키가 있을 경우 덧붙임 (동일한 유저)
		}else if(!oldCookie.getValue().contains(visitArticle)) {
			// 조회수 증가
			oldCookie.setValue(oldCookie.getValue()+visitArticle);
			oldCookie.setMaxAge(60*60*12);
			oldCookie.setPath("/");
			response.addCookie(oldCookie);
			return true;
		}
		return false;
	}
	// 카테고리로 돌아가기
	public String getRedirectShare(Integer category) {
		return String.format("redirect:/board/share?category=%s", category);
	}
	// 검색한 카테고리로 돌아가기
	public String getRedirectSearch(Article article, Integer category) { 
		try {
			return String.format("redirect:/board/share?category=%s&search=%s&keyWord=%s", category, article.getSearch(), URLEncoder.encode(article.getKeyWord(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			return getRedirectShare(category);
		}
	}
	// 게시글로 돌아가기
	public String getRedirectArticle(Article article, Integer category) {
		return String.format("redirect:/board/share/%s?brd_id=%s&category=%s", article.getArt_id(), article.getBrd_id(), category);
	}
	// Overloading
	public String getRedirectArticle(Reply reply, Integer category) {
		return String.format("redirect:/board/share/%s?brd_id=%s&category=%s", reply.getArt_id(), reply.getBrd_id(), category);
	}
}




