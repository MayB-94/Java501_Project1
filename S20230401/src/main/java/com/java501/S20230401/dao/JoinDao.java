package com.java501.S20230401.dao;

import java.util.List;

import com.java501.S20230401.model.Article;
import com.java501.S20230401.model.Join;

public interface JoinDao {
	// 김진현
	public int JHJoinListYN(Article article);
	

	// 양동균
	int shareJoinAdd(Article article);
	int shareJoinDel(Article article);
	List<Join> shareJoinList(Integer trd_id);
	int shareUserJoin(Article shareUser);

}
