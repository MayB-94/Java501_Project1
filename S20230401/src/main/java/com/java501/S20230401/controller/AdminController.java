package com.java501.S20230401.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.MemberDetails;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.Report;
import com.java501.S20230401.service.ArticleService;
import com.java501.S20230401.service.CommService;
import com.java501.S20230401.service.MemberService;
import com.java501.S20230401.service.Paging;
import com.java501.S20230401.service.ReplyService;
import com.java501.S20230401.service.ReportService;

import lombok.RequiredArgsConstructor;

// 관리자 페이지 계열 컨트롤러 : 유현규
@Controller
@RequiredArgsConstructor
public class AdminController {
	private final ArticleService as;
	private final MemberService ms;
	private final ReplyService rs;
	private final CommService cs;
	private final ReportService repos;
	
	@RequestMapping(value = "/admin")
	public String adminHome(@AuthenticationPrincipal MemberDetails memberDetails,
							HttpServletRequest request, HttpServletResponse response,
							Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		
		
		return "admin/adminIndex";
	}
	
	@RequestMapping(value = "/admin/{type}")
	public String adminPage(@AuthenticationPrincipal MemberDetails memberDetails,
							@PathVariable String type, @RequestBody(required = false) Map<String, Object> data,
							HttpServletRequest request, HttpServletResponse response,
							Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		
		Integer page = 1;
		if (data != null && data.containsKey("page")) page = (int)data.get("page");
		model.addAttribute("page", page);
		model.addAttribute("type", type);
		Article searcher = new Article();
		Paging paging = null;
		List<Article> articles = null;
		switch(type) {
			case "notice":
				searcher.setBrd_id(1510);
				paging = new Paging(as.allTotalArt(searcher), Integer.toString(page), 20, 10);
				searcher.setStart(paging.getStart());
				searcher.setEnd(paging.getEnd());
				articles = as.hgAdminArticleList(searcher);
				model.addAttribute("start", paging.getStart());
				model.addAttribute("end", paging.getEnd());
				model.addAttribute("startPage", paging.getStartPage());
				model.addAttribute("endPage", paging.getEndPage());
				model.addAttribute("total", paging.getTotal());
				model.addAttribute("totalPage", paging.getTotalPage());
				model.addAttribute("articles", articles);
				return "admin/adminTemplate";
			case "event":
				searcher.setBrd_id(1530);
				paging = new Paging(as.allTotalArt(searcher), Integer.toString(page), 20, 10);
				searcher.setStart(paging.getStart());
				searcher.setEnd(paging.getEnd());
				articles = as.hgAdminArticleList(searcher);
				model.addAttribute("start", paging.getStart());
				model.addAttribute("end", paging.getEnd());
				model.addAttribute("startPage", paging.getStartPage());
				model.addAttribute("endPage", paging.getEndPage());
				model.addAttribute("total", paging.getTotal());
				model.addAttribute("totalPage", paging.getTotalPage());
				model.addAttribute("articles", articles);
				return "admin/adminTemplate";
			case "report":
				Report report = new Report();
				paging = new Paging(repos.hgGetCountAllUnprocessedReports(), Integer.toString(page));
				report.setStart(paging.getStart());
				report.setEnd(paging.getEnd());
				List<Report> reports = repos.hgGetAllUnprocessedReports(report);
				Map<Integer, Object> reportItems = new HashMap<Integer, Object>();
				for (Report rpt : reports) {
					Integer rpt_id = rpt.getReport_id();
					if (reportItems.containsKey(rpt_id)) continue;
					String rawType = rpt.getType();
					String pascal = rawType == null ? null : rawType.substring(0, 1).toUpperCase() + rawType.toLowerCase().substring(1);
					Object resultInstance = repos.hgGetInstanceByReportId(rpt_id, pascal);
//					try { reportItems.put(rpt_id, Class.forName("com.java501.S20230401.model." + pascal).cast(repos.hgGetInstanceByReportId(rpt_id, pascal))); }
//					catch (Exception e) { e.printStackTrace(); reportItems.put(rpt_id, null); }
					switch(rawType.toUpperCase()) {
						case "MEMBER": reportItems.put(rpt_id, (Member)resultInstance); break;
						case "ARTICLE": reportItems.put(rpt_id, (Article)resultInstance); break;
						default: reportItems.put(rpt_id, (Reply)resultInstance); break;
					}
				}
				model.addAttribute("start", paging.getStart());
				model.addAttribute("end", paging.getEnd());
				model.addAttribute("startPage", paging.getStartPage());
				model.addAttribute("endPage", paging.getEndPage());
				model.addAttribute("total", paging.getTotal());
				model.addAttribute("totalPage", paging.getTotalPage());
				model.addAttribute("reportItems", reportItems);
				model.addAttribute("reports", reports);
				return "admin/adminReportTemplate";
			case "member":
				Member member = new Member();
				paging = new Paging(ms.hgGetCountAllMembers(), Integer.toString(page), 10, 10);
				member.setStart(paging.getStart());
				member.setEnd(paging.getEnd());
				List<Member> members = ms.hgGetMembersForAdmin(member);
				model.addAttribute("start", paging.getStart());
				model.addAttribute("end", paging.getEnd());
				model.addAttribute("startPage", paging.getStartPage());
				model.addAttribute("endPage", paging.getEndPage());
				model.addAttribute("total", paging.getTotal());
				model.addAttribute("totalPage", paging.getTotalPage());
				model.addAttribute("members", members);
				return "admin/adminMemberTemplate";
			case "article":
				paging = new Paging(as.hgGetCountAllArticle(), Integer.toString(page), 20, 10);
				searcher.setStart(paging.getStart());
				searcher.setEnd(paging.getEnd());
				articles = as.hgGetArticles(searcher);
				List<Comm> categoryNames = cs.hgGetCategoryNames();
				Map<Integer, String> categories = categoryNames.stream().collect(Collectors.toMap(Comm::getComm_id, Comm::getComm_value));
				model.addAttribute("categories", categories);
				model.addAttribute("start", paging.getStart());
				model.addAttribute("end", paging.getEnd());
				model.addAttribute("startPage", paging.getStartPage());
				model.addAttribute("endPage", paging.getEndPage());
				model.addAttribute("total", paging.getTotal());
				model.addAttribute("totalPage", paging.getTotalPage());
				model.addAttribute("articles", articles);
				return "admin/adminArticleTemplate";
			case "suggest":
				searcher.setBrd_id(1540);
				paging = new Paging(as.allTotalArt(searcher), Integer.toString(page), 20, 10);
				searcher.setStart(paging.getStart());
				searcher.setEnd(paging.getEnd());
				articles = as.hgAdminArticleList(searcher);
				model.addAttribute("start", paging.getStart());
				model.addAttribute("end", paging.getEnd());
				model.addAttribute("startPage", paging.getStartPage());
				model.addAttribute("endPage", paging.getEndPage());
				model.addAttribute("total", paging.getTotal());
				model.addAttribute("totalPage", paging.getTotalPage());
				model.addAttribute("articles", articles);
				return "admin/adminSuggestTemplate";
			default: return "";
		}
	}
	
