package com.java501.S20230401.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.java501.S20230401.model.Message;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MessageDaoImpl implements MessageDao {
	private final SqlSession session;

	// 양동균
	// 받은 쪽지
	@Override
	public List<Message> dgMessageListRec(Integer mem_id) {
		List<Message> messageList = null;
		try {
			messageList = session.selectList("dgMessageListRec", mem_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return messageList;
	}
	// 보낸 쪽지
	@Override
	public List<Message> dgMessageListSen(Integer mem_id) {
		List<Message> messageList = null;
		try {
			messageList = session.selectList("dgMessageListSen", mem_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return messageList;
	}
	// 쪽지 작성
	@Override
	public void dgMessageWrite(Message message) {
		try {
			session.insert("dgMessageWrite", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 쪽지 보관, 휴지통
	@Override
	public boolean dgMessageAction(Message message) {
		boolean result = false;
		try {
			Integer updateResult = session.update("dgMessageAction", message);
			result = updateResult > 0? true : false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 쪽지 삭제
	@Override
	public boolean dgMessageDelete(Message message) {
		boolean result = false;
		try {
			Integer updateResult = session.update("dgMessageDelete", message);
			result = updateResult > 0? true : false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 쪽지 읽음 처리
	@Override
	public boolean dgMessageRead(Message message) {
		boolean result = false;
		try {
			Integer updateResult = session.update("dgMessageRead", message);
			result = updateResult > 0? true : false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
