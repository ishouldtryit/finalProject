package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.AttachmentDto;

@Repository
public class AttachmentRepoImpl implements AttachmentRepo{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(AttachmentDto attachmentDto) {
		sqlSession.insert("attach.insertAttach", attachmentDto);
	}

	@Override
	public int sequence() {
		return sqlSession.selectOne("attach.sequence");
	}

	@Override
	public void delete(int attachmentNo) {
		sqlSession.delete("attach.deleteAttach", attachmentNo);
	}

	@Override
	public void update(int attachmentNo) {
		sqlSession.update("attach.updateAttach", attachmentNo);
	}
	
}
