package com.java501.S20230401.dao;

import java.util.List;

import com.java501.S20230401.model.Message;


public interface MessageDao {

	// 양동균
	List<Message> dgMessageListRec(Integer mem_id); // 받은 쪽지
	List<Message> dgMessageListSen(Integer mem_id); // 보낸 쪽지
	void dgMessageWrite(Message message);			// 쪽지 작성
	boolean dgMessageAction(Message message);		// 쪽지 보관 , 휴지통 이동
	boolean dgMessageDelete(Message message);
	boolean dgMessageRead(Message message);

}
