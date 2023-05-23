package com.kh.synergyZone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.repo.BoardRepo;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardRepo boardRepo;

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
        return "list";
    }

    @GetMapping("/write")
    public String write() {
        return "write";
    }

    @PostMapping("/write")
    public String writeProcess(BoardDto boardDto) {
        boardRepo.insert(boardDto);
        return "redirect:/board/list";
    }

    @GetMapping("/read/{boardNo}")
    public String read(@PathVariable("boardNo") int boardNo, Model model) {
        BoardDto post = boardRepo.selectOne(boardNo);
        boardRepo.updateReadcount(boardNo);
        model.addAttribute("post", post);
        return "read";
    }

    @GetMapping("/delete/{boardNo}")
    public String delete(@PathVariable("boardNo") int boardNo) {
        boardRepo.delete(boardNo);
        return "redirect:/board/list";
    }

    @GetMapping("/edit/{boardNo}")
    public String edit(@PathVariable("boardNo") int boardNo, Model model) {
        BoardDto post = boardRepo.selectOne(boardNo);
        model.addAttribute("post", post);
        return "edit";
    }

    @PostMapping("/edit/{boardNo}")
    public String editProcess(@PathVariable("boardNo") int boardNo, BoardDto boardDto) {
        boardRepo.update(boardDto);
        return "redirect:/board/read/" + boardNo;
    }
}