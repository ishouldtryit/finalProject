package com.kh.synergyZone.service;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.dto.EmployeeInfoDto;
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
	
	@Autowired
	private PasswordEncoder encoder;
	
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
		
		if(encoder.matches(employeeDto.getEmpPassword(), findDto.getEmpPassword())) {
			return findDto;
		}
		return null;
	}
	
	@Override
	public boolean encoder(EmployeeDto employeeDto) {
		EmployeeDto findDto = employeeRepo.selectOne(employeeDto.getEmpNo());
		if(encoder.matches(employeeDto.getEmpPassword(), findDto.getEmpPassword())) {
			return true;
		}
		return false;
	}
	
	
	//사원 이미지
	
	//사원 이미지 수정
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
	
	//사원 이미지 삭제
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
	
	//사원번호 생성
	@Override
	public String generateEmpNo(Date empHireDate) {
		LocalDate hireDate = empHireDate.toLocalDate();
		int year = hireDate.getYear();
		String lastEmpNoOfYear = employeeRepo.lastEmpNoOfYear(String.valueOf(year));
		int number = 1;
		
		if(lastEmpNoOfYear != null) {
			String lastNumber = lastEmpNoOfYear.substring(4);
			number = Integer.parseInt(lastNumber) + 1;
		}
		
		return year + String.format("%03d", number);
	}


	//사원 검색기능
			@Override
			public List<EmployeeInfoDto> searchEmployees(String column, String keyword) {
			    return employeeRepo.searchEmployees(column, keyword);
			}


		@Override
	      public String getLocation(HttpServletRequest request) {
	         String ipAddress = request.getHeader("X-Forwarded-For");
	          
	          if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	              ipAddress = request.getHeader("Proxy-Client-IP");
	          }
	          
	          if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	              ipAddress = request.getHeader("WL-Proxy-Client-IP");
	          }
	          
	          if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	              ipAddress = request.getHeader("HTTP_CLIENT_IP");
	          }
	          
	          if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	              ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
	          }
	          
	          if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
	              ipAddress = request.getRemoteAddr();
	              
	              // Loopback Address 처리
	              if (ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")) {
	                  InetAddress inetAddress = null;
	                  try {
	                      inetAddress = InetAddress.getLocalHost();
	                      ipAddress = inetAddress.getHostAddress();
	                  } catch (UnknownHostException e) {
	                      e.printStackTrace();
	                  }
	              }
	          }

	          return ipAddress;
	      }


		@Override
		public String getBrowser(HttpServletRequest request) {
			// 에이전트
			String agent = request.getHeader("User-Agent");

			String browser = null;
			if (agent.contains("MSIE")) {
				browser = "MSIE";
			} else if (agent.contains("Trident")) {
				browser = "MSIE11";
			} else if (agent.contains("Chrome")) {
				browser = "Chrome";
			} else if (agent.contains("Opera")) {
				browser = "Opera";
			} else if (agent.contains("Firefox")) {
				browser = "Firefox";
			} else if (agent.contains("Safari")) {
				browser = "Safari";
			}

			return browser;
		}

		

}