package com.java501.S20230401.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Waiting;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class WaitingDaoImpl implements WaitingDao {
	private final SqlSession session;
	
	// 양동균
	// 대기열 추가
	@Override
	public int shareWaitingAdd(Article article) {
		int result = 0;
		try {
			result = session.insert("dgShareWaitingAdd", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 대기열 조회
	@Override
	public List<Waiting> dgShareWaitingList(Integer trd_id) {
		List<Waiting> waitingList = null;
		try {
			waitingList = session.selectList("dgShareWaitingList", trd_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return waitingList;
	}
	// 대기열 여부
	@Override
	public int dgUserWaiting(Article shareUser) {
		int result = 0;
		try {
			result = session.selectOne("dgUserWaiting",shareUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 대기열 삭제
	@Override
	public int shareWaitingDel(Article article) {
		int result = 0;
		try {
			result = session.delete("dgShareWaitingDel", article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 김진현
	@Override
	public int JHWaitListYN(Article article) {
		return session.selectOne("JHWaitListYN", article);

	}
}
