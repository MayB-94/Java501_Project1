package com.java501.S20230401.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Join;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JoinDaoImpl implements JoinDao {
	private final SqlSession session;
	
	// 양동균
	@Override
	public int shareJoinAdd(Article article) {
		int result = 0;
		try {
			result = session.insert("dgShareJoinAdd",article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int shareJoinDel(Article article) {
		int result = 0;
		try {
			result = session.delete("dgShareJoinDel",article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public List<Join> shareJoinList(Integer trd_id) {
		List<Join> joinList = null;
		try {
			joinList = session.selectList("dgShareJoinList",trd_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return joinList;
	}
	@Override
	public int shareUserJoin(Article shareUser) {
		int result = 0;
		try {
			result = session.selectOne("dgShareUserJoin",shareUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 김진현
	@Override
	public int JHJoinListYN(Article article) {
		return session.selectOne("JHJoinListYN", article);
	}

}
