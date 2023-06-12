package com.kh.synergyZone.service;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.BookmarkDto;
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

	@Autowired
	private JavaMailSender sender;

	private File dir;

	@PostConstruct
	public void init() {
		dir = new File(customFileUploadProperties.getPath());
		dir.mkdirs();
	}

	private SqlSession sqlSession;

	// 회원가입
	@Override
	public void join(EmployeeDto employeeDto, MultipartFile attach)
			throws IllegalStateException, IOException, MessagingException {
		employeeRepo.insert(employeeDto);

		if (!attach.isEmpty()) {
			int attachmentNo = attachmentRepo.sequence();

			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);

			attachmentRepo.insert(
					AttachmentDto.builder().attachmentNo(attachmentNo).attachmentName(attach.getOriginalFilename())
							.attachmentType(attach.getContentType()).attachmentSize(attach.getSize()).build());

			employeeProfileRepo.insert(
					EmployeeProfileDto.builder().empNo(employeeDto.getEmpNo()).attachmentNo(attachmentNo).build());
		}

		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, StandardCharsets.UTF_8.name());

		String empNo = employeeDto.getEmpNo();

		helper.setTo(employeeDto.getEmpEmail());
		helper.setSubject("사원번호 및 비밀번호 안내");
		helper.setText("사원번호는 " + empNo + "이며 비밀번호는 synergyZone12345 입니다. 로그인 후 비밀번호를 반드시 변경해주시길 바랍니다.");
		sender.send(message);

	}

	// 로그인
	@Override
	public EmployeeDto login(EmployeeDto employeeDto) {
		String empNo = employeeDto.getEmpNo();
		EmployeeDto findDto = employeeRepo.selectOne(empNo);

		if (findDto == null)
			return null;
		String test1 = employeeDto.getEmpPassword();
		String test2 = findDto.getEmpPassword();

		if (encoder.matches(employeeDto.getEmpPassword(), findDto.getEmpPassword())) {
			return findDto;
		}
		return null;
	}

	@Override
	public boolean encoder(EmployeeDto employeeDto) {
		EmployeeDto findDto = employeeRepo.selectOne(employeeDto.getEmpNo());
		if (encoder.matches(employeeDto.getEmpPassword(), findDto.getEmpPassword())) {
			return true;
		}
		return false;
	}

	// 사원 이미지

	// 사원 이미지 수정
	@Override
	public void updateProfile(String empNo, MultipartFile attach) throws IllegalStateException, IOException {
		deleteProfile(empNo);

		if (!attach.isEmpty()) {
			int attachmentNo = attachmentRepo.sequence();

			File target = new File(dir, String.valueOf(attachmentNo));
			attach.transferTo(target);

			attachmentRepo.insert(
					AttachmentDto.builder().attachmentNo(attachmentNo).attachmentName(attach.getOriginalFilename())
							.attachmentType(attach.getContentType()).attachmentSize(attach.getSize()).build());

			employeeProfileRepo.insert(EmployeeProfileDto.builder().empNo(empNo).attachmentNo(attachmentNo).build());
		}
	}

	// 사원 이미지 삭제
	@Override
	public void deleteProfile(String empNo) {
		EmployeeProfileDto profile = (EmployeeProfileDto) employeeProfileRepo.find(empNo);
		if (profile != null) {
			int attachmentNo = profile.getAttachmentNo();
			File target = new File(dir, String.valueOf(attachmentNo));
			if (target.exists()) {
				target.delete();
			}
			attachmentRepo.delete(attachmentNo);
			employeeProfileRepo.delete(empNo);
		}

	}

	// 사원번호 생성
	@Override
	public String generateEmpNo(Date empHireDate) {
		LocalDate hireDate = empHireDate.toLocalDate();
		int year = hireDate.getYear();
		String lastEmpNoOfYear = employeeRepo.lastEmpNoOfYear(String.valueOf(year));
		int number = 1;

		if (lastEmpNoOfYear != null) {
			String lastNumber = lastEmpNoOfYear.substring(4);
			number = Integer.parseInt(lastNumber) + 1;
		}

		return year + String.format("%03d", number);
	}

	// 사원 검색기능
	@Override
	public List<EmployeeInfoDto> searchEmployees(String column, String keyword) {
		return employeeRepo.searchEmployees(column, keyword);
	}
	
	//IP
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
	
	
	//브라우저
	@Override
	public String getBrowser(HttpServletRequest request) {
		String agent = request.getHeader("User-Agent");
		String browser = null;
		if (agent.contains("MSIE")) {
			browser = "MSIE";
		} else if (agent.contains("Trident")) {
			browser = "MSIE11";
		} else if (agent.contains("Edg")) {
			browser = "Edge";
		} else if (agent.contains("Firefox")) {
			browser = "Firefox";
		} else if (agent.contains("Chrome")) {
			browser = "Chrome";
		} else if (agent.contains("Safari")) {
			browser = "Safari";
		}

		return browser;
	}

	@Override
	public List<BookmarkDto> searchEmployeesInMyList(String ownerNo, String column, String keyword) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("ownerNo", ownerNo);
		paramMap.put("column", column);
		paramMap.put("keyword", keyword);
		return sqlSession.selectList("bookmark.searchEmployeesInMyList", paramMap);
	}

}