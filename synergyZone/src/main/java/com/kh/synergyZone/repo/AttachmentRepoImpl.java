package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.WorkFileDto;

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

	@Override
	public AttachmentDto find(int attachmentNo) {
		return sqlSession.selectOne("attach.find", attachmentNo);
	}

	@Override
	public List<AttachmentDto> findAll(int attachmentNo) {
		List<AttachmentDto> attachments = sqlSession.selectList("attach.find", attachmentNo);
		if(attachments != null && !attachments.isEmpty()) {
			return attachments;
		}
		return null;
	}
	
}