	@RequestMapping(value = "/admin/{type}/view")
	public String adminViewPage(@AuthenticationPrincipal MemberDetails memberDetails,
								@PathVariable String type, @RequestBody(required = false) Map<String, Object> data,
								HttpServletRequest request, HttpServletResponse response,
								Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("type", type);

		Article searcher = new Article();
		Article article = null;
		switch(type) {
			case "notice":
				searcher.setArt_id((int)data.get("art_id"));
				searcher.setBrd_id(1510);
				article = as.getArticleById(searcher);
				model.addAttribute("article", article);
				return "admin/adminViewTemplate";
			case "event":
				searcher.setArt_id((int)data.get("art_id"));
				searcher.setBrd_id(1530);
				article = as.getArticleById(searcher);
				model.addAttribute("article", article);
				return "admin/adminViewTemplate";
			case "article":
				searcher.setArt_id((int)data.get("art_id"));
				searcher.setBrd_id((int)data.get("brd_id"));
				article = as.getArticleById(searcher);
				List<Reply> replies = rs.hgGetRepliesOfArticle(searcher);
				model.addAttribute("article", article);
				model.addAttribute("replies", replies);
				return "admin/adminArticleViewTemplate";
			case "suggest":
				searcher.setArt_id((int)data.get("art_id"));
				searcher.setBrd_id(1540);
				article = as.getArticleById(searcher);
				List<Reply> replies2 = rs.hgGetRepliesOfArticle(searcher);
				model.addAttribute("article", article);
				model.addAttribute("replies", replies2);
				return "admin/adminSuggestViewTemplate";
		}
		
		return "admin/adminViewTemplate";
	}
	
	@RequestMapping(value = "/admin/{type}/update")
	public String adminUpdatePage(@AuthenticationPrincipal MemberDetails memberDetails,
											@PathVariable String type, @RequestBody(required = false) Map<String, Object> data,
											HttpServletRequest request, HttpServletResponse response,
											Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("type", type);

		Article searcher = new Article();
		Article article = null;
		switch(type) {
			case "notice":
				searcher.setArt_id((int)data.get("art_id"));
				searcher.setBrd_id(1510);
				article = as.getArticleById(searcher);
				model.addAttribute("article", article);
				break;
			case "event":
				searcher.setArt_id((int)data.get("art_id"));
				searcher.setBrd_id(1530);
				article = as.getArticleById(searcher);
				model.addAttribute("article", article);
				break;
		}
		
		return "admin/adminUpdateTemplate";
	}
	
	@RequestMapping(value = "/admin/{type}/write")
	public String adminWritePage(@AuthenticationPrincipal MemberDetails memberDetails,
								 @PathVariable String type, @RequestBody(required = false) Map<String, Object> data,
								 HttpServletRequest request, HttpServletResponse response,
								 Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("type", type);

		boolean isTradeBoard = false;
		switch(type) {
			case "notice":
				isTradeBoard = false;
				model.addAttribute("isTradeBoard", isTradeBoard);
				break;
			case "event":
				isTradeBoard = true;
				model.addAttribute("isTradeBoard", isTradeBoard);
				break;
		}
		
		return "admin/adminWriteTemplate";
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/{type}/updateProc")
	public String adminUpdateProcess(@AuthenticationPrincipal MemberDetails memberDetails,
									 //@PathVariable String type, @RequestBody(required = false) Article article,
									 @PathVariable String type, @RequestBody(required = false) Map<String, Object> data,
									 HttpServletRequest request, HttpServletResponse response,
									 Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("type", type);
		
		JSONObject jsonObj = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_IGNORED_PROPERTIES, false);
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        Article article = new Article();
		int result = 0;
		switch(type) {
			case "notice":
				article = mapper.convertValue(data, Article.class);
				article.setBrd_id(1510);
				result = as.hgCompressedUpdateArticle(article);
				jsonObj.append("result", result);
				jsonObj.append("art_id", article.getArt_id());
				break;
			case "event":
				article = mapper.convertValue(data, Article.class);
				article.setBrd_id(1530);
				result = as.hgCompressedUpdateArticle(article);
				jsonObj.append("result", result);
				jsonObj.append("art_id", article.getArt_id());
				break;
			case "report":
				Report report = mapper.convertValue(data, Report.class);
				// Report 업데이트 구문...
				// result = repos.hgUpdateReport(report);
				// 여기엔 같은 신고번호에 대한 일괄 처리 관련 구문 넣으면 됨
				String submit = (String)data.get("submit");
				String pascal = submit == null ? null : submit.substring(0, 1).toUpperCase() + submit.toLowerCase().substring(1);
				switch(submit) {
					case "MEMBER":
					case "ARTICLE":
					case "REPLY":
						result = repos.hgUpdateInstanceAboutReport(report, pascal);
						repos.hgUpdateReportBatch(report);
						break;
					default: // Reject Submit Type
						result = repos.hgRejectReport(report);
						break;
				}
				jsonObj.append("result", result);
			case "member":
				Member member = ms.getMemberById((int)data.get("mem_id"));
				switch(((String)data.get("change")).toUpperCase()) {
					case "BAN":
						member.setMem_authority(member.getMem_authority() == 102 ? 103 : 102);
						result = ms.hgUpdateAuthorityByMember(member);
						break;
					case "DELETE":
						member.setIsdelete(member.getIsdelete() == 0 ? 1 : 0);
						result = ms.hgUpdateIsdeleteByMember(member);
						break;
					case "AUTH":
						member.setMem_authority((int)data.get("value"));
						result = ms.hgUpdateAuthorityByMember(member);
						break;
				}
				jsonObj.append("result", result);
				break;
			case "suggest":
				Reply reply = mapper.convertValue(data, Reply.class);
				reply.setBrd_id(1540);
				reply.setMem_id(memberDetails.getMemberInfo().getMem_id());
				result = rs.hgInsertReply(reply);
				jsonObj.append("result", result);
				break;
		}
		return jsonObj.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/{type}/writeProc")
	public String adminWriteProcess(@AuthenticationPrincipal MemberDetails memberDetails,
									@PathVariable String type, @RequestBody(required = false) Map<String, Object> data,
									HttpServletRequest request, HttpServletResponse response,
									Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("type", type);
		
		JSONObject jsonObj = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_IGNORED_PROPERTIES, false);
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        Article article;
		int result;
		switch(type) {
			case "notice":
				article = mapper.convertValue(data, Article.class);
				article.setMem_id(memberDetails.getMemberInfo().getMem_id());
				article.setBrd_id(1510);
				result = as.hgInsertAdminArticle(article);
				jsonObj.append("result", result);
				jsonObj.append("art_id", article.getArt_id());
				break;
			case "event":
				article = mapper.convertValue(data, Article.class);
				article.setMem_id(memberDetails.getMemberInfo().getMem_id());
				article.setBrd_id(1530);
				result = as.hgInsertAdminArticle(article);
				jsonObj.append("result", result);
				jsonObj.append("art_id", article.getArt_id());
				break;
		}
		
		//response.setCharacterEncoding("UTF-8");
		return jsonObj.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/{type}/delete")
	public String adminDelete(@AuthenticationPrincipal MemberDetails memberDetails,
						      @PathVariable String type, @RequestBody(required = false) Map<String, Object> data,
						      HttpServletRequest request, HttpServletResponse response,
						      Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
			catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("type", type);
		
		JSONObject jsonObj = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_IGNORED_PROPERTIES, false);
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        Article article;
		int result;
		switch(type) {
			case "notice":
				article = mapper.convertValue(data, Article.class);
				article.setBrd_id(1510);
				result = as.hgDeleteArticle(article);
				jsonObj.append("result", result);
				jsonObj.append("art_id", article.getArt_id());
				break;
			case "event":
				article = mapper.convertValue(data, Article.class);
				article.setBrd_id(1530);
				result = as.hgDeleteArticle(article);
				jsonObj.append("result", result);
				jsonObj.append("art_id", article.getArt_id());
				break;
			case "article":
				article = mapper.convertValue(data, Article.class);
				result = as.hgDeleteArticle(article);
				jsonObj.append("result", result);
				jsonObj.append("art_id", article.getArt_id());
				break;
			case "reply":
				Reply reply = mapper.convertValue(data, Reply.class);
				reply = rs.hgGetReplyById(reply);
				reply.setIsdelete(reply.getIsdelete() == 1 ? 0 : 1);
				result = rs.hgDeleteReply(reply);
				break;
			case "suggest":
				Reply reply2 = mapper.convertValue(data, Reply.class);
				reply2.setBrd_id(1540);
				result = rs.hgRealDeleteReply(reply2);
				break;
		}
		
		//response.setCharacterEncoding("UTF-8");
		return jsonObj.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/{type}/restore")
	public String adminRestore(@AuthenticationPrincipal MemberDetails memberDetails,
			@PathVariable String type, @RequestBody(required = false) Article article,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (memberDetails == null)
			try { response.sendRedirect("/"); }
		catch (Exception e) { e.printStackTrace(); }
		else model.addAttribute("memberInfo", memberDetails.getMemberInfo());
		model.addAttribute("type", type);
		
		JSONObject jsonObj = new JSONObject();
		
		int result;
		switch(type) {
		case "notice":
			article.setBrd_id(1510);
			result = as.hgRestoreArticle(article);
			jsonObj.append("result", result);
			jsonObj.append("art_id", article.getArt_id());
			break;
		case "event":
			article.setBrd_id(1530);
			result = as.hgRestoreArticle(article);
			jsonObj.append("result", result);
			jsonObj.append("art_id", article.getArt_id());
			break;
		case "article":
			result = as.hgRestoreArticle(article);
			jsonObj.append("result", result);
			jsonObj.append("art_id", article.getArt_id());
			break;
		}
		
		//response.setCharacterEncoding("UTF-8");
		return jsonObj.toString();
	}
}
