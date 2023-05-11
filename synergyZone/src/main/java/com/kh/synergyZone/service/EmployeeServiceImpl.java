package com.kh.synergyZone.service;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private EmployeeProfileRepo employeeProfileRepo;
	
	@Autowired
	private CustomFileUploadProperties customFileUploadProperties;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(customFileUploadProperties.getPath());
		dir.mkdirs();
	}
	



	@Override
	public void join(EmployeeDto employeeDto, MultipartFile attach) throws IllegalStateException, IOException {
		employeeRepo.insert(employeeDto);
		
		if(!attach.isEmpty()) {
			int attachmentNo = attachmentRepo.sequence();
			
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);
			
			attachmentRepo.insert(AttachmentDto.builder()
									.attachmentNo(attachmentNo)
									.attachmentName(attach.getOriginalFilename())
									.attachmentType(attach.getContentType())
									.attachmentSize(attach.getSize())
							.build());
			
			employeeProfileRepo.insert(EmployeeProfileDto.builder()
										.empNo(employeeDto.getEmpNo())
										.attachmentNo(attachmentNo)
									.build());
		}
		
	}

	@Override
	public EmployeeDto login(EmployeeDto employeeDto) {
		String empNo = employeeDto.getEmpNo();
		EmployeeDto findDto = employeeRepo.selectOne(empNo);
		
		if(findDto == null) return null;
		
		if(findDto.getEmpPassword().equals(employeeDto.getEmpPassword())) {
			return findDto;
		}
		return null;
	}


	@Override
	public void updateProfile(String empNo, MultipartFile attach) throws IllegalStateException, IOException {
		deleteProfile(empNo);
		
		if(!attach.isEmpty()) {
			int attachmentNo = attachmentRepo.sequence();
			
			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);
			
			attachmentRepo.insert(AttachmentDto.builder()
					.attachmentNo(attachmentNo)
					.attachmentName(attach.getOriginalFilename())
					.attachmentType(attach.getContentType())
					.attachmentSize(attach.getSize())
			.build());

			employeeProfileRepo.insert(EmployeeProfileDto.builder()
						.empNo(empNo)
						.attachmentNo(attachmentNo)
					.build());
		}
	}

	@Override
	public void deleteProfile(String empNo) {
		EmployeeProfileDto profile = (EmployeeProfileDto) employeeProfileRepo.find(empNo);
		if(profile != null) {
			int attachmentNo = profile.getAttachmentNo();
			File target = new File(dir, String.valueOf(attachmentNo));
			if(target.exists()) {
				target.delete();
			}
			attachmentRepo.delete(attachmentNo);
			employeeProfileRepo.delete(empNo);
		}
		
	}






	
}
