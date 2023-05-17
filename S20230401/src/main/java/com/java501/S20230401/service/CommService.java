package com.java501.S20230401.service;

import java.util.List;

import com.java501.S20230401.model.Comm;

public interface CommService {

	// 양동균
	String categoryName(int comm_id); // 현재 카테고리 이름
	List<Comm> commList(int comm_id); // 카테고리 목록 (공통 테이블 대분류 번호 입력)
	
	// 유현규
	public Comm getCommById(int comm_id);
	public Comm getCommByName(String comm_value);
	public String getValueById(int comm_id);
	public List<Comm> getCategoryListBySuper(Integer superId);
	public List<Comm> hgGetCategoryNames();

	// 최승환
//	String shcategoryName(int comm_id);
//	List<Comm> shcommList(int comm_id);
}
