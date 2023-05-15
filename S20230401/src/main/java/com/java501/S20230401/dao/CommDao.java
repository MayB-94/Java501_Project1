package com.java501.S20230401.dao;

import java.util.List;

import com.java501.S20230401.model.Comm;

public interface CommDao {

	// 양동균
	String categoryName(int comm_id);
	List<Comm> commList(int comm_id);

	// 유현규
	public String getValueById(int comm_id);
	public Comm getCommById(int comm_id);
	public Comm getCommByName(String comm_value);
	public List<Comm> getCategoryListBySuper(Integer superId);
	public List<Comm> hgGetCategoryNames();
	
	// 임동빈
	List<Comm> boardName();
	List<Comm> genderName();
	
	// 최승환
//	String shcategoryName(int comm_id);
//	List<Comm> shcommList(int comm_id);
	
	// 김진현
	String      JHboardName2(int comm_id);
	List<Comm>  JHcommList2();
}
