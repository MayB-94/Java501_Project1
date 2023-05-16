package com.java501.S20230401.dao;

import java.util.List;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.ArticleMember;
import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.util.SummaryType;

public interface ArticleDao {

	// 유현규
	public List<ArticleMember> getArticleSummary(int boardNum, SummaryType summaryType);
	public int insertArticle(Article article);
	public Article getArticleById(Article searcher);
	public MemberInfo getMemberInfoById(int mem_id);
	public ArticleMember getArticleMemberById(Article searcher);
	public List<ArticleMember> hgGetArticlesOfMember(int mem_id);
	public int hgIncreaseReadCount(Article searcher);
	public int hgRecommendArticle(Article searcher);
	public int hgCompressedUpdateArticle(Article article);
	public int hgDeleteArticle(Article article);
	public int hgRestoreArticle(Article article);
	public int hgInsertAdminArticle(Article article);
	public List<Article> hgAdminArticleList(Article searcher);
	public int hgGetCountAllArticle();
	public List<Article> hgGetArticles(Article searcher);
	
	
	// 양동균
	int allTotalArt(Article article);				// 글 카운트
	List<Article> allArticleList(Article article);	// 모든 글 조회
	Article detailShareArticle(Article article);	// 댓글
	int readShareArticle(Article article);			// 조회수
	int writeShareArticle(Article article);			// 글쓰기
	int dgDeleteArticle(Article article); 			// 글 삭제
	int dgVoteGood(Article article);				// 글 추천
	int dgVoteBad(Article article);					// 글 비추천
	int updateShare(Article article);				// 글 수정
	int dgReportArticle(Article article);

	
	// 백준
	Integer 						bjTotalArticle(Article article);
	List<Article> 					articleTotal(Article article);
	Article 						detailContent(Article article);
	Integer							replyCount(int art_id);
	List<Article> 					artcleMenu(Article article);
	Integer 						upreadCount(Article article);
	List<Article> 					listMagnager();
	int 							bjWriteArticle(Article article);
	int 							bjUpdateArticle(Article article);
	int								delete(Article article);
	int 							replyWrite(Reply reply);
	int 							replyDelete(Reply reply);
	List<Article>					bjArtSearch(Article article);
	Integer 						bjGood(Article article);
	Integer							bjBad(Article article);
	List<Comm> 						bjcommList(int comm_id);
	String 							bjCategoryName(int comm_id);
	
	
	
	// 임동빈
	int 			dbtotalArticle(Article article);
	List<Article> 	dbListArticle(Article article);
	Article 		dbdetailArticle(Article article);
	List<Article> 	dbreplyList(Article a);
	void 			dbWriteArticle(Article article);
	void 			dbUpdateArticle(Article article);
	int 			dbdeleteArticle(Article article);
	int 			dbReadArticleCnt(Article article);
	Article		    dbInsertReportArticle(Article article);
	Article			dbInsertReportReply(Article article);
	List<Article> 	dbTradeJoinMember(Article article);
	List<Article>	dbTradeWaitingMember(Article article);
	int 			dbTradeWaiting(Article article);
	int 			dbTradeInsertJoin(Article article);
	int 			dbTradeDeleteWaiting(Article article);
	int 			dbJoinDelete(Article article);
	int 			dbFavoriteArticle(Article article);
	int 			dbFavoriteArticleDelete(Article article);
	int 			dbChangeStatus(Article article);
	int 			dbChangeEndStatus(Article article);
	int 			dbChangeCancelStatus(Article article);
	int 			dbArticleGoodUp(Article article);
	int 			dbArticleBadUp(Article article);
	int             dbReplyGoodUp(Article article);
	int				dbReplyBadUp(Article article);
	int 			dbCondArticleCnt(Article article);
	List<Article>   dbListSearchArticle(Article article);
	
	
	
	
	
	
	
	
	
	
	// 김찬영
	int				cytotalArticle();								
	List<Article> 	cylistArticle(Article article);				
//	List<Article> 	cylistReply(Article article);				
	Article			cyArticlereadDetail(Article article);		
	Article 		cyArticlereadupdate(Article article);		
	Article 		cydetatilArticle(int art_title);				
	int				cyArticleinsert(Article article);			
	int				cyArticlemodify(Article article);			
	public int 		cyArticledelete(Article article);			
	int				cyupdateView(Article article);
	int				cyupdateGood(Article article);
	int				cyupdateBad(Article article);
//	public int 		cytotalArticleSearch(Article article);
	
	// 최승환
	int 			totalCustomer(Article article);
	List<Article> 	listCustomer(Article article);
	Article 		detailCustomer(Article article);
	//List<Article> 	listCustomerMenu(Article article); //??
	int 			insertCustomer(Article article);
	int 			updateCustomer(Article article);
	int 			deleteCustomer(Article article);
	Integer 		customerViewCount(Article article);
	List<Article> 	shCustomerSearch(Article article);
	int 			customLike(Article article);
	int 			customDislike(Article article);
	
	
	
	// 김진현
	List<Article> 			JHgetDutchpayList(Article article);
	Article                 JHdetail2(Article article);
	public List<Article> 	JHrepList2(Article article);
	public List<Comm>       JHpayStatus2();
	public Article 			JHpayStatusPro2(Article article);
	List<Comm>           	JHcategory2();
	List<Region>    		JHloc2();
	public void 			JHdutchpayInsert2(Article article);
	Article 				JHupdateForm2(Article article);
	List<Region> 			JHloc_ud2();
	void 					JHdutchpayUpdate2(Article article);
	void 					JHdutchpayDelete2(Article article);
	public int 				JHDeatilRead2(Article article);
	public int 				JHtotalArticle2(Article article);
	void                    JHapplyInsert2(Article article);
	public Article 			JHapplyCancel2(Article article);
	public Article 			JHjoinCancel2(Article article);
	public List<Article>    JHjoinList2(Article article);
	public List<Article>    JHwaitList2(Article article);
	public Article 			JHjoinDeny2(Article article);
	public Article          JHjoinAccept2(Article article);
	public int              JHpayCompleted2(int trd_id);
	public List<Article>    JHarticleSearch2(Article article);
	public void             JHartGood2(Article article);
	public void             JHartBad2(Article article);
	public void 			JHrepGood2(Article article);
	public void 			JHrepBad2(Article article);

	
	
	
	
	
}