package com.java501.S20230401.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.ReplyDao;
import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Reply;
import com.java501.S20230401.model.ReplyMember;
import kotlin.jvm.internal.SerializedIr;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private final ReplyDao rd;
	
	// 양동균
	@Override
	public List<Reply> replyShareList(Article article) {return rd.replyShareList(article);	}
	@Override
	public int writeReply(Reply reply) {return rd.writeReply(reply);	}
	@Override
	public int deleteReply(Reply reply) {return rd.deleteReply(reply);	}
	@Override
	public int dgUpdateReply(Reply reply) {return rd.dgUpdateReply(reply);	}
	@Override
	public int dgReportReply(Reply reply) {	return rd.dgReportReply(reply); }
	
	
	// 백준
	@Override
	public Reply replyCount(Reply reply) {
		return rd.replyCount(reply);
	}
	@Override
	public List<Reply> replyMain(Reply reply) {
		return rd.replyMain(reply);
		
	}
	
	@Override
	public int bjreReply(Reply reply) {
		return rd.bjreReply(reply);
	}
	
	@Override
	public int bjReGood(Reply reply) {
		return rd.bjReGood(reply);
	}
	@Override
	public int bjReBad(Reply reply) {
		return rd.bjReBad(reply);
	}
	
	
	// 최승환
	@Override
	public int shReplyCount(Reply reply) {
		int countReply = 0;
		countReply = rd.shReplyCount(reply);
		System.out.println("댓글수 서비스 시작"+ countReply);
		return countReply;
	}
	@Override
	public List<Reply> replyList(Article article) {
		return rd.replyList(article);
	}
	@Override
	public int customerWriteReply(Reply reply) {
		int cReplyWrite = 0;
		System.out.println("ArticleServiceImpl customerWriteReply Start");
		cReplyWrite = rd.customerWriteReply(reply);
		return cReplyWrite;
	}
	@Override
	public int customerDeleteReply(Reply reply) {
		int deleteResult = 0;
		System.out.println("ArticleServiceImpl customerWriteReply Start");
		deleteResult = rd.customerDeleteReply(reply);
		return deleteResult;
	}
	@Override
	public int customerUpdateReply(Reply reply) {
		int upRResult = 0;
		System.out.println("ArticleServiceImpl customerUpdateReply Start");
		upRResult = rd.customerUpdateReply(reply);
		return upRResult;
	}
	
	
	// 유현규
	@Override
	public List<ReplyMember> getReplyByArticle(Article article) {
		return rd.getReplyByArticle(article);
	}
	@Override
	public int hgInsertReply(Reply reply) {
		return rd.hgInsertReply(reply);
	}
	@Override
	public List<ReplyMember> hgGetRepliesOfMember(int mem_id) {
		return rd.hgGetRepliesOfMember(mem_id);
	}
	@Override
	public List<Reply> hgGetRepliesOfArticle(Article searcher) {
		return rd.hgGetRepliesOfArticle(searcher);
	}
	@Override
	public int hgDeleteReply(Reply reply) {
		return rd.hgDeleteReply(reply);
	}
	@Override
	public Reply hgGetReplyById(Reply reply) {
		return rd.hgGetReplyById(reply);
	}
	@Override
	public int hgRealDeleteReply(Reply reply) {
		return rd.hgRealDeleteReply(reply);
	}
	
	
	// 임동빈
	@Override
	public int dbInsertReply(Reply reply) {
		return rd.dbInsertReply(reply);
	}
	@Override
	public int dbDeleteReply(Reply reply) {
		return rd.dbDeleteReply(reply);
	}
	@Override
	public int dbUpdateReply(Reply reply) {
		return rd.dbUpdateReply(reply);
	}
	
	//김찬영
	// 댓글 조회
	@Override
	public List<Reply> replyAll(Reply reply) {
		/* List<Reply> replyAll = null; */
		return rd.replyAll(reply);
	}
	//댓글 작성
	@Override
	public int cywriteReply(Reply reply) {
		return rd.writeReply(reply);
	}
	//댓글 삭제
	@Override
	public int cydeleteReply(Reply reply) {
		return rd.deleteReply(reply);
	}
	//댓글 수정
	@Override
	public int cyupdateReply(Reply reply) {
		System.out.println("댓글서비스 임플");
		int result = rd.updateReply(reply);
		return result;
	}
	//댓글 좋아요
	@Override
	public int replyupdategood(Reply reply) {
		System.out.println("ReplyServiceImpl 댓글 좋아요");
		int result = rd.replyupdategood(reply);
		return result;
	}
	//댓글 싫어요
	@Override
	public int replyupdatebad(Reply reply) {
		System.out.println("ReplyServiceImpl 댓글 싫어요");
		int result = rd.replyupdatebad(reply);
		return result;
	}
	
}
