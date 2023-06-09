package com.kh.synergyZone.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.WorkBoardDto;
import com.kh.synergyZone.dto.WorkFileDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.WorkAttachRepo;
import com.kh.synergyZone.repo.WorkBoardRepo;
import com.kh.synergyZone.repo.WorkFileRepo;
import com.kh.synergyZone.repo.WorkReportRepo;
import com.kh.synergyZone.vo.WorkBoardVO;

@Service
public class WorkBoardServiceImpl implements WorkBoardService{
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private WorkBoardRepo workBoardRepo;
	
	@Autowired
	private WorkFileRepo workFileRepo;
	
	@Autowired
	private CustomFileUploadProperties customFileUploadProperties;
	
	@Autowired
	private WorkReportRepo workReportRepo;
	
	@Autowired
	private WorkAttachRepo workAttachRepo;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(customFileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	@Override
	public void write(WorkBoardDto workBoardDto, List<MultipartFile> attachments) throws IllegalStateException, IOException {
	    workBoardRepo.insert(workBoardDto);

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
	            
	            workFileRepo.insert(WorkFileDto.builder()
	            		.workNo(workBoardDto.getWorkNo())
	            		.attachmentNo(attachmentNo)
	            		.build());
	        }
	    }
	    
	 }

	@Override
	   public void deleteFile(int attachmentNo,int workNo) {
	      //workNo로 파일이 있는지 확인 그 후 attachmentNo를 제외한 기존코드 동일
	      WorkFileDto file = workFileRepo.selectOne(workNo);
	      if(file != null) {
	         File target = new File(dir, String.valueOf(attachmentNo));
	         if(target.exists()) {
	            target.delete();
	         }
	         attachmentRepo.delete(attachmentNo);
	         workFileRepo.editDelete(attachmentNo);
	      }
	   }
	
	
	@Override
	public void updateFile(int workNo, List<MultipartFile> attachments) throws IllegalStateException, IOException {
		
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
	            
	            workFileRepo.insert(WorkFileDto.builder()
	            		.workNo(workNo)
	            		.attachmentNo(attachmentNo)
	            		.build());
	        }
	    }
	}
	
	//결재 완료 상태 변경
	@Override
	public void updateResult(int workNo) {
		WorkBoardDto workBoardDto = workBoardRepo.selectOnly(workNo);
		
		int statusCode = workBoardDto.getStatusCode();
		int supCount = workBoardRepo.countSupList(workNo);
		
		if(statusCode == supCount) {
			workBoardRepo.signed(workBoardDto);
		}
	}

}