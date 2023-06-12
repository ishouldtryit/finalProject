package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.MessageWithNickDto;
import com.kh.synergyZone.repo.MainRepoImpl;
import com.kh.synergyZone.vo.BoardVO;
import com.kh.synergyZone.vo.NoticeVO;

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
	public List<BoardVO> free() {
        return mainRepo.free();
    }
	
	@GetMapping("/notice")
	public List<NoticeVO> data() {
        return mainRepo.notice();
    }

}
