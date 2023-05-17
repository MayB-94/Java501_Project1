package com.java501.S20230401.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.ReplyMember;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReplyDaoImpl implements ReplyDao {
	private final SqlSession session;
	
	// 양동균
	// 댓글 리스트
	@Override
	public List<Reply> replyShareList(Article article) {
		List<Reply> replyList = null;
		try {
			replyList = session.selectList("gdReplyShareList", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return replyList;
	}
	// 댓글 작성
	@Override
	public int writeReply(Reply reply) {
		int reulst = 0;
		try {
			reulst = session.insert("dgWriteReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reulst;
	}
	// 댓글 삭제
	@Override
	public int deleteReply(Reply reply) {
		int result = 0;
		try {
			result = session.update("dgDeleteReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 댓글 업데이트
	@Override
	public int dgUpdateReply(Reply reply) {
		int result = 0;
		try {
			result = session.update("dgUpdateReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 댓글 신고
	@Override
	public int dgReportReply(Reply reply) {
		int result = 0;
		try {
			result = session.update("dgReportReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	
	// 백준
	@Override
	public Reply replyCount(Reply reply) {
		Reply countReply = null;
		try {
			countReply = session.selectOne("bjCountReply",reply);
		} catch (Exception e) {
			System.out.println("댓글수에러"+e.getMessage());
		}
		return countReply;
	}
	
	@Override
	public List<Reply> replyMain(Reply reply) {
		List<Reply> mainReply = null;
		try {
			mainReply = session.selectList("bjreplyMain",reply);
		} catch (Exception e) {
			System.out.println("댓글에러"+e.getMessage());
		}
		return mainReply;
	}
	
	@Override
	public int bjreReply(Reply reply) {
		int reReply = 0;
		try {
			reReply = session.update("bjreReply",reply);
		} catch (Exception e) {
			System.out.println("대댓글에러"+e.getMessage());
		}
		System.out.println("대댓글 다오임플 ->"+ reply);
		return reReply;
	}	
	
	@Override
	public int bjReGood(Reply reply) {
		int reGood = 0;
		try {
			reGood = session.update("bjReGood",reply);
		} catch (Exception e) {
			System.out.println("댓글추천에러"+e.getMessage());
		}
		return reGood;
	}
	@Override
	public int bjReBad(Reply reply) {
		int reBad = 0;
		try {
			reBad = session.update("bjReBad",reply);
		} catch (Exception e) {
			System.out.println("댓글추천에러"+e.getMessage());
		}
		return reBad;
	}
	
	// 최승환
	@Override
	public int shReplyCount(Reply reply) {
		System.out.println("댓글수 다오 시작");
		int countReply = 0;
		try {
			countReply = session.selectOne("shcountReply", reply);
		} catch (Exception e) {
			System.out.println("댓글수에러"+e.getMessage());
		}
		return countReply;
	}
	@Override
	public List<Reply> replyList(Article article) {
		System.out.println("댓글 다오 시작");
		
		List<Reply> listReply = null;
		
		try {
			listReply = session.selectList("shlistReply", article);
		} catch (Exception e) {
			System.out.println("댓글에러"+e.getMessage());
		}
		System.out.println("댓글다오임플 리플값"+ article);
		return listReply;
	}
	
	@Override
	public int customerWriteReply(Reply reply) {
		int cReplyWrite = 0;
		System.out.println("ArticleDaoImpl customerWriteReply start");
		try {
			cReplyWrite = session.insert("shWriteReply", reply);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl customerWriteReply Exception->"+e.getMessage());
		}
		return cReplyWrite ;
	}
	@Override
	public int customerDeleteReply(Reply reply) {
		int deleteResult = 0;
		System.out.println("ArticleDaoImpl customerDeleteReply start");
		try {
			deleteResult = session.delete("shDeleteReply", reply);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl customerDeleteReply Exception->"+e.getMessage());
		}
		return deleteResult;
	}
	@Override
	public int customerUpdateReply(Reply reply) {
		int upRResult = 0;
		System.out.println("ArticleDaoImpl customerUpdateReply start");
		try {
			upRResult = session.update("shUpdateReply", reply);
		} catch (Exception e) {
			System.out.println("ArticleDaoImpl customerUpdateReply Exception->"+e.getMessage());
		}
		return upRResult;
	}	
	
	
	
	
	// 유현규
	@Override
	public List<ReplyMember> getReplyByArticle(Article article) {
		return session.selectList("hgGetReplyByArticle", article);
	}
	
	@Override
	public int hgInsertReply(Reply reply) {
		return session.insert("hgInsertReply", reply);
	}
	@Override
	public List<ReplyMember> hgGetRepliesOfMember(int mem_id) {
		return session.selectList("hgGetRepliesOfMember", mem_id);
	}
	
	@Override
	public List<Reply> hgGetRepliesOfArticle(Article searcher) {
		return session.selectList("hgGetRepliesOfArticle", searcher);
	}
	
	@Override
	public int hgDeleteReply(Reply reply) {
		return session.update("hgDeleteReply", reply);
	}
	
	@Override
	public Reply hgGetReplyById(Reply reply) {
		return session.selectOne("hgGetReplyById", reply);
	}
	
	@Override
	public int hgRealDeleteReply(Reply reply) {
		return session.delete("hgRealDeleteReply", reply);
	}
	
	
	// 임동빈
	@Override
	public int dbInsertReply(Reply reply) {
		
		int dbInsertReply = 0;
		try {
			dbInsertReply = session.insert("dbInsertReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dbInsertReply;
	}
	@Override
	public int dbDeleteReply(Reply reply) {
		int dbDeleteReply = 0;
		try {
			dbDeleteReply = session.update("dbDeleteReply", reply);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return dbDeleteReply;
	}
	@Override
	public int dbUpdateReply(Reply reply) {
		int dbUpdateReply = 0; 
		try {
			dbUpdateReply = session.update("dbUpdateReply", reply);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return dbUpdateReply;
	}
	
	// 김찬영
	//댓글 조회
	@Override
	public List<Reply> replyAll(Reply reply) {
		List<Reply> replyAll = null;
		System.out.println("ArticleDaoImpl replyAll Start..");
		try {
			replyAll = session.selectList("cyReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return replyAll;
	}
	//댓글 작성
	@Override
	public int cywriteReply(Reply reply) {
		int reulst = 0;
		try {
			reulst = session.insert("cywriteReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reulst;
	}
	//댓글 삭제
	@Override
	public int cydeleteReply(Reply reply) {
		int reulst = 0;
		try {
			reulst = session.delete("cydeleteReply", reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reulst;
	}
	// 댓글 수정
	@Override
	public int updateReply(Reply reply) {
		System.out.println(reply);
		System.out.println("Reply 댓글 수정");
		int result = 0;
		try {
			result = session.update("cyupdateReply", reply);
		} catch (Exception e) {
			System.out.println("updateReplyDaoImpl reply e.getMessage()->"+e.getMessage());
		}
		return result;
	}
	// 댓글 좋아요
	@Override
	public int replyupdategood(Reply reply) {
		System.out.println(reply);
		System.out.println("ReplyDaoImpl 댓글 좋아요");
		int result = 0;
		try {
			result = session.update("cyUpdateGoodReply", reply);
		} catch (Exception e) {
			System.out.println("updateReplyDaoImpl reply e.getMessage()->"+e.getMessage());
		}
		return result;
	}
	// 댓글 싫어요
	@Override
	public int replyupdatebad(Reply reply) {
		System.out.println(reply);
		System.out.println("ReplyDaoImpl 댓글 싫어요");
		int result = 0;
		try {
			result = session.update("cyUpdateBadReply", reply);
		} catch (Exception e) {
			System.out.println("updateReplyDaoImpl reply e.getMessage()->"+e.getMessage());
		}
		return result;
	}
	
	// 김진현
	@Override
	public int JHreplyInsert2(Article article) {
		return session.insert("JHReplyInsert", article);
	}
	@Override
	public int JHreplyDelete2(Article article) {
		return session.update("JHReplyDelete", article);		
	}
	@Override
	public void JHreplyUpdate2(Article article) {
		session.update("JHReplyUpdate",article);
	}	
}
