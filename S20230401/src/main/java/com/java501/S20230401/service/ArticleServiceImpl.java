package com.java501.S20230401.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.java501.S20230401.dao.ArticleDao;
import com.java501.S20230401.dao.CommDao;
import com.java501.S20230401.dao.FavoriteDao;
import com.java501.S20230401.dao.JoinDao;
import com.java501.S20230401.dao.RegionDao;
import com.java501.S20230401.dao.ReplyDao;
import com.java501.S20230401.dao.WaitingDao;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Member;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.ArticleMember;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.Join;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.util.SummaryType;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.util.SummaryType;
import lombok.RequiredArgsConstructor;
import oracle.security.o3logon.a;

@Service
@RequiredArgsConstructor
public class ArticleServiceImpl implements ArticleService {
	private final ArticleDao 	ad;
	private final RegionDao 	rd;
	private final CommDao 		cd;
	private final ReplyDao 		rpd;
	private final JoinDao       jd;
	private final WaitingDao    wd;
	private final FavoriteDao   fd;
	



	// 유현규 로그인 기능 추가
	@Override
	public List<ArticleMember> getArticleSummary(int boardNum, SummaryType summaryType) {
		List<ArticleMember> articleList = ad.getArticleSummary(boardNum, summaryType);
		return articleList;
	}
	@Override
	public int insertArticle(Article article) {
		int result = ad.insertArticle(article);
		return result;
	}
	@Override
	public Article getArticleById(Article searcher) {
		return ad.getArticleById(searcher);
	}
	@Override
	public MemberInfo getMemberInfoById(int mem_id) {
		return ad.getMemberInfoById(mem_id);
	}
	@Override
	public ArticleMember getArticleMemberById(Article searcher) {
		return ad.getArticleMemberById(searcher);
	}
	@Override
	public List<ArticleMember> hgGetArticlesOfMember(int mem_id) {
		return ad.hgGetArticlesOfMember(mem_id);
	}
	@Override
	public int hgIncreaseReadCount(Article searcher) {
		return ad.hgIncreaseReadCount(searcher);
	}
	@Override
	public int hgRecommendArticle(Article searcher) {
		return ad.hgRecommendArticle(searcher);
	}
	@Override
	public int hgCompressedUpdateArticle(Article article) {
		return ad.hgCompressedUpdateArticle(article);
	}
	@Override
	public int hgDeleteArticle(Article article) {
		return ad.hgDeleteArticle(article);
	}
	@Override
	public int hgRestoreArticle(Article article) {
		return ad.hgRestoreArticle(article);
	}
	@Override
	public int hgInsertAdminArticle(Article article) {
		return ad.hgInsertAdminArticle(article);
	}
	@Override
	public List<Article> hgAdminArticleList(Article searcher) {
		return ad.hgAdminArticleList(searcher);
	}
	@Override
	public int hgGetCountAllArticle() {
		return ad.hgGetCountAllArticle();
	}
	@Override
	public List<Article> hgGetArticles(Article searcher) {
		return ad.hgGetArticles(searcher);
	}
	
	
	// 양동균
	@Override
	public int allTotalArt(Article article) { return ad.allTotalArt(article); }
	@Override
	public List<Article> allArticleList(Article article) { return ad.allArticleList(article); }
	// 댓글
	@Override
	public Article detailShareArticle(Article article) { return ad.detailShareArticle(article); }
	@Override
	public int readShareArticle(Article article) {	return ad.readShareArticle(article); }
	// 글쓰기
	@Override
	public int writeShareArticle(Article article) {	return ad.writeShareArticle(article);}
	// 글 삭제
	@Override
	public int dgDeleteArticle(Article article) { return ad.dgDeleteArticle(article);	}
	// 글 추천
	@Override
	public int dgVoteGood(Article article) { return ad.dgVoteGood(article);}
	// 글 비추천
	@Override
	public int dgVoteBad(Article article) {	return ad.dgVoteBad(article);}
	@Override
	public int dgReportArticle(Article article) { return ad.dgReportArticle(article); }

	
	// 백준
	@Override
	public Integer bjTotalArticle(Article article) {
		Integer totalArticleCnt = ad.bjTotalArticle(article);
		return totalArticleCnt;
	}
	@Override
	public List<Article> articleTotal(Article article) {
		List<Article> articleList = null;
		articleList = ad.articleTotal(article);
		return articleList;
	}
	@Override
	public Article detailContent(Article article) {
		Article detailCon = null;
		detailCon = ad.detailContent(article);
		return detailCon;
	}
	@Override
	public List<Article> articleMenu(Article article) {
		List<Article> articleMenu = null;
		articleMenu = ad.artcleMenu(article);
		return articleMenu;
	}
	@Override
	public Integer upreadCount(Article article) {
		return ad.upreadCount(article);
	}
	
	@Override
	public List<Article> listMagnager() {
		List<Article> bjwrite = null;
		bjwrite = ad.listMagnager();
		return bjwrite;
	}
	@Override
	public int bjWriteArticle(Article article) {
		int result = 0;
		result = ad.bjWriteArticle(article);
		return result;
	}
	@Override
	public int bjUpdateArticle(Article article) {
		int update = 0;
		update = ad.bjUpdateArticle(article);
		return update;
	}
	@Override
	public int delete(Article article) {
		int delResult = 0;
		delResult = ad.delete(article);
		return delResult;
	}
	@Override
	public int replyWrite(Reply reply) {
		int reWrite = 0;
		reWrite = ad.replyWrite(reply);
		return reWrite;
	}

	@Override
	public int replyDelete(Reply reply) {
		int reDelete = 0;
		reDelete = ad.replyDelete(reply);
		return reDelete;
	}
	
	@Override
	public List<Article> bjArtSearch(Article article) {
		List<Article> bjSearch = null;
		bjSearch = ad.bjArtSearch(article);
		
		return bjSearch;
	}
	
	@Override
	public Integer bjGood(Article article) {
		return ad.bjGood(article);
	}
	@Override
	public Integer bjBad(Article article) {
		// TODO Auto-generated method stub
		return ad.bjBad(article);
	}
	
	@Override
	public List<Comm> bjcommList(int comm_id) {
		return ad.bjcommList(comm_id);
	}
	
	@Override
	public String bjCategoryName(int comm_id) {
		return ad.bjCategoryName(comm_id);
	}
	
	
	// 임동빈
	
	// 총 게시글 수 Count
	@Override
	public int dbtotalArticle(Article article) {
		int totArticleCnt = ad.dbtotalArticle(article);

		return totArticleCnt;
	}
	// 게시글 리스트
	@Override
	public List<Article> dbListArticle(Article article) {
		List<Article> articleList = null;
		articleList = ad.dbListArticle(article);
		return articleList;
	}
	
	// 상세 게시글
	@Override
	public Article dbdetailArticle(Article article) {
		Article detailArticle = null;
		detailArticle = ad.dbdetailArticle(article);
		return detailArticle;
	}
	
	// 지역 제한 리스트
	@Override
	public List<Region> regionName() {
		List<Region> regionName = null;
		regionName = rd.regionName();
		return regionName;
	}

	// 부모 지역 제한 리스트
	@Override
	public List<Region> parentRegionName() {
		List<Region> parentRegionName = null;
		parentRegionName = rd.parentRegionName();
		return parentRegionName;
	}
	
	// 카테고리 이름 리스트
	@Override
	public List<Comm> categoryName() {
		List<Comm> categoryName = null;
		categoryName = cd.boardName();
		return categoryName;
	}
	
	// 성별 리스트
	@Override
	public List<Comm> genderName() {
		List<Comm> genderName = null;
		genderName = cd.genderName();
		return genderName;
	}
	
	// 댓글 리스트
	@Override
	public List<Article> dbreplyList(Article article) {
		List<Article> replyList = ad.dbreplyList(article);
		return replyList;
	}
	
	// 게시글 작성
	@Override
	public void dbWriteArticle(Article article) {
		ad.dbWriteArticle(article);
	}
	
	// 게시글 삭제
	@Override
	public int dbdeleteArticle(Article article) {	
		int deleteArticle = ad.dbdeleteArticle(article);
		return deleteArticle;
	}
	
	// 게시글 수정
	@Override
	public void dbUpdateArticle(Article article) {
		ad.dbUpdateArticle(article);
	}
	
	// 조회수 Count
	@Override
	public int dbReadArticleCnt(Article article) {
		int dbReadArticleCnt = ad.dbReadArticleCnt(article);
		return dbReadArticleCnt;
	}
	
	// 신고하기
	@Override
	@Transactional
	public Article dbReportArticle(Article article) {
		Article dbInsertReport = ad.dbInsertReportArticle(article);
		return dbInsertReport;
	}
	
	// 댓글신고하기
	@Override
	public Article dbReportReply(Article article) {
		Article dbInsertReport = ad.dbInsertReportReply(article);
		return dbInsertReport;
	}
	
	// 거래 신청자 목록
	@Override
	public List<Article> dbTradeJoinMember(Article article) {
		List<Article> joinList = ad.dbTradeJoinMember(article);
		return joinList;
	}
	
	// 거래 대기자 목록
	@Override
	public List<Article> dbTradeWaitingMember(Article article) {
		List<Article> WaitingList = ad.dbTradeWaitingMember(article);
		return WaitingList;
	}
	
	// 거래 대기자로 등록
	@Override
	public int dbTradeWaiting(Article article) {
		int TradeWaiting = ad.dbTradeWaiting(article);
		return TradeWaiting;
	}
	
	// 거래 대기자 -> 신청자로 등록
	@Override
	@Transactional
	public int dbTradeJoinAccept(Article article) {
		int TradeInsertJoin    = ad.dbTradeInsertJoin(article);
		int TradeDeleteWaiting = ad.dbTradeDeleteWaiting(article); 
		if ((TradeInsertJoin + TradeDeleteWaiting) == 0)
			return 0;
		return 1;
	}
	
	@Override
	public int dbTradeJoinRefuse(Article article) {
		int TradeDeleteWaiting = ad.dbTradeDeleteWaiting(article); 
		return TradeDeleteWaiting;
	}
	
	@Override
	public int dbJoinDelete(Article article) {
		int JoinDelete = ad.dbJoinDelete(article);
		return JoinDelete;
	}
	
	@Override
	public int dbfavoriteArticle(Article article) {
		int favoriteArticle = ad.dbFavoriteArticle(article);
		return favoriteArticle;
	}
	
	@Override
	public int dbFavoriteArticleDelete(Article article) {
		int dbFavoriteArticleDelete = ad.dbFavoriteArticleDelete(article);
		return dbFavoriteArticleDelete;
	}
	
	@Override
	public int dbChangeStatus(Article article) {
		int changeStatus = ad.dbChangeStatus(article);
		return changeStatus;
	}
	
	@Override
	public int dbChangeEndStatus(Article article) {
		int changeEndStatus = ad.dbChangeEndStatus(article);
		return changeEndStatus;
	}
	
	@Override
	public int dbChangeCancelStatus(Article article) {
		int changeCancelStatus = ad.dbChangeCancelStatus(article);
		return changeCancelStatus;
	}
	
	@Override
	public int dbArticleGoodUp(Article article) {
		int dbArticleGoodUp = ad.dbArticleGoodUp(article);
		return dbArticleGoodUp;
	}
	
	@Override
	public int dbArticleBadUp(Article article) {
		int dbArticleBadUp = ad.dbArticleBadUp(article);
		return dbArticleBadUp;
	}
	
