package com.java501.S20230401.service;

import lombok.Data;

@Data
public class Paging {
	private int currentPage = 1;
	private int pageRow = 10;		// 한 페이지의 게시글 수
	private int pageBlock = 10;		// 한번에 보여 줄 페이지
	private int start;
	private int startPage;
	private int end;
	private int endPage;
	private int total;
	private int totalPage;
	
	public Paging(int total, String presentPage) {
		this.total = total;
		if(presentPage != null) this.currentPage = Integer.parseInt(presentPage);
		
		start 		= (currentPage - 1) * pageRow + 1;
		end			= start + pageRow - 1;
		startPage	= currentPage - ((currentPage - 1) % pageBlock);
		endPage		= startPage + pageBlock - 1;
		totalPage 	= (int)Math.ceil((double)total / pageRow);
		endPage		= endPage > totalPage? totalPage : endPage;
		
	}
	public Paging(int total, String presentPage, int pageRow, int pageBlock) {
		this.pageRow = pageRow;
		this.pageBlock = pageBlock;
		this.total = total;
		if(presentPage != null) this.currentPage = Integer.parseInt(presentPage);
		
		start 		= (currentPage - 1) * pageRow + 1;
		end			= start + pageRow - 1;
		startPage	= currentPage - ((currentPage - 1) % pageBlock);
		endPage		= startPage + pageBlock - 1;
		totalPage 	= (int)Math.ceil((double)total / pageRow);
		endPage		= endPage > totalPage? totalPage : endPage;
	}
}
