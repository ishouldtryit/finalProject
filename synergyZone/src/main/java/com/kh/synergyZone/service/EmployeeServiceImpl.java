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
import com.kh.synergyZone.dto.DepartmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.dto.JobDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.DepartmentRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.repo.JobRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	public EmployeeServiceImpl(EmployeeRepo employeeRepo) {
	        this.employeeRepo = employeeRepo;
	    }
	
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private EmployeeProfileRepo employeeProfileRepo;
	
	@Autowired
	private CustomFileUploadProperties customFileUploadProperties;
	
	@Autowired
	private DepartmentRepo departmentRepo;
	
	@Autowired
	private JobRepo jobRepo;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(customFileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	
	//회원가입
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
	
	//로그인
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
	
	
	//사원 목록
	@Override
	public List<EmployeeDto> getAllEmployees() {
		return employeeRepo.list();
	}
	
	
	//사원 상세
	@Override
	public EmployeeDto detailEmployee(String empNo) {
		return employeeRepo.selectOne(empNo);
	}
	
	//사원 퇴사
	@Override
	public void deleteEmployee(String empNo) {
		employeeRepo.delete(empNo);
	}
	
	
	//사원 이미지
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

	//부서 등록
	@Override
	public void registerDepartment(DepartmentDto departmentDto) {
		departmentRepo.insert(departmentDto);
	}

	//부서 목록
	@Override
	public List<DepartmentDto> getAllDepartments() {
		return departmentRepo.list();
	}

	//부서 삭제
	@Override
	public void deleteDepartment(int deptNo) {
		departmentRepo.delete(deptNo);
	}

	
	//직위 등록
	@Override
	public void registerJob(JobDto jobDto) {
		jobRepo.insert(jobDto);
	}

	//직위 목록
	@Override
	public List<JobDto> getAllJobs() {
		return jobRepo.list();
	}


	@Override
	public void deleteJob(int jobNo) {
		jobRepo.delete(jobNo);
	}

	//사원 검색기능
	@Override
	public List<EmployeeDto> searchEmployees(String column, String keyword) {
	    return employeeRepo.searchEmployees(column, keyword);
	}

}

