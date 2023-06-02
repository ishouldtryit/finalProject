package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.ChatRoomDto;

@Repository
public class ChatRoomRepoImpl implements ChatRoomRepo {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("chatRoom.sequence");
	}
	
	@Override
	public void create(ChatRoomDto dto) {
		sqlSession.insert("chatRoom.create", dto);
	}
	
	@Override
	public ChatRoomDto find(String roomName) {
		return sqlSession.selectOne("chatRoom.find", roomName);
	}
	
	@Override
	public List<ChatRoomDto> list() {
		return sqlSession.selectList("chatRoom.list");
	}
	
}




