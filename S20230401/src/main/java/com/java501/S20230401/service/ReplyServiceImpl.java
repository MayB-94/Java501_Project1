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
	public List<Reply> replyShareList(Article article) {
		return rd.replyShareList(article);
	}
	@Override
	public int writeReply(Reply reply) {
		return rd.writeReply(reply);
	}
	@Override
	public int deleteReply(Reply reply) {
		return rd.deleteReply(reply);
	}
	
	// 백준
	@Override
	public Reply replyCount(Reply reply) {
		return rd.replyCount(reply);
	}
	@Override
	public List<Reply> replyMain(Reply reply) {
		return rd.replyMain(reply);
		
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
	public List<Reply> replyList(Reply reply) {

		List<Reply> listReply = null;
		listReply = rd.replyList(reply);
		System.out.println("댓글 서비스 시작"+ listReply);
		return listReply;
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
	
	//김찬영
	// 댓글 조회
	@Override
	public List<Reply> listReply(Reply reply) {
		List<Reply> listReply = null;
		System.out.println("ArticleServiceImpl listReply Start...");
		listReply = rd.replyList(reply);
		System.out.println("ArticleServiceImpl listReply articleList.size()->" +listReply.size());
		return listReply;
	}
	//댓글 작성
	@Override
	public int cywriteReply(Reply reply) {
		return rd.writeReply(reply);
	}
	
}