	@Override
	public int dbReplyGoodUp(Article article) {
		int dbReplyGoodUp = ad.dbReplyGoodUp(article);
		return dbReplyGoodUp;
	}
	
	@Override
	public int dbReplyBadUp(Article article) {
		int dbReplyBadUp = ad.dbReplyBadUp(article);
		return dbReplyBadUp;
	}
	
	@Override
	public int dbCondArticleCnt(Article article) {
		int dbCondArticleCnt = ad.dbCondArticleCnt(article);
		return dbCondArticleCnt;
	}
	@Override
	public List<Article> dbListSearchArticle(Article article) {
		List<Article> dbListSearchArticle = null;
		dbListSearchArticle = ad.dbListSearchArticle(article);
		return dbListSearchArticle;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	


	// 김찬영
	// 총리스트 	
	@Override
	public int cytotalArticle() {
		System.out.println("ArticleServiceImpl Start total...");
		int cytotalArticle = ad.cytotalArticle();
		System.out.println("ArticleServiceImpl totalArticle totArticleCnt->" + cytotalArticle);
		return cytotalArticle;
	}
	//검색
//	@Override
//	public int cytotalArticleSearch(Article article) {
//		System.out.println("아티클 서비스임플 댓글 스타트");
//		int totalArticleSearch = ad.totalArticle();
//		System.out.println("ArticleServiceImpl totlaArticleSearch totalArticleSearch->" + totalArticleSearch);
//		return totalArticleSearch;
//	}
	//리스트 조회
	@Override
	public List<Article> cylistArticle(Article article) {
		List<Article> cylistArticle = null;
		System.out.println("ArticleServiceImpl listManager Start..");
		cylistArticle = ad.cylistArticle(article);
		System.out.println("ArticleServiceImpl listArticle articleList.size()->" +cylistArticle.size());
		return cylistArticle;
	}

	// 상세페이지 조회
	@Override
	public Article cyArticlereadDetail(Article article) {
		System.out.println("ArticleServiceImpl Manager Start..");
		Article result = ad.cyArticlereadDetail(article);
		System.out.println("ArticleServiceImpl cyArticlereadDetail article->" +article);
		return result;
	}
//	// 상세페이지?
//	@Override
//	public Article cydetailArticle(int art_title) {
//		System.out.println("ArticleServiceImpl detail...");
//		Article article = null;
//		article = ad.cydetailArticle(art_title);
//		return article;
//	}
	// 수정페이지 상세페이지
	@Override
	public Article cyArticlereadupdate(Article article) {
		System.out.println("ArticleServiceImpl Manager Start..");
		Article result = ad.cyArticlereadupdate(article);
		System.out.println("ArticleServiceImpl cyArticlereadDetail article->" +article);
		return result;
	}
	
	// 게시물 수정
	@Override
	public int cyArticlemodify(Article article) {
		System.out.println("ArticleServiceImpl update");
		int result = ad.cyArticlemodify(article);
		return result;
	}
	// 게시물 작성
	@Override
	public int cyArticleinsert(Article article) {
		System.out.println("ArticleServiceImpl insert...");
		int result = ad.cyArticleinsert(article);
		return result;
	}
	//상세페이지에서 삭제하기
	@Override
	public Article cyArticledelete(Article article) {
		System.out.println("ArticleServiceImpl delete...");
		int result = ad.cyArticledelete(article);
		return null;
	}
	//조회수 증가
	@Override
	public int cyupdateView(Article article) {
		System.out.println("ArticleServiceImpl updateView");
		int result = ad.cyupdateView(article);
		return result;
	}
	// 게시물 좋아요
	@Override
	public int cyupdateGood(Article article) {
		System.out.println("ArticleServiceImpl updateView");
		int result = ad.cyupdateGood(article);
		return result;
	}
	// 게시물 싫어요
	@Override
	public int cyupdateBad(Article article) {
		System.out.println("ArticleServiceImpl updateView");
		int result = ad.cyupdateBad(article);
		return result;
	}



	
	
	// 최승환
	@Override
	public int totalCustomer(Article article) {
		System.out.println("ArticleServiceImpl Start int total...");
		int totalCustomer = ad.totalCustomer(article);
		System.out.println("ArticleServiceImpl totalCustomer totCustomerCnt-> " + totalCustomer);
		
		return totalCustomer;
	}
	
	@Override
	public List<Article> listCustomer(Article article) {
		List<Article> customerList = null;
		System.out.println("ArticleServiceImpl listCustomer Start..." );
		customerList = ad.listCustomer(article);
		System.out.println("ArticleServiceImpl list customerList.size()->" +customerList.size());
		return customerList;
	}
	@Override
	public Article detailCustomer(Article article) {
		System.out.println("ArticleServiceImpl detailCustomer...");
		Article customerDetail = null;
		customerDetail = ad.detailCustomer(article);
		return customerDetail;
	}
	// 넌 뭐냐
	/*
	 * @Override public List<Article> listCustomerMenu(Article article) {
	 * List<Article> listMenu = null; listMenu = ad.listCustomerMenu(article);
	 * return listMenu; }
	 */
	@Override
	public int insertCustomer(Article article) {
		int result = 0;
		System.out.println("ArticleServiceImpl insertCustomer Start");
		result = ad.insertCustomer(article);
		return result;
	}
	@Override
	public int updateCustomer(Article article) {
		int updateCustomer = 0;
		System.out.println("ArticleServiceImpl updateCustomer Start");
		updateCustomer = ad.updateCustomer(article);
		return updateCustomer;
	}
	@Override
	public int deleteCustomer(Article article) {
		int dresult = 0;
		System.out.println("ArticleServiceImpl deleteCustomer Start");
		dresult = ad.deleteCustomer(article);
		return dresult;
	}
	@Override
	public Integer customerViewCount(Article article) {
		return ad.customerViewCount(article);
	}
	@Override
	public List<Article> shSearchCustomer(Article article) {
		List<Article> shCustomerSearch = null;
		System.out.println("ArticleServiceImpl shSearchCustomer Start..." );
		shCustomerSearch = ad.shCustomerSearch(article);
		System.out.println("ArticleServiceImpl shSearchCustomer shCustomerSearch size()->" +shCustomerSearch.size());
		return shCustomerSearch;
	}
	
	@Override
	public int customLike(Article article) {
		int result = ad.customLike(article);
		return result;
	}
	
	@Override
	public int customDislike(Article article) {
		int result = ad.customDislike(article);
		return result;
	}
	
	
	
	@Override//김진현
	public List<Article> JHgetDutchpayList(Article article) {
		List<Article> List = ad.JHgetDutchpayList(article);
		return List;
	}

	@Override
	public Article JHdetail1(Article article) {
		Article article1 = null;
		article1 = ad.JHdetail2(article);
		return article1;
	}
	
	@Override
	public List<Article> JHrepList1(Article article) {
		List<Article> repList = ad.JHrepList2(article);
		return repList;
	}

	@Override
	public List<Comm> JHpayStatus1() {
		List<Comm> payStatus = null;
		payStatus = ad.JHpayStatus2();
		return payStatus;
	}
	

	public Article JHpayStatusPro1(Article article) {
		Article payStatusPro = null;
		payStatusPro = ad.JHpayStatusPro2(article);
		return payStatusPro;
	}
	
	@Override
	public void JHreplyInsert1(Article article) {
		 rpd.JHreplyInsert2(article);
	}
	
	@Override
	public void JHreplyDelete1(Article article) {
		rpd.JHreplyDelete2(article);
	}

	@Override
	public List<Comm> JHcategory1() {
		List<Comm> cm = null;
		cm = ad.JHcategory2();
		return cm;
	}

	@Override
	public List<Region> JHloc1() {
		List<Region> re = null;
		re = ad.JHloc2();
		return re;
	}

	@Override
	public void JHdutchpayInsert1(Article article) {
		ad.JHdutchpayInsert2(article);
	}
	
	@Override
	public Article JHupdateForm1(Article article) {
		Article updateForm = null;
		updateForm = ad.JHupdateForm2(article);
		return updateForm;
	}

	@Override
	public List<Region> JHloc_ud1() {
		List<Region> re = null;
		re = ad.JHloc_ud2();
		return re;
	}

	@Override
	public void JHdutchpayUpdate1(Article article) {
		ad.JHdutchpayUpdate2(article);
		
	}

	@Override
	public void JHdutchpayDelete1(Article article) {
		ad.JHdutchpayDelete2(article);
		
	}

	@Override
	public int JHDeatilRead1(Article article) {
		int read = 0;
		read = ad.JHDeatilRead2(article);
		return read;
	}
	
	@Override
	public int JHtotalArticle1(Article article) {
		int page = 0;
		page = ad.JHtotalArticle2(article);
		return page;
	}
	
	@Override
	public void JHapplyInsert1(Article article) {
		ad.JHapplyInsert2(article);
	}

	@Override
	public Article JHapplyCancel1(Article article) {
		Article cancel = null;
		cancel = ad.JHapplyCancel2(article);
		return cancel;
	}
	
	@Override
	public Article JHjoinCancel1(Article article) {
		Article joinCancel = null;
		joinCancel = ad.JHjoinCancel2(article);
		return joinCancel;
	}

	@Override
	public List<Article> JHjoinList1(Article article) {
		List<Article> joinList = null;
		joinList = ad.JHjoinList2(article);
		return joinList;
	}
	@Override
	public List<Article> JHwaitList1(Article article) {
		List<Article> waitList = null;
		waitList = ad.JHwaitList2(article);
		return waitList;
	}
	@Override
	public Article JHjoinDeny1(Article article) {
		Article joinDeny1 = null;
		joinDeny1 = ad.JHjoinDeny2(article);
		return joinDeny1;
	}
	@Override
	public Article JHjoinAccept1(Article article) {
		Article joinAccept1 = null;
		joinAccept1 = ad.JHjoinAccept2(article);
		return joinAccept1;
	}
	@Override
	public int JHpayCompleted1(int trd_id) {
		int payCompleted = 0;
		System.out.println("service impl trd_id -> "+trd_id);

		payCompleted = ad.JHpayCompleted2(trd_id);
		return payCompleted;
	}
	@Override
	public int JHJoinListYN(Article article) {
		return jd.JHJoinListYN(article);
	}
	
	@Override
	public int JHWaitListYN(Article article) {
		return wd.JHWaitListYN(article);
	}
	
	@Override
	public void JHfavoriteInsert1(Article article) {
		fd.JHfavoriteInsert2(article);
	}
	@Override
	public int JHfavoriteInsertYN1(Article article) {
		return fd.JHfavoriteInsertYN2(article);
	}
	@Override
	public void JHreplyUpdate1(Article article) {
		rpd.JHreplyUpdate2(article);
	}
	@Override
	public List<Article> JHarticleSearch1(Article article) {
		List<Article> articleSearch = null;
		articleSearch = ad.JHarticleSearch2(article);
		return articleSearch;
	}
	@Override
	public void JHartGood1(Article article) {
		ad.JHartGood2(article);
	}
	@Override
	public void JHartBad1(Article article) {
		ad.JHartBad2(article);
	}
	@Override
	public void JHrepGood1(Article article) {
		ad.JHrepGood2(article);
	}
	@Override
	public void JHrepBad1(Article article) {
		ad.JHrepBad2(article);
	}
	@Override
	public String JHboardName1(int comm_id) {
		return cd.JHboardName2(comm_id);
	}
	@Override
	public List<Comm> JHcommList1() {
		return cd.JHcommList2();
	}

	
}
