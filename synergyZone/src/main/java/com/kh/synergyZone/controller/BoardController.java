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

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.repo.BoardRepo;
import com.kh.synergyZone.service.BoardService;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardRepo boardRepo;
    
	@Autowired
	private BoardService boardService;

    @GetMapping("/list")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page,
                       @RequestParam(value = "column", required = false) String column,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       Model model) {
        PaginationVO vo = new PaginationVO();
        List<BoardDto> posts = null;

        if (column == null || keyword == null) {
            posts = boardRepo.selectList(vo);
        } else {
            vo.setColumn(column);
            vo.setKeyword(keyword);
            posts = boardRepo.selectList(vo);
        }
        
        model.addAttribute("posts", posts);
        model.addAttribute("pagination", vo);
        return "board/list";
    }

    @GetMapping("/write")
    public String write(
			@RequestParam(required = false) Integer boardParent,
			Model model) {
		model.addAttribute("boardParent", boardParent);
        return "board/write";
    }

    @PostMapping("/write")
    public String write(@ModelAttribute BoardDto boardDto,
			@RequestParam(required=false) List<Integer> attachmentNo,
			HttpSession session, RedirectAttributes attr) {
		String empNo = (String)session.getAttribute("memberId");
		boardDto.setBoardWriter(empNo);
		System.out.println("writer"+empNo);
		System.out.println("test"+boardDto);
		//나머지 일반 프로그래밍 코드는 서비스를 호출하여 처리
		int boardNo = boardService.write(boardDto, attachmentNo);
		
		//상세 페이지로 redirect
		attr.addAttribute("boardNo", boardNo);
        return "redirect:/board/list";
    }

    @GetMapping("/read/{boardNo}")
    public String read(@PathVariable("boardNo") int boardNo, Model model) {
        BoardDto post = boardRepo.selectOne(boardNo);
        boardRepo.updateReadcount(boardNo);
        model.addAttribute("post", post);
        return "/board/read";
    }

    @GetMapping("/delete/{boardNo}")
    public String delete(@PathVariable("boardNo") int boardNo) {
        boardRepo.delete(boardNo);
        return "redirect:/board/list";
    }

    @GetMapping("/edit")
    public String edit(@RequestParam int boardNo, Model model) {
        BoardDto post = boardRepo.selectOne(boardNo);
        model.addAttribute("post", post);
        return "board/edit";
    }

    @PostMapping("/edit")
    public String editProcess(@RequestParam("boardNo") int boardNo, BoardDto boardDto) {
        boardRepo.update(boardDto);
        return "redirect:/board/detail/?boardNo=" + boardNo;
    }
    
	@GetMapping("/detail")
	public String detail(@RequestParam int boardNo, 
						Model model, HttpSession session) {
		
		//사용자가 작성자인지 판정 후 JSP로 전달
		BoardDto boardDto = boardRepo.selectOne(boardNo);
		String memberId = (String) session.getAttribute("memberId");
		
		boolean owner = boardDto.getBoardWriter() != null 
				&& boardDto.getBoardWriter().equals(memberId);
		model.addAttribute("owner", owner);
		
		//사용자가 관리자인지 판정 후 JSP로 전달
		String memberLevel = (String) session.getAttribute("memberLevel");
		boolean admin = memberLevel != null && memberLevel.equals("관리자");
		model.addAttribute("admin", admin);
		
		//조회수 증가
		if(!owner) {//내가 작성한 글이 아니라면(시나리오 1번)
			
			//시나리오 2번 진행
			Set<Integer> memory = (Set<Integer>) session.getAttribute("memory");
			if(memory == null) {
				memory = new HashSet<>();
			}
			
			if(!memory.contains(boardNo)) {//읽은 적이 없는가(기억에 없는가)
				boardRepo.updateReadcount(boardNo);
				boardDto.setBoardRead(boardDto.getBoardRead()+1);//DTO 조회수 1증가
				memory.add(boardNo);//저장소에 추가(기억에 추가)
			}
			//System.out.println("memory = " + memory);
			session.setAttribute("memory", memory);//저장소 갱신
			
		}
		model.addAttribute("boardDto", boardDto);
		return "board/detail";
	}
}