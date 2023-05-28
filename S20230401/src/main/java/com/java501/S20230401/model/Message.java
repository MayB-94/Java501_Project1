package com.java501.S20230401.model;

import java.util.Date;

import lombok.Data;

@Data
public class Message {
	private Integer mes_id;			// PK
	private Integer mem_sender_id;	// PK
	private Integer mem_receiver_id;// PK
	private String 	mes_title;
	private String 	mes_content;
	private Date 	mes_regdate;
	private Integer mes_isread;
	private Integer mes_status;
	private Integer isdelete;
	
	// 참조
	private Member member;
}
