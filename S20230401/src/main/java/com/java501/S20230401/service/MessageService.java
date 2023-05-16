package com.java501.S20230401.service;

import java.util.List;

import com.java501.S20230401.model.Message;

public interface MessageService {

	// 양동균
	List<Message> dgMessageListRec(Integer mem_id); // 받은 쪽지
	List<Message> dgMessageListSen(Integer mem_id); // 보낸 쪽지
	void dgMessageWrite(Message message); // 쪽지 작성
	boolean dgMessageAction(Message message);
	boolean dgMessageDelete(Message message);
	boolean dgMessageRead(Message message);
}
