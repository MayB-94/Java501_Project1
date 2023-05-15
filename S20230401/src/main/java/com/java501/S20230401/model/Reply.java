package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Reply {
	private Integer art_id; // PK
	private Integer brd_id; // PK
	private Integer rep_id; // PK
	private Integer mem_id; // FK
	private String 	rep_content;
	private Date 	rep_regdate;
	private Integer rep_good;
	private Integer rep_bad;
	private Integer rep_parent;
	private Integer rep_step;
	private Integer isdelete;
	private Integer report_id;

	// 양동균
	private Member 	member;
	private Board 	board;
	
	// 백준
	private Integer	rep_cnt;
	private String	mem_nickname;
	private String	mem_username;
	private String	mem_image;
	
}
