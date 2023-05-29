package com.kh.synergyZone.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.WorkFileDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.WorkBoardRepo;
import com.kh.synergyZone.repo.WorkFileRepo;
import com.kh.synergyZone.service.WorkBoardService;

@CrossOrigin
@RestController
@RequestMapping("/rest/attachment")
public class AttachmentRestController {
	
	//준비물
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private WorkFileRepo workFileRepo;
	
	@Autowired
	private WorkBoardRepo workBoardRepo;
	
	@Autowired
	private WorkBoardService workBoardService;
	
	@Autowired
	private CustomFileUploadProperties fileUploadProperties;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	@PostMapping("/upload")
	public List<AttachmentDto> upload(@RequestParam List<MultipartFile> attachments) throws IllegalStateException, IOException {

	    List<AttachmentDto> uploadedAttachments = new ArrayList<>();

	    for (MultipartFile attach : attachments) {
	        if (!attach.isEmpty()) {
	            // Generate attachment number
	            int attachmentNo = attachmentRepo.sequence();

	            // Save file
	            File target = new File(dir, String.valueOf(attachmentNo));
	            attach.transferTo(target);

	            // Store in the database
	            attachmentRepo.insert(AttachmentDto.builder()
	                    .attachmentNo(attachmentNo)
	                    .attachmentName(attach.getOriginalFilename())
	                    .attachmentType(attach.getContentType())
	                    .attachmentSize(attach.getSize())
	                    .build());
	            // Add uploaded attachment to the list
	            uploadedAttachments.add(AttachmentDto.builder()
	                    .attachmentNo(attachmentNo)
	                    .attachmentName(attach.getOriginalFilename())
	                    .build());
	        }
	    }

	    return uploadedAttachments;
	}

	
	//다운로드
	@GetMapping("/download/{attachmentNo}")
	public ResponseEntity<ByteArrayResource> download(
			@PathVariable int attachmentNo) throws IOException{
		
		//DB조회
		AttachmentDto attachmentDto = attachmentRepo.find(attachmentNo);
		if(attachmentDto == null) {//없으면 404
			return ResponseEntity.notFound().build();
		}
		
		//파일 찾기
		File target = new File(dir, String.valueOf(attachmentNo));
		
		//보낼 데이터 생성
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		//제공되는 모든 상수와 명령을 동원해서 최대한 오류 없이 편하게 작성
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(attachmentDto.getAttachmentSize())
				.header(HttpHeaders.CONTENT_ENCODING,
						StandardCharsets.UTF_8.name())
				.header(HttpHeaders.CONTENT_DISPOSITION,
						ContentDisposition.attachment()
							.filename(attachmentDto.getAttachmentName(),
									StandardCharsets.UTF_8
									).build().toString())
				.body(resource);//다운
	}
	
	//첨부파일 삭제
	@DeleteMapping("/delete/{attachmentNo}")
	public ResponseEntity<String> delete(@PathVariable int attachmentNo){
		AttachmentDto attachmentDto = attachmentRepo.find(attachmentNo);
		if(attachmentDto == null) {
			return ResponseEntity.notFound().build();
		}
		
		File target = new File(dir, String.valueOf(attachmentNo));
		if(target.exists() && target.delete()) {
			attachmentRepo.delete(attachmentNo);
			return ResponseEntity.ok("Attachment deleted successfully.");
		}else {
			return ResponseEntity.internalServerError().body("Failed to delete attachment.");
		}
	}
	
	@GetMapping("/list/{attachmentNo}")
	public List<AttachmentDto> list(@PathVariable int attachmentNo) {
	    // attachmentNo를 이용하여 해당 첨부 파일 목록을 조회하고 반환하는 로직 구현
	    return attachmentRepo.findAll(attachmentNo);
	}


	
	
	
}
