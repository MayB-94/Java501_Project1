package com.java501.S20230401.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.java501.S20230401.dao.MessageDao;
import com.java501.S20230401.model.Message;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {
	private final MessageDao md;
	
	// 양동균
	@Override
	public List<Message> dgMessageListRec(Integer mem_id) { return md.dgMessageListRec(mem_id); }
	@Override
	public List<Message> dgMessageListSen(Integer mem_id) { return md.dgMessageListSen(mem_id); }
	@Override
	public void dgMessageWrite(Message message) { md.dgMessageWrite(message); }
	@Override
	public boolean dgMessageAction(Message message) { return md.dgMessageAction(message); }
	@Override
	public boolean dgMessageDelete(Message message) { return md.dgMessageDelete(message); }
	@Override
	public boolean dgMessageRead(Message message) { return md.dgMessageRead(message); }

}
