package com.kh.synergyZone.rest;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.CertDto;
import com.kh.synergyZone.dto.EmployeeDto;
import com.kh.synergyZone.repo.CertRepo;
import com.kh.synergyZone.repo.EmployeeRepo;
import com.kh.synergyZone.service.EmailService;

@CrossOrigin
@RestController
@RequestMapping("/cert")
public class EmailRestController {
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private CertRepo certRepo;
	
	
	@PostMapping("/")
	public void send(@RequestBody CertDto certDto) 
					throws FileNotFoundException, MessagingException, IOException {
		emailService.sendCert(certDto.getEmail());
	}
	
	@PostMapping("/check")
	public String check(@RequestBody CertDto certDto) {
		if(certRepo.exist(certDto)) {//올바른 인증번호라면
			//인증번호 삭제
			certRepo.delete(certDto);
			return "Y";
		}
		else {
			return "N";
		}
	}
	
}