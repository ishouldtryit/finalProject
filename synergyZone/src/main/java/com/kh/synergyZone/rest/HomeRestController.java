package com.kh.synergyZone.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.dto.MessageDto;
import com.kh.synergyZone.dto.NoticeDto;
import com.kh.synergyZone.repo.MainRepoImpl;

@RestController
@RequestMapping("/rest/home")
public class HomeRestController {
	@Autowired
	private MainRepoImpl mainRepo;
	
	@GetMapping("/msg")
	public List<MessageDto> msg() {
        return mainRepo.msg();
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
