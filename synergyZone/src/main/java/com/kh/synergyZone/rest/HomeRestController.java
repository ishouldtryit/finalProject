package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.dto.MessageWithNickDto;
import com.kh.synergyZone.dto.NoticeDto;
import com.kh.synergyZone.repo.MainRepoImpl;

@RestController
@RequestMapping("/rest/home")
public class HomeRestController {
	@Autowired
	private MainRepoImpl mainRepo;
	
	@GetMapping("/msg")
	public List<MessageWithNickDto> msg(HttpSession session) {
		String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
        return mainRepo.msg(empNo);
    }
	
	@GetMapping("/free")
	public List<BoardDto> free() {
        return mainRepo.free();
    }
	
	@GetMapping("/notice")
	public List<NoticeDto> data() {
        return mainRepo.notice();
    }

}
