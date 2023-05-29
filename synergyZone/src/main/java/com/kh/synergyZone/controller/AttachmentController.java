package com.kh.synergyZone.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.repo.AttachmentRepo;

@Controller
@RequestMapping("/attachment")
public class AttachmentController {
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private CustomFileUploadProperties customFileUploadProperties;
	
	private File dir;
	

	@PostConstruct
	public void init() {
		dir = new File(customFileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	//업로드
		@PostMapping("/upload")
		public AttachmentDto upload(@RequestParam List<MultipartFile> attachments) throws IllegalStateException, IOException {
			
			for(MultipartFile attach : attachments) {
				if (!attach.isEmpty()) { // 파일이 있을 경우
					// 번호 생성
					int attachmentNo = attachmentRepo.sequence();
					
					// 파일 저장 (저장 위치는 임시로 생성)
					File target = new File(dir, String.valueOf(attachmentNo)); // 파일명 = 시퀀스
					attach.transferTo(target);
					
					// DB 저장
					attachmentRepo.insert(AttachmentDto.builder()
							.attachmentNo(attachmentNo)
							.attachmentName(attach.getOriginalFilename())
							.attachmentType(attach.getContentType())
							.attachmentSize(attach.getSize())
							.build());
					
					return attachmentRepo.find(attachmentNo); // DTO를 반환함
				}
				
			}

		    return null; // 또는 예외처리
		}
	
		@GetMapping("/download")
		public ResponseEntity<ByteArrayResource> download(@RequestParam int attachmentNo) throws IOException {
		    AttachmentDto attachmentDto = attachmentRepo.find(attachmentNo);
		    if (attachmentDto == null) {
		        return ResponseEntity.notFound().build();
		    }

		    File target = new File(dir, String.valueOf(attachmentNo));
		    byte[] data = FileUtils.readFileToByteArray(target);
		    ByteArrayResource resource = new ByteArrayResource(data);

		    String contentType = URLConnection.guessContentTypeFromName(attachmentDto.getAttachmentName());
		    if (contentType == null) {
		        contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
		    }

		    return ResponseEntity.ok()
		            .contentType(MediaType.parseMediaType(contentType))
		            .contentLength(attachmentDto.getAttachmentSize())
		            .header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
		            .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
		                    .filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8).build().toString())
		            .body(resource);
		}

}
