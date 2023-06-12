package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.dto.MessageDto;
import com.kh.synergyZone.dto.NoticeDto;

@Repository
public class MainRepoImpl implements MainRepo{
	@Autowired
	private SqlSession session;

	@Override
	public List<MessageDto> msg() {
		return session.selectList("main.msg");
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
