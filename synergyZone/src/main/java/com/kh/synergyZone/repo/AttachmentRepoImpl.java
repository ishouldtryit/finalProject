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
	public List<AttachmentDto> find(int attachmentNo) {
		return sqlSession.selectList("attach.find", attachmentNo);
	}

	@Override
	public ResponseEntity<ByteArrayResource> getProfile(int attachmentNo, File dir) throws IOException {
		AttachmentDto attachmentDto = sqlSession.selectOne("attach.find", attachmentNo);
		if(attachmentDto == null) {
			return ResponseEntity.notFound().build();
		}
		
		File target = new File(dir, String.valueOf(attachmentNo));
		 byte[] data = FileUtils.readFileToByteArray(target);
		    ByteArrayResource resource = new ByteArrayResource(data);
		    
		    return ResponseEntity.ok()
		            .contentType(MediaType.APPLICATION_OCTET_STREAM)
		            .contentLength(attachmentDto.getAttachmentSize())
		            .header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
		            .header(HttpHeaders.CONTENT_DISPOSITION,
		                    ContentDisposition.attachment()
		                            .filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8)
		                            .build()
		                            .toString())
		            .body(resource);
	}
	
}
