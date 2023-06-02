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

import com.kh.synergyZone.dto.NoticeReplyDto;
import com.kh.synergyZone.repo.NoticeRepo;
import com.kh.synergyZone.repo.NoticeReplyRepo;
import com.kh.synergyZone.vo.NoticeReplyVO;


@RestController
@RequestMapping("/rest/noticeReply")
public class NoticeReplyRestController {
	
	@Autowired
	private NoticeReplyRepo noticeReplyRepo;
	
	@Autowired
	private NoticeRepo noticeRepo;

	@GetMapping("/{noticeReplyOrigin}")
	public List<NoticeReplyVO> list(@PathVariable int noticeReplyOrigin) {
	    return noticeReplyRepo.selectList(noticeReplyOrigin);
	}

	
	@PostMapping("/")
	public void write(HttpSession session, 
				@ModelAttribute NoticeReplyDto noticeReplyDto) {
		//작성자 설정
		String empNo = (String)session.getAttribute("empNo");
		noticeReplyDto.setNoticeReplyWriter(empNo);
		
		//등록
		noticeReplyRepo.insert(noticeReplyDto);
		
		noticeRepo.updateNoticeReadcount(noticeReplyDto.getNoticeReplyOrigin());
	}
	
	@DeleteMapping("/{noticeReplyNo}")
	public void delete(@PathVariable int noticeReplyNo) {
		NoticeReplyVO noticeReplyVO = noticeReplyRepo.selectOne(noticeReplyNo);
		//삭제를 조회보다 나중에 해야 정보가 나옴
		noticeReplyRepo.delete(noticeReplyNo);
		//댓글 삭제 후 개수 갱신
		noticeRepo.updateReplycount(noticeReplyVO.getNoticeReplyOrigin());
	}
	
//	@PutMapping("/")//전체수정
	@PatchMapping("/")//일부수정
	public void edit(@ModelAttribute NoticeReplyDto noticeReplyDto) {
		noticeReplyRepo.update(noticeReplyDto);
	}
	
}









