package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Report {
	private Integer report_id;
	private Integer mem_id;
	private String 	report_content;
	private Date 	report_date;
	private Integer report_status;
	private String 	report_reason;
	
	// 유현규
	private Integer mem_region1;
	private Integer mem_region2;
	private Integer mem_authority;
	private Integer mem_gender;
	private String 	mem_username;
	private String 	mem_nickname;
	private String 	mem_email;
	private String 	mem_tel;
	private Date 	mem_regdate;
	private String 	mem_image;
	private String 	mem_name;
	private Date 	mem_birthday;
	private Date 	mem_latest;
	private Integer isdelete;
	
	// 페이징 용
	private String type;
	// for Paging
	private String 	pageNum;
	private Integer start;
	private Integer end;
}
