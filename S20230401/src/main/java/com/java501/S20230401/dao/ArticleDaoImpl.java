package com.java501.S20230401.dao;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Comm;
import com.java501.S20230401.model.Join;
import com.java501.S20230401.model.Region;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.ArticleMember;
import com.java501.S20230401.model.MemberInfo;
import com.java501.S20230401.util.SummaryType;
import oracle.security.o3logon.a;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.security.o3logon.a;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ArticleDaoImpl implements ArticleDao {
	private final SqlSession session;
	
	
	// 양동균
	@Override
	public int allTotalArt(Article article) {
		int allArtCnt = 0;
		try {
			allArtCnt = session.selectOne("dgAllArtCnt", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allArtCnt;
	}
	// 모든 글 조회
	@Override
	public List<Article> allArticleList(Article article) {
		List<Article> allArticleList = null;
		try {
			allArticleList = session.selectList("dgAllArticleList", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allArticleList;
	}
	// 게시글 조회 (art_id, brd_id)
	@Override
	public Article detailShareArticle(Article article) {
		Article detailArticle = null;
		try {
			detailArticle = session.selectOne("dgDetailShareArticle",article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return detailArticle;
	}
	// 게시글 조회수 증가
	@Override
	public int readShareArticle(Article article) {
		int result = 0;
		try {
			result = session.update("dgReadShareArticle", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// Share 글쓰기 프로시저
	@Override
	public int writeShareArticle(Article article) {
		int result = 0;
		try {
			result = session.insert("dgWriteShareArticle",article);
			if(result>0) System.out.println("성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 글 삭제
	@Override
	public int dgDeleteArticle(Article article) {
		int result = 0;
		try {
			result = session.update("dgDeleteArticle", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 글 추천
	@Override
	public int dgVoteGood(Article article) {
		int result = 0;
		try {
			result = session.update("dgVoteGood", article);
			if(result != 0) result = session.selectOne("dgArtGood", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 글 비추천
	@Override
	public int dgVoteBad(Article article) {
		int result = 0;
		try {
			result = session.update("dgVoteBad", article);
			if(result != 0) result = session.selectOne("dgArtBad", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 게시글 수정
	@Override
	public int updateShare(Article article) {
		int result = 0;
		try {
			result = session.update("dgUpdateArticle", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 글 신고
	@Override
	public int dgReportArticle(Article article) {
		int result = 0;
		try {
			result = session.update("dgReportArticle", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	
	
	
	
	
	// 유현규
	@Override
	public List<ArticleMember> getArticleSummary(int boardNum, SummaryType summaryType) {
		List<ArticleMember> articleList = null;
//		articleList = session.selectList("hgGetSummary" + summaryType.toString(), boardNum);
//		for (ArticleMember am : articleList) {
//			try { am.setHis_good(session.selectOne("hgCalculateGood", am)); }
//			catch(Exception e) { am.setHis_good(0); }
//			try { am.setHis_normal(session.selectOne("hgCalculateNormal", am)); }
//			catch(Exception e) { am.setHis_normal(0); }
//			try { am.setHis_bad(session.selectOne("hgCalculateBad", am)); }
//			catch(Exception e) { am.setHis_bad(0); }
//			if (am.getTrd_id() != 0) {
//				try {
//					am.setTrd_enddate(session.selectOne("hgCalculateEnddate", am));
//				} catch(Exception e) {
//					
//				}
//			}
//			try { am.setRep_count(session.selectOne("hgCountReply", am)); }
//			catch(Exception e) { am.setRep_count(0); }
//		}
		articleList = session.selectList("hgGetSummaryOnce" + summaryType.toString(), boardNum);
		return articleList;
	}
	
	@Override
	public int insertArticle(Article article) {
		return session.insert("hgInsertArticle", article);
	}
	
	@Override
	public Article getArticleById(Article searcher) {
		return session.selectOne("hgGetArticleById", searcher);
	}
	
	@Override
	public MemberInfo getMemberInfoById(int mem_id) {
		return session.selectOne("hgGetMemberInfoById", mem_id);
	}
	
	@Override
	public ArticleMember getArticleMemberById(Article searcher) {
		return session.selectOne("hgGetArticleMemberById", searcher);
	}
	
	@Override
	public List<ArticleMember> hgGetArticlesOfMember(int mem_id) {
		return session.selectList("hgGetArticlesOfMember", mem_id);
	}
	
	@Override
	public int hgIncreaseReadCount(Article searcher) {
		return session.update("hgIncreaseReadCount", searcher);
	}
	
	@Override
	public int hgRecommendArticle(Article searcher) {
		return session.update("hgRecommendArticle", searcher);
	}
	
	@Override
	public int hgCompressedUpdateArticle(Article article) {
		return session.update("hgCompressedUpdateArticle", article);
	}
	
	@Override
	public int hgDeleteArticle(Article article) {
		return session.update("hgDeleteArticle", article);
	}
	
	@Override
	public int hgRestoreArticle(Article article) {
		return session.update("hgRestoreArticle", article);
	}
	
	@Override
	public int hgInsertAdminArticle(Article article) {
		return session.insert("hgInsertAdminArticle", article);
	}
	
	@Override
	public List<Article> hgAdminArticleList(Article searcher) {
		return session.selectList("hgAdminArticleList", searcher);
	}
	
	@Override
	public int hgGetCountAllArticle() {
		return session.selectOne("hgGetCountAllArticle");
	}
	
	@Override
	public List<Article> hgGetArticles(Article searcher) {
		return session.selectList("hgGetArticles", searcher);
	}
	
	
	// 백준
	@Override
	public Integer bjTotalArticle(Article article) {
		int totArticleCount = 0;
		try {
			totArticleCount = session.selectOne("bjarticleCnt", article);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return totArticleCount;
	}

	@Override
	public List<Article> articleTotal(Article article) {
		List<Article> articleList = null;
		
		try {
			articleList = session.selectList("bjarticleIndexAll",article);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		return articleList;
	}

	@Override
	public Article detailContent(Article article) {
		Article detailCon = new Article();
		
		try {
			detailCon = session.selectOne("bjdetailContent",article);
		} catch (Exception e) {
			System.out.println("에러"+e.getMessage());
		}
		return detailCon;
	}
	
	@Override
	public List<Article> artcleMenu(Article article) {
		List<Article> articleMenu = null;
		try {
			articleMenu = session.selectList("bjArticleMenu",article);
		} catch (Exception e) {
			System.out.println("게시판 메뉴에러"+e.getMessage());
		}
		return articleMenu;
	}

	@Override
	public Integer replyCount(int art_id) {
		int countReply = 0;
		try {
			countReply = session.selectOne("bjCountReply", art_id);
		} catch (Exception e) {
			System.out.println("리플 에러"+e.getMessage());
		}
		
		return countReply;
	}

	@Override
	public Integer upreadCount(Article article) {
		System.out.println("아티클 조회수 다오임플 시작");
		Article countUpread = article;
		System.out.println("아티칼 조회수 카운트업리드"+countUpread);
		Integer count = 0;
		try {
			count = session.update("bjreadCount",countUpread);
			System.out.println("업데이트 결과 "+count);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public List<Article> listMagnager() {
		List<Article> bjwrite = null;
		try {
			bjwrite = session.selectList("bjWriteArticle");
		} catch (Exception e) {
			System.out.println("에러->"+e.getMessage());
		}
		return bjwrite;
	}

	@Override
	public int bjWriteArticle(Article article) {
		System.out.println("아티클다오임플 라이트아티클 시작");
		int writeArticle = 0;
		
		try {
			writeArticle = session.insert("bjWriteArticle", article);
			System.out.println("아티클 다오 임플 라이트아티클1"+ writeArticle);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		System.out.println("아티클 다오 임플 라이트아티클2"+ writeArticle);
		return writeArticle;
	}
	
	@Override
	public int bjUpdateArticle(Article article) {
		int update = 0;
		try {
			update = session.update("bjUpdate",article);
		} catch (Exception e) {
			System.out.println("업데이트에러"+e.getMessage());
		}
		System.out.println("업데이트 아티클값->"+article);
		return update;
	}

	@Override
	public int delete(Article article) {
		int delResult = 0;
		try {
			delResult = session.update("bjDelete",article);
		} catch (Exception e) {
			System.out.println("삭제대기에러"+e.getMessage());
		}
		return delResult;
	}
	
	@Override
	public int replyWrite(Reply reply) {
		int reWrite = 0;
		try {
			reWrite = session.insert("bjReplyWrite",reply);
		} catch (Exception e) {
			System.out.println("댓글쓰기에러"+e.getMessage());
		}
		return reWrite;
	}

	@Override
	public int replyDelete(Reply reply) {
		int reDelete= 0;
		try {
			reDelete = session.insert("bjReplyDelete",reply);
		} catch (Exception e) {
			System.out.println("댓글쓰기에러"+e.getMessage());
		}
		return reDelete;
	}
	
	@Override
	public List<Article> bjArtSearch(Article article) {
		List<Article> bjSearch = null;
		try {
			bjSearch = session.selectList("bjSearch", article);
		} catch (Exception e) {
			System.out.println("검색 다오임플 에러" + e.getMessage());
		}
		System.out.println("아티클 다오 검색 값" + bjSearch);
		for (Article art : bjSearch) System.out.println(art);
		System.out.println("아티클 다오 아티클 값" + article);
		
		return bjSearch;
	}
	
	@Override
	public Integer bjGood(Article article) {
		Integer good = 0;
		
		try {
			good = session.insert("bjGood" , article);
		} catch (Exception e) {
			System.out.println("아티클다오임플 추천 에러"+e.getMessage());
		}
		return good;
	}
	@Override
	public Integer bjBad(Article article) {
		Integer bad = 0;
		
		try {
			bad = session.insert("bjBad" , article);
		} catch (Exception e) {
			System.out.println("아티클다오임플 비추천 에러"+e.getMessage());
		}
		return bad;
	}
	
	@Override
	public List<Comm> bjcommList(int comm_id) {
		List<Comm> commList = null;
		try {
			commList = session.selectList("dgCommList", comm_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return commList;
	}
	
	@Override
	public String bjCategoryName(int comm_id) {
		String categoryName = "";
		try {
			categoryName = session.selectOne("dgCategoryName", comm_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categoryName;
	}
	
	
	//=================================================================================================
	
	
	
	// 임동빈
	@Override
	public int dbtotalArticle(Article article) {
		int totArticleCount = 0;

		try {
			if (article.getBrd_id() == 1000) {
				totArticleCount = session.selectOne("dbArticleTotalCnt", article);
			} else {
				totArticleCount = session.selectOne("dbArticleBoardCnt", article);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return totArticleCount;
	}

	@Override
	public List<Article> dbListArticle(Article article) {
		List<Article> articleList = null;
		try {
			// article.getBrd_id() 따라서 분기 --> 전체
			if (article.getBrd_id() == 1000) {
				articleList = session.selectList("dbArticleListAll", article);
			} else {
				// 1010 밥/카페
				// 1020 스포츠/운동
				// 1030 쇼핑
				// 1040 문화 생활
				// 1050 취미 생활
				// 1060 기타
				articleList = session.selectList("dbArticleListBoard", article);
			}
		} catch (Exception e) {
			System.out.println( e.getMessage());
		}
		return articleList;
	}
	@Override
	public Article dbdetailArticle(Article article) {
		Article detailArticle = null;
		try {
			detailArticle = session.selectOne("dbArticleDetail", article);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return detailArticle;
	}
	@Override
	public List<Article> dbreplyList(Article article) {
		List<Article> replyList = null;
		try {
			replyList = session.selectList("dbReplyList", article);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return replyList;
	}

	@Override
	public void dbWriteArticle(Article article) {
		try {
			session.selectOne("dbInsertArticle", article);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	@Override
	public int dbdeleteArticle(Article article) {
		int deleteArticle = 0;

		try {
			deleteArticle = session.update("dbDeleteArticle", article);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl deleteArticle => " + e.getMessage());
		}
		return deleteArticle;
	}
	@Override
	public void dbUpdateArticle(Article article) {
		try {
			session.selectOne("dbUpdateArticle", article);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	@Override
	public int dbReadArticleCnt(Article article) {
		int dbReadArticleCnt = 0;
		try {
			dbReadArticleCnt = session.update("dbReadArticleCnt", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbReadArticleCnt;
	}
	
	@Override
	public Article dbInsertReportArticle(Article article) {
		Article dbInsertReportArticle = null;
		try {
			dbInsertReportArticle = session.selectOne("dbInsertReportArticle", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbInsertReportArticle;
	}
	
	@Override
	public Article dbInsertReportReply(Article article) {
		Article dbInsertReportReply = null;
		try {
			dbInsertReportReply = session.selectOne("dbInsertReportReply", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbInsertReportReply;
	}

	@Override
	public List<Article> dbTradeJoinMember(Article article) {
		List<Article> joinList = null;
		
		try {
			joinList = session.selectList("dbTradeJoinMember", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
		return joinList;
	}
		
	public List<Article> dbTradeWaitingMember(Article article) {
		List<Article> WaitingList = null;
		
		try {
			WaitingList = session.selectList("dbTradeWaitingMember", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 
		return WaitingList;
	}
	
	
	@Override
	public int dbTradeWaiting(Article article) {
		int TradeWaiting = 0;
		
		try {
			TradeWaiting = session.insert("dbTradeWaiting", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return TradeWaiting;                                    
	}
	
	@Override
	public int dbTradeInsertJoin(Article article) {
		int TradeInsertJoin = 0;
		try {
			TradeInsertJoin = session.insert("dbTradeInsertJoin", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return TradeInsertJoin;
	}
	
	
	@Override
	public int dbTradeDeleteWaiting(Article article) {
		int TradeDeleteWaiting = 0;
		try {
			TradeDeleteWaiting = session.delete("dbTradeDeleteWaiting", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return TradeDeleteWaiting;
	}
	
	@Override
	public int dbJoinDelete(Article article) {
		int JoinDelete = 0;
		try {
			JoinDelete = session.delete("dbJoinDelete", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JoinDelete;
	}
	
	@Override
	public int dbFavoriteArticle(Article article) {
		int favoriteArticle = 0;
		try {
			favoriteArticle = session.insert("dbFavoriteArticle", article);
		} catch (Exception e) {
			favoriteArticle = -1;
			e.printStackTrace();
			
		}
		return favoriteArticle;
	}
	
	@Override
	public int dbFavoriteArticleDelete(Article article) {
		int dbFavoriteArticleDelete = 0;
		try {
			dbFavoriteArticleDelete = session.delete("dbFavoriteArticleDelete", article);
		} catch (Exception e) {
			e.printStackTrace();	
		}
		return dbFavoriteArticleDelete;
	}
	
	@Override
	public int dbChangeStatus(Article article) {
		int changeStatus = 0;
		try {
			changeStatus = session.update("dbChangeStatus", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return changeStatus;
	}
	
	@Override
	public int dbChangeEndStatus(Article article) {
		int changeEndStatus = 0;
		try {
			changeEndStatus = session.update("dbChangeEndStatus", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return changeEndStatus;
	}
	
	@Override
	public int dbChangeCancelStatus(Article article) {
		int dbChangeCancelStatus = 0;
		try {
			dbChangeCancelStatus = session.update("dbChangeCancelStatus", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbChangeCancelStatus;
	}
	
	@Override
	public int dbArticleGoodUp(Article article) {
		int dbArticleGoodUp = 0;
		try {
			dbArticleGoodUp = session.update("dbArticleGoodUp", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbArticleGoodUp;
	}
	
	@Override
	public int dbArticleBadUp(Article article) {
		int dbArticleBadUp = 0;
		try {
			dbArticleBadUp = session.update("dbArticleBadUp", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbArticleBadUp;
	}
	
	@Override
	public int dbReplyGoodUp(Article article) {
		int dbReplyGoodUp = 0;
		try {
			dbReplyGoodUp = session.update("dbReplyGoodUp", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbReplyGoodUp;
	}
	
	@Override
	public int dbReplyBadUp(Article article) {
		int dbReplyBadUp = 0;
		try {
			dbReplyBadUp = session.update("dbReplyBadUp", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbReplyBadUp;
	}
	
	@Override
	public int dbCondArticleCnt(Article article) {
		int dbCondArticleCnt = 0;
		try {
			dbCondArticleCnt = session.selectOne("dbCondArticleCnt", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbCondArticleCnt;
	}
	
	
	@Override
	public List<Article> dbListSearchArticle(Article article) {
		List<Article> dbListSearchArticle = null;
		try {
			dbListSearchArticle = session.selectList("dbListSearchArticle", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbListSearchArticle;
	}
	
	
	
	

	
	// 김찬영
	// 총리스트
	@Override
	public int cytotalArticle() {
		int cytotArticleCount = 0;
		System.out.println("ArticleImpl Start total...");
		
		try {
			cytotArticleCount = session.selectOne("cyArticleTotal");
			System.out.println("ArticleImpl totalArticle cytotArticleCount->" + cytotArticleCount);
		} catch (Exception e) {
			System.out.println("ArticleImpl cytotalArticle Exception->"+e.getMessage());
		}
		
		return cytotArticleCount;
	}
	//검색
//	@Override
//	public int totalArticleSearch(Article article) {
//		int searchArticleCount = 0;
//		System.out.println("아티클다오임플 검색..");
//		try {
//			searchArticleCount = session.selectOne("cyArticleKeyword", article);
//			System.out.println("아티클임플 서치아티클 카운트 ->" + searchArticleCount);
//		} catch (Exception e) {
//			System.out.println("아티클 임플 서치아티클 Exception->"+ e.getMessage());
//		}
//		return searchArticleCount;
//	}
	
	// 리스트조회
	@Override
	public List<Article> cylistArticle(Article article) {
		List<Article> cylistArticle = null;
		System.out.println("ArticleDaoImpl listArticle Start...");
		try {
			cylistArticle = session.selectList("cyArticleListAll", article);
		} catch (Exception e) {
			System.out.println("ArticleImpl listArticle e.getMessage()->"+e.getMessage());
		}
		return cylistArticle;
	}
	

	//상세페이지
	@Override
	public Article cyArticlereadDetail(Article article) {
		System.out.println("ArticleDaoImpl article Start...");
		Article result = null;
		try {
			result = session.selectOne("cyArticlereadDetail", article);
		} catch (Exception e) {
			System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
		}
		return result;
	}
	// 상세페이지
	@Override
	public Article cydetatilArticle(int art_title) {
		System.out.println("ArticleDaoImpl detail start..");
		Article article = new Article();
		
		try {
			article = session.selectOne("cyArticleSelOne", art_title);
			System.out.println("ArticleImpl detail brd_id->" +article.getBrd_id());
		} catch (Exception e) {
			System.out.println("articleDaoImpl detail Excpetion->"+e.getMessage());
		}
		
		return article;
	}
	//상세페이지 수정
	@Override
	public Article cyArticlereadupdate(Article article) {
		System.out.println("ArticleDaoImpl article Start...");
		Article result = null;
		try {
			result = session.selectOne("cyArticlereadupdate", article);
		} catch (Exception e) {
			System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
		}
		return result;
	}
	// 게시물 작성
	@Override
	public int cyArticleinsert(Article article) {
		System.out.println("ArticleDaoImpl insert Start...");
		int result = 0;
		try {
			result = session.insert("cyArticleinsert", article);
		} catch (Exception e) {
			System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
		}
		return result;
	}
	//게시물 수정
	@Override
	public int cyArticlemodify(Article article) {
		System.out.println(article);
		System.out.println("ArticleDaoImpl modify Start...");
		int result = 0;
		try {
			result = session.update("cyArticlemodify", article);
		} catch (Exception e) {
			System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
		}
		return result;
	}
	@Override
	public int cyArticledelete(Article article) {
		System.out.println(article);
		System.out.println("ArticleDaoImpl delete Start...");
		int result = 0;
		try {
			result = session.delete("cyArticledelete", article);
		} catch (Exception e) {
			System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
		}
		return result;
	}
		//조회수
		@Override
		public int cyupdateView(Article article) {
			System.out.println(article);
			System.out.println("ArticleDaoImpl updateView Start..article");
			int result = 0;
			try {
				result = session.update("cyUpdateView", article);
			} catch (Exception e) {
				System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
			}
			return result;
		}
		//추천
		@Override
		public int cyupdateGood(Article article) {
			System.out.println(article);
			System.out.println("ArticleDaoImpl updateView Start..article");
			int result = 0;
			try {
				result = session.update("cyUpdateGood", article);
			} catch (Exception e) {
				System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
			}
			return result;
		}
		//비추천
		@Override
		public int cyupdateBad(Article article) {
			System.out.println(article);
			System.out.println("ArticleDaoImpl updateView Start..article");
			int result = 0;
			try {
				result = session.update("cyUpdateBad", article);
			} catch (Exception e) {
				System.out.println("ArticleImpl article e.getMessage()->"+e.getMessage());
			}
			return result;
		}
	
	
		
		
		
		
		
	
	// 최승환
		
	@Override
	public int totalCustomer(Article article) {
		int totCustomerCount = 0;
		System.out.println("ArticleDaoImpl Start int totalCustomer...");
		
		try {
			totCustomerCount = session.selectOne("shCustomerCount", article);
			System.out.println("ArticleDaoImpl shCustomerCount int totCustomerCount->" +totCustomerCount);
			
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl int shCustomerCount Exception->"+e.getMessage());
		}
		return totCustomerCount;
	}	
		
	// 전체글 조회
	@Override
	public List<Article> listCustomer(Article article) {
		List<Article> customerList = null;
		System.out.println("ArticleDaoImpl listCustomer Start ..." );
		try {
			//                             Map ID        parameter
			customerList = session.selectList("shListCustomer", article);
			System.out.println("ArticleDaoImpl listCustomer customerList.size()->"+customerList.size());
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl listCustomer e.getMessage()->"+e.getMessage());
		}
		return customerList;	
	}
	
	
	// 상세페이지
	@Override
	public Article detailCustomer(Article article) {
		System.out.println("ArticleDaoImpl detailCustomer start...");
		Article customerDetail = new Article();
		try {
			customerDetail = session.selectOne("shCustomerDetail", article);
		
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl detail Exception->"+e.getMessage());
		}
		return customerDetail;
	}
	
	// 넌뭐냐
	/*
	 * @Override public List<Article> listCustomerMenu(Article article) {
	 * List<Article> listMenu = null; try { listMenu =
	 * session.selectList("shListCustomerMenu", article);
	 * System.out.println("다오 리스트메뉴"+listMenu); } catch (Exception e) {
	 * System.out.println("메뉴에러"+e.getMessage()); }
	 * 
	 * return listMenu; }
	 */
	
	@Override
	public int insertCustomer(Article article) {
		int result = 0;
		System.out.println("ArticleDaoImpl insertCustomer start...");
		try {
			result = session.insert("shInsertCustomer", article);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl insertCustomer Exception->"+e.getMessage());
		}
		return result;
	}
	
	
	
	@Override
	public int updateCustomer(Article article) {
		int updateCount = 0;
		System.out.println("ArticleDaoImpl updateCustomer start");
		try {
			updateCount = session.update("shCustomerUpdate", article);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl updateCustomer Exception->"+e.getMessage());
		}
		
		System.out.println("아티클다오임플 업데이트"+ article);
		return updateCount;
	}
	
	@Override
	public int deleteCustomer(Article article) {
		int dresult = 0;
		System.out.println("ArticleDaoImpl deleteCustomer start");
		try {
			dresult = session.delete("shDeleteCustomer", article);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl deleteCustomer Exception->"+e.getMessage());
		}
		return dresult;
	}
	
	@Override
	public Integer customerViewCount(Article article) {
		System.out.println("ArticleDaoImpl customerViewCount start");
		Article viewCountCustomer = article;
		System.out.println("ArticleDaoImpl customerViewCount"+viewCountCustomer);
		Integer vCount = 0;
		try {
			vCount = session.update("shViewCount", viewCountCustomer);
			System.out.println("뷰카운트 업데이트"+vCount);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl customerViewCount Exception->"+e.getMessage());
		}
		return vCount;
	}

	
	@Override
	public List<Article> shCustomerSearch(Article article) {
		List<Article> shCustomerSearch = null;
		System.out.println("ArticleDaoImpl shCustomerSearch Start" );
		try {
			shCustomerSearch = session.selectList("shCustomerSearch", article);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl shCustomerSearch Exception->"+e.getMessage());
		}
		return shCustomerSearch;
	}
	
	@Override
	public int customLike(Article article) {
		int result = 0;
		try {
			result = session.update("shCustomLike", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public int customDislike(Article article) {
		int result = 0;
		try {
			result = session.update("shCustomDislike", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	
	//김진현
		@Override
		public List<Article> JHgetDutchpayList(Article article) {
			List<Article> dutchpayList2 = null;
			try {
				// article.getBrd_id() 따라서 분기 --> 전체
				if (article.getBrd_id() == 1100) {
					dutchpayList2 = session.selectList("JHDutchpay", article);
				} else {
					// 1010 밥/카페
					// 1020 스포츠/운동
					// 1030 쇼핑
					// 1040 문화 생활
					// 1050 취미 생활
					// 1060 기타
					dutchpayList2 = session.selectList("JHDutchpay", article);
				}
				System.out.println("Dao brd_id -> "+article.getBrd_id());
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl dutchpayList2 Exception -> "+e.getMessage());
			}
			return dutchpayList2;
		}

		@Override
		public Article JHdetail2(Article article) {
			Article article2 = null;
			try {				
				article2 = session.selectOne("JHDutchpayDetail",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl detail2 Exception -> "+e.getMessage());
			}
			return article2;
		}
		
		@Override
		public List<Article> JHrepList2(Article article) {
			List<Article> repList = null;
			try {
				repList = session.selectList("JHRepList",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl repList2 Exception -> "+e.getMessage());
			}
			return repList;
		}

		@Override
		public List<Comm> JHpayStatus2() {
			List<Comm> payStatus = null;
			try {
				payStatus = session.selectList("JHPayStatus");
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl payStatus2 Exception -> "+e.getMessage());
			}
			return payStatus;
		}
		
		@Override
		public Article JHpayStatusPro2(Article article) {
			Article payStatusPro = null;
			try {
				payStatusPro = session.selectOne("JHPayStatusPro",article);  
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl payStatusPro2 Exception -> "+e.getMessage());
			}
			return payStatusPro;
		}
		
		@Override
		public void JHdutchpayInsert2(Article article) {
			try {
				System.out.println("article Dao -> "+article);
				session.selectOne("JHInsert",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl dutchpayInsert2 Exception -> "+e.getMessage());
			}
		}
		
		@Override
		public List<Comm> JHcategory2() {
			List<Comm> cm = null;
			try {
				cm = session.selectList("JHCategory");
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl category2 Exception -> "+e.getMessage());
			}
			return cm;
		}


		@Override
		public List<Region> JHloc2() {
			List<Region> re = null;
			try {
				re = session.selectList("JHLoc");
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl region2 Exception -> "+e.getMessage());
			}
			return re;
		}

		
		@Override
		public Article JHupdateForm2(Article article) {
			Article updateForm = null;
			try {
				updateForm = session.selectOne("JHUpdateForm",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl updateForm2 Exception -> "+e.getMessage());
			}
			return updateForm;
		}

		@Override
		public List<Region> JHloc_ud2() {
			List<Region> re = null;
			try {
				re = session.selectList("JHLocUd");
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl loc_ud2 Exception -> "+e.getMessage());
			}
			return re;
		}
		
		@Override
		public void JHdutchpayUpdate2(Article article) {
			try {
				System.out.println(article);
				session.selectOne("JHUpdate",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl dutchpayUpdate2 Exception -> "+e.getMessage());
			}
		}
		
		@Override
		public void JHdutchpayDelete2(Article article) {
			try {
				session.selectOne("JHDelete",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl dutchpayDelete2 Exception -> "+e.getMessage());
			}
		}
		
		@Override
		public int JHDeatilRead2(Article article) {
			int read = 0;
			try {
				read = session.update("JHDeatilRead",article);
			} catch (Exception e) {
			}
			return read;
		}
		
		
		
		@Override
		public int JHtotalArticle2(Article article) {
			int page = 0;
			System.out.println("ArticleDaoImple Start paging...");
		      
			try {
					page = session.selectOne("JHarticleCnt",article);
				System.out.println("ArticleDaoImpl totalArticle page-> " + page);

			} catch (Exception e) {
				System.out.println("ArticleDaoImpl totalArticle2 Exception -> "+e.getMessage());
			}
			return page;
		}
		

		@Override
		public void JHapplyInsert2(Article article) {
			try {
				session.selectOne("JHJoinApply",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl applyInsert2 Exception -> "+e.getMessage());
			}
		}
		
		@Override
		public Article JHapplyCancel2(Article article) {
			Article cancle = null;
			try {
				cancle = session.selectOne("JHapplyCancel",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl applyCancel2 Exception -> "+e.getMessage());

			}
			return cancle;
		}
		
		@Override
		public Article JHjoinCancel2(Article article) {
			Article joinCancel = null;
			try {
				joinCancel = session.selectOne("JHJoinCancel",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl joinCancel2 Exception -> "+e.getMessage());
			}
			return joinCancel;
		}

		@Override
		public List<Article> JHjoinList2(Article article) {
			List<Article> joinList2 = null;
			try {
				joinList2 = session.selectList("JHJoinList",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl joinList2 Exception -> "+e.getMessage());
			}
			return joinList2;
		}
		@Override
		public List<Article> JHwaitList2(Article article) {
			List<Article> waitList2 = null;
			try {
				waitList2 = session.selectList("JHWaitList",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl waitList2 Exception -> "+e.getMessage());
			}
			return waitList2;
		}
		
		@Override
		public Article JHjoinDeny2(Article article) {
			Article joinDeny2 = null;
			try {
				joinDeny2 = session.selectOne("JHJoinDeny",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl joinDeny2 Exception -> "+e.getMessage());
			}
			return joinDeny2;
		}
		
		@Override
		public Article JHjoinAccept2(Article article) {
			Article joinAccept2 = null;
			try {
				joinAccept2 = session.selectOne("JHJoinAccept",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl joinAccept2 Exception -> "+e.getMessage());
			}
			return joinAccept2;
		}
		@Override
		public int JHpayCompleted2(int trd_id) {
			int payCompleted = 0;
			System.out.println("daoimpl trd_id -> "+trd_id);
			try {
				payCompleted = session.selectOne("JHPayCompleted",trd_id);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl payCompleted2 Exception -> "+e.getMessage());
			}
			return payCompleted;
		}
		@Override
		public List<Article> JHarticleSearch2(Article article) {
			List<Article> articleSearch = null;
			try {
				articleSearch = session.selectList("JHArticleSearch",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl articleSearch2 Exception -> "+e.getMessage());
			}
			return articleSearch;
		}
		
		@Override
		public void JHartGood2(Article article) {
			try {
				session.selectOne("JHArtGood",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl ArtGood2 Exception -> "+e.getMessage());
			}
		}
		
		@Override
		public void JHartBad2(Article article) {
			try {
				session.selectOne("JHArtBad",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl ArtBad2 Exception -> "+e.getMessage());
			}
		}
		
		@Override
		public void JHrepGood2(Article article) {
			try {
				session.selectOne("JHRepGood",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl repGood2 Exception -> "+e.getMessage());
			}
		}
		
		@Override
		public void JHrepBad2(Article article) {
			try {
				session.selectOne("JHRepBad",article);
			} catch (Exception e) {
				System.out.println("ArticleDaoImpl repBad Exception -> "+e.getMessage());
			}
		}
		
		

}