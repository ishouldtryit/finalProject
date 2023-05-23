package com.kh.synergyZone.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.component.RandomComponent;
import com.kh.synergyZone.component.RandomGenerator;
import com.kh.synergyZone.dto.CertDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.CertRepo;
import com.kh.synergyZone.repo.EmployeeRepo;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Autowired
	private RandomGenerator randomGenerator;
	
	@Autowired
	private RandomComponent randomComponent;

	@Autowired
	private CertRepo certRepo;
	
	@Autowired
	private EmployeeRepo employeeRepo;
	
	@Autowired
	private JavaMailSender sender;
	

	@Override
	public void sendCert(String email) throws MessagingException, FileNotFoundException, IOException {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false,
								StandardCharsets.UTF_8.name());
		
		String secret = randomGenerator.number(6);
		
		helper.setTo(email);
		helper.setSubject("[SynergyZone] 인증번호 안내");
		String content = this.loadCertTemplate(secret);
		helper.setText(content, true);
		
		sender.send(message);
		
		CertDto certDto = new CertDto();
		certDto.setEmail(email);
		certDto.setSecret(secret);
		certRepo.insert(certDto);
	}
	
	private String loadCertTemplate(String secret) throws FileNotFoundException, IOException {
		ClassPathResource resource = new ClassPathResource("templates/cert.html");
		
		Scanner sc = new Scanner(resource.getFile());
		StringBuffer buffer = new StringBuffer();
		while(sc.hasNextLine()) {
			buffer.append(sc.nextLine());
		}
		sc.close();
		
		Document doc = Jsoup.parse(buffer.toString());
		Element cert = doc.getElementById("custom-email-cert");
		cert.text(secret);
		
		return doc.toString();
	}

	@Override
	public void sendTemporaryPw(String empNo, String empEmail) throws MessagingException {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false,
									StandardCharsets.UTF_8.name());
		
		String temporaryPw = randomComponent.generateString();
		employeeRepo.changePw(empNo, temporaryPw);
		
		EmployeeDto employeeDto = employeeRepo.selectOne(empNo);
		helper.setTo(employeeDto.getEmpEmail());
		helper.setSubject("임시 비밀번호 발급");
		helper.setText("발급된 임시 비밀번호는 "+temporaryPw+" 입니다. 로그인 후 비밀번호를 반드시 변경해주시길 바랍니다.");
		sender.send(message);
	}

}

