package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.ReplyDto;
import com.kh.synergyZone.repo.BoardRepo;
import com.kh.synergyZone.repo.ReplyRepo;


@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	private ReplyRepo replyRepo;
	
	@Autowired
	private BoardRepo boardRepo;

	@GetMapping("/{replyOrigin}")
	public List<ReplyDto> list(@PathVariable int replyOrigin) {
		return replyRepo.selectList(replyOrigin);
	}
	
	@PostMapping("/")
	public void write(HttpSession session, 
				@ModelAttribute ReplyDto replyDto) {
		//작성자 설정
		String empNo = (String)session.getAttribute("empNo");
		replyDto.setReplyWriter(empNo);
		
		//등록
		replyRepo.insert(replyDto);
		
		boardRepo.updateReplycount(replyDto.getReplyOrigin());
	}
	
	@DeleteMapping("/{replyNo}")
	public void delete(@PathVariable int replyNo) {
		ReplyDto replyDto = replyRepo.selectOne(replyNo);
		//삭제를 조회보다 나중에 해야 정보가 나옴
		replyRepo.delete(replyNo);
		//댓글 삭제 후 개수 갱신
		boardRepo.updateReplycount(replyDto.getReplyOrigin());
	}
	
//	@PutMapping("/")//전체수정
	@PatchMapping("/")//일부수정
	public void edit(@ModelAttribute ReplyDto replyDto) {
		replyRepo.update(replyDto);
	}
	
}











