package com.kh.synergyZone.repo;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

	@Override
	public AttachmentDto find(int attachmentNo) {
		return sqlSession.selectOne("attach.find", attachmentNo);
	}
	
}
