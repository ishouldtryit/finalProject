package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.ChatUserDto;

@Repository
public class ChatUserRepoImpl implements ChatUserRepo {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void add(ChatUserDto dto) {
		sqlSession.insert("chatUser.add", dto);
	}
	
	@Override
	public List<ChatUserDto> find(String empNo) {
		return sqlSession.selectList("chatUser.find", empNo);
	}
	
	@Override
	public boolean check(ChatUserDto userDto) {
//		return sqlSession.selectOne("chatUser.check", userDto) != null;
		ChatUserDto findDto = sqlSession.selectOne("chatUser.check", userDto);
		if(findDto == null) return false;
		else return true;
	}
	
}






