package com.kh.synergyZone.rest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.BoardLikeDto;
import com.kh.synergyZone.repo.BoardLikeRepo;
import com.kh.synergyZone.repo.BoardRepo;
import com.kh.synergyZone.vo.BoardLikeVO;

@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	@Autowired
	private BoardLikeRepo boardLikeRepo;
	
	@Autowired
	private BoardRepo boardRepo;

	//조회는 GET으로 하는게 맞긴한데...
	//데이터가 많으면 주소 설정이 어렵다
	//----> POST로 처리하면 깔끔
	//@GetMapping("/like/{boardNo}")
	@PostMapping("/like")
	public BoardLikeVO like(HttpSession session, 
			@ModelAttribute BoardLikeDto boardLikeDto) {
		String empNo = (String)session.getAttribute("empNo");
		boardLikeDto.setEmpNo(empNo);
		
		boolean current = boardLikeRepo.check(boardLikeDto);
		if(current) {
			boardLikeRepo.delete(boardLikeDto);
		}
		else {
			boardLikeRepo.insert(boardLikeDto);
		}
		
		//좋아요 개수
		int count = boardLikeRepo.count(boardLikeDto.getBoardNo());
		
		//게시글의 좋아요 개수를 업데이트
		boardRepo.updateLikecount(boardLikeDto.getBoardNo(), count);
		
		return BoardLikeVO.builder()
					.result(!current)
					.count(count)
				.build();
		//return Map.of("result", !current, "count", count);
	}
	
	@PostMapping("/check")
	public boolean check(HttpSession session,
			@ModelAttribute BoardLikeDto boardLikeDto) {
		String empNo = (String)session.getAttribute("empNo");
		boardLikeDto.setEmpNo(empNo);
		
		return boardLikeRepo.check(boardLikeDto);
	}
	
}








