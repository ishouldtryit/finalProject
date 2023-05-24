package com.kh.synergyZone.service;

import java.nio.charset.StandardCharsets;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.component.RandomComponent;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.EmployeeRepo;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	private RandomComponent randomComponent;
	
	private EmployeeRepo employeeRepo;
	
	@Autowired
	private JavaMailSender sender;

	@Override
	public void sendTemporaryPw(String empNo, String empEmail) throws MessagingException {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false,
									StandardCharsets.UTF_8.name());
		
		EmployeeDto employeeDto = new EmployeeDto();
		
		String temporaryPw = randomComponent.generateString();
		employeeDto.setEmpPassword(temporaryPw);
		
		employeeRepo.changePw(employeeDto);
		
		EmployeeDto dto = employeeRepo.selectOne(empNo);
		helper.setTo(dto.getEmpEmail());
		helper.setSubject("임시 비밀번호 발급");
		helper.setText("발급된 임시 비밀번호는 "+temporaryPw+" 입니다. 로그인 후 비밀번호를 반드시 변경해주시길 바랍니다.");
		sender.send(message);
	}

}

