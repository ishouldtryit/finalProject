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
import com.kh.synergyZone.repo.WorkBoardRepo;
import com.kh.synergyZone.repo.WorkFileRepo;

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
	    
	    System.out.println("Selected file count: " + attachments.size());
	 }

	@Override
	public void deleteFile(int workNo) {
		WorkFileDto file = workFileRepo.selectOne(workNo);
		if(file != null) {
			int attachmentNo = file.getAttachmentNo();
			File target = new File(dir, String.valueOf(attachmentNo));
			if(target.exists()) {
				target.delete();
			}
			attachmentRepo.delete(attachmentNo);
			workFileRepo.delete(workNo);
		}
	}

	@Override
	public void updateFile(int workNo, List<MultipartFile> attachments) throws IllegalStateException, IOException {
		deleteFile(workNo);
		
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

	
}