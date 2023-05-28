package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Article {
//	public String getKeyword() {
//		return keyword;
//	}
//	public void setKeyword(String keyword) {
//		this.keyword = keyword;
//	}
//	
//	
//	public String getKeyWord() {
//		return keyWord;
//	}
//	public void setKeyWord(String keyWord) {
//		this.keyWord = keyWord;
//	}


	private Integer art_id;			// PK
	private Integer brd_id;			// PK
	private Integer mem_id;			// FK
	private Integer trd_id;			// FK
	private String 	art_title;
	private String	art_content;
	private Date 	art_regdate;
	private String 	art_tag1;
	private String 	art_tag2;
	private String 	art_tag3;
	private String 	art_tag4;
	private String 	art_tag5;
	private Integer art_good;
	private Integer art_bad;
	private Integer art_read;
	private Integer art_isnotice;
	private Integer isdelete;
	private Integer report_id;
	
	// 양동균
	// 참조
	private Member 	member;
	private Board 	board;
	private Trade 	trade;
	// comm 테이블 - 식별
	private String 	brd_name; 	// 게시판 이름
	private String	gen_name; 	// 멤버 성별
	private String 	status_name;// 거래 상태
	private Integer rep_cnt;	// 댓글 갯수
	// Search용 필드
	private String 	search;
	private String 	keyWord;
	private String 	pageNum;
	private Integer start;
	private Integer end;

	// 백준
//	private String 		mem_nickname;	
//	private String 		mem_image;
//	
//	private String		bjSearchOption;	
//	private String		bjKeyword;	
//	private Integer		mem_authority;	
//	
////	private String		bjStitle;	
////	private String		bjScontent;	
////	private String		bjStiCon;	
////	private String		bjSnick;	
//	
//	// 임동빈
//	// COMM
//	private Integer 	comm_id;
//	private String 		comm_value;
//	private Integer 	c1_comm_id;
//	private String 		c1_comm_value;
//	private Integer 	c2_comm_id;
//	private String 		c2_comm_value;
//	private Integer     c3_comm_id;
//	private String		c3_comm_value;
//	// TRADE
//	private Integer 	trd_status;
//	private Integer 	trd_max;
//	private Date 		trd_enddate;
//	private Integer 	trd_cost;
//	private Integer 	reg_id;
//	private String 		trd_loc;
//	private Integer 	trd_gender;
//	private Integer 	trd_minage;
//	private Integer 	trd_maxage;
//	// member
//	private String 		mem_username;
//	private String 		mem_password;
//	private String 		mem_email;
//	private String 		mem_tel;
//	private Integer 	mem_region1;
//	private Integer 	mem_region2;
//	private Date 		mem_regdate;
//	private Integer 	mem_gender;
//	private String 		mem_name;
//	private Date 		mem_birthday;
//	private Date 		mem_latest;
//	// reply
//	private Integer 	rep_id;
//	private String 		rep_content;
//	private Date 		rep_regdate;
//	private Integer 	rep_good;
//	private Integer 	rep_bad;
//	private Integer 	rep_parent;
//	private Integer 	rep_step;
//	// Region
//	private String 		reg_name;
//	private Integer 	reg_parent;
//	
//	// Report
//	
//	private String 	report_content;
//	private Date 	report_date;
//	private Integer report_status;
//	private String 	report_reason;
//	
//	// Join
//	private Date	join_date;
//	
//	// Wait
//	private Date    wait_date;
//	
//	
//	// 조회용
//	private Integer 	repCount;
//	private Integer 	artCount;
//	private Integer 	rest_regdate;
//	private Integer 	favoriteCount;
//	private String		trd_finish;
//	private Integer		insert_result;
//	private Integer		reg_id1;
//	private Integer     reg_id2;
//	
//	// 김찬영
//	//조회용(강의내용)
//	private String 		keyword;
//	
//	// 최승환
//	// 조인
//	private Integer		rep_count;
//	private String		search_keyword;
//	
//	//김진현 
//	private Integer		reply_count; // (조회수 오라클 함수)
//	private String 		trd_saveEnddate; // 마감날짜 작업을 위해 string으로 하나 더 만들었습니다.	
//	private int			category;

}
