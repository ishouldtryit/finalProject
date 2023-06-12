package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.dto.MessageWithNickDto;
import com.kh.synergyZone.dto.NoticeDto;

@Repository
public class MainRepoImpl implements MainRepo{
	@Autowired
	private SqlSession session;

	@Override
	public List<MessageWithNickDto> msg(String empNo) {
		return session.selectList("main.msg", empNo);
	}

	@Override
	public List<BoardDto> free() {
		return session.selectList("main.free");
	}

	@Override
	public List<NoticeDto> notice() {
		return session.selectList("main.notices");
	}
	
	
}
