package com.kh.synergyZone.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.NoticeLikeDto;
import com.kh.synergyZone.repo.NoticeLikeRepo;
import com.kh.synergyZone.repo.NoticeRepo;
import com.kh.synergyZone.vo.NoticeLikeVO;

@RestController
@RequestMapping("/rest/notice")
public class NoticeRestController {
	
	@Autowired
	private NoticeLikeRepo noticeLikeRepo;
	
	@Autowired
	private NoticeRepo noticeRepo;

	//조회는 GET으로 하는게 맞긴한데...
	//데이터가 많으면 주소 설정이 어렵다
	//----> POST로 처리하면 깔끔
	//@GetMapping("/like/{noticeNo}")
	@PostMapping("/like")
	public NoticeLikeVO like(HttpSession session, 
			@ModelAttribute NoticeLikeDto noticeLikeDto) {
		String empNo = (String)session.getAttribute("empNo");
		noticeLikeDto.setEmpNo(empNo);
		
		boolean current = noticeLikeRepo.check(noticeLikeDto);
		if(current) {
			noticeLikeRepo.delete(noticeLikeDto);
		}
		else {
			noticeLikeRepo.insert(noticeLikeDto);
		}
		
		//좋아요 개수
		int count = noticeLikeRepo.count(noticeLikeDto.getNoticeNo());
		
		//게시글의 좋아요 개수를 업데이트
		noticeRepo.updateLikecount(noticeLikeDto.getNoticeNo(), count);
		
		return NoticeLikeVO.builder()
					.result(!current)
					.count(count)
				.build();
		//return Map.of("result", !current, "count", count);
	}
	
	@PostMapping("/check")
	public boolean check(HttpSession session,
			@ModelAttribute NoticeLikeDto noticeLikeDto) {
		String empNo = (String)session.getAttribute("empNo");
		noticeLikeDto.setEmpNo(empNo);
		
		return noticeLikeRepo.check(noticeLikeDto);
	}
	
}








