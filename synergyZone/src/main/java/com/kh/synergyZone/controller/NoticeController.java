package com.kh.synergyZone.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.synergyZone.dto.NoticeDto;
import com.kh.synergyZone.repo.NoticeRepo;
import com.kh.synergyZone.service.NoticeService;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeRepo noticeRepo;
    
	@Autowired
	private NoticeService noticeService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page,
                       @RequestParam(value = "column", required = false) String column,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       Model model) {
        PaginationVO vo = new PaginationVO();
        List<NoticeDto> posts = null;

        if (column == null || keyword == null) {
            posts = noticeRepo.selectList(vo);
        } else {
            vo.setColumn(column);
            vo.setKeyword(keyword);
            posts = noticeRepo.selectList(vo);
        }
        
        model.addAttribute("posts", posts);
        model.addAttribute("pagination", vo);
        return "notice/list";
    }

    @GetMapping("/write")
    public String write(
			@RequestParam(required = false) Integer noticeParent,
			Model model) {
		model.addAttribute("noticeParent", noticeParent);
        return "notice/write";
    }

    @PostMapping("/write")
    public String write(@ModelAttribute NoticeDto noticeDto,
			@RequestParam(required=false) List<Integer> attachmentNo,
			HttpSession session, RedirectAttributes attr) {
		String empNo = (String)session.getAttribute("empNo");
		noticeDto.setNoticeWriter(empNo);
		System.out.println("writer"+empNo);
		System.out.println("test"+noticeDto);
		//나머지 일반 프로그래밍 코드는 서비스를 호출하여 처리
		int noticeNo = noticeService.write(noticeDto, attachmentNo);
		
		//상세 페이지로 redirect
		attr.addAttribute("noticeNo", noticeNo);
        return "redirect:/notice/list";
    }

    @GetMapping("/read")
    public String read(@PathVariable("noticeNo") int noticeNo, Model model) {
        NoticeDto post = noticeRepo.selectOne(noticeNo);
        noticeRepo.updateNoticeReadcount(noticeNo);
        model.addAttribute("post", post);
        return "notice/read";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("noticeNo") int noticeNo) {
        noticeRepo.delete(noticeNo);
        return "redirect:/notice/list";
    }

    @GetMapping("/edit")
    public String edit(@RequestParam int noticeNo, Model model) {
        NoticeDto post = noticeRepo.selectOne(noticeNo);
        model.addAttribute("post", post);
        return "notice/edit";
    }

    @PostMapping("/edit")
    public String editProcess(@RequestParam("noticeNo") int noticeNo, NoticeDto noticeDto) {
        noticeRepo.update(noticeDto);
        return "redirect:/notice/detail/?noticeNo=" + noticeNo;
    }
    
	@GetMapping("/detail")
	public String detail(@RequestParam int noticeNo, 
						Model model, HttpSession session) {
		
		//사용자가 작성자인지 판정 후 JSP로 전달
		NoticeDto noticeDto = noticeRepo.selectOne(noticeNo);
		String empNo = (String) session.getAttribute("empNo");
		
		boolean owner = noticeDto.getNoticeWriter() != null 
				&& noticeDto.getNoticeWriter().equals(empNo);
		model.addAttribute("owner", owner);
		
		//사용자가 관리자인지 판정 후 JSP로 전달
		String jobName = (String) session.getAttribute("jobName");
		boolean admin = jobName != null && jobName.equals("관리자");
		model.addAttribute("admin", admin);
		
		//조회수 증가
		if(!owner) {//내가 작성한 글이 아니라면(시나리오 1번)
			
			//시나리오 2번 진행
			Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
			if(memory == null) {
				memory = new HashSet<>();
			}
			
			if(!memory.contains(noticeNo)) {//읽은 적이 없는가(기억에 없는가)
				noticeRepo.updateNoticeReadcount(noticeNo);
				noticeDto.setNoticeRead(noticeDto.getNoticeRead()+1);//DTO 조회수 1증가
				memory.add(noticeNo);//저장소에 추가(기억에 추가)
			}
			//System.out.println("memory = " + memory);
			session.setAttribute("memory", memory);//저장소 갱신
			
		}
		model.addAttribute("noticeDto", noticeDto);
		return "notice/detail";
	}
}