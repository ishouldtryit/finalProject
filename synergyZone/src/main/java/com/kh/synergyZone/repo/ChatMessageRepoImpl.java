package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.ChatMessageDto;

@Repository
public class ChatMessageRepoImpl implements ChatMessageRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void add(ChatMessageDto dto) {
		sqlSession.insert("chatMessage.add", dto);
	}
	
	@Override
	public List<ChatMessageDto> roomMessageList(String roomName) {
		return sqlSession.selectList("chatMessage.roomMessage", roomName);
	}
	
}


