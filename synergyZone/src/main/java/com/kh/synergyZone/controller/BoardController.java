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
import com.kh.synergyZone.dto.EmployeeProfileDto;
import com.kh.synergyZone.repo.BoardRepo;
import com.kh.synergyZone.repo.EmployeeProfileRepo;
import com.kh.synergyZone.service.BoardService;
import com.kh.synergyZone.vo.BoardVO;
import com.kh.synergyZone.vo.PaginationVO;

@Controller
@RequestMapping("/board")
public class BoardController {

   @Autowired
   private BoardRepo boardRepo;
    
   @Autowired
   private BoardService boardService;
   
   @Autowired
   private EmployeeProfileRepo employeeProfileRepo;

   
   @GetMapping("/list")
   public String list(
           @RequestParam(required = false, defaultValue = "") String empNo,
         @ModelAttribute("vo") PaginationVO vo,  HttpSession session,
         Model model) {
      //vo에 딱 한 가지 없는 데이터가 게시글 개수(목록/검색이 다름)
      int totalCount = boardRepo.selectCount(vo);
      vo.setCount(totalCount);
      
      //게시글
      List<BoardVO> list = boardRepo.selectList(vo);
      model.addAttribute("posts", list);
      // 프로필 사진 조회
      EmployeeProfileDto profile = employeeProfileRepo.find(empNo); // 프로필 정보 조회
      if (profile != null && profile.getAttachmentNo() > 0) {
          model.addAttribute("employeeDto", profile);
      }

      return "board/list";
   }
   
//   조회수 중복 방지 시나리오
//   1. 작성자 본인은 조회수 증가를 하지 않는다
//   2. 한 번 이상 본 글은 조회수 증가를 하지 않는다
//      (1) 세션에 현재 사용자가 읽은 글 번호를 저장해야 한다
//      (2) 새로운 글을 읽으려 할 때 현재 읽는 글 번호가 읽은 이력이 있는지 조회
//      (3) 읽은 적이 있으면 조회수 증가를 하지 않고 없으면 추가 후 조회수 증가
   
   @GetMapping("/detail")
   public String detail(@RequestParam int boardNo, 
                  Model model, HttpSession session) {
      //사용자가 작성자인지 판정 후 JSP로 전달
      BoardVO boardVO = boardRepo.selectOne(boardNo);
      String empNo = (String) session.getAttribute("empNo");
      
      boolean owner = boardVO.getBoardWriter() != null 
            && boardVO.getBoardWriter().equals(empNo);
      model.addAttribute("owner", owner);
      
      // 사용자가 관리자인지 판정 후 JSP로 전달
      Integer jobNo = (Integer) session.getAttribute("jobNo");
      boolean admin = jobNo != null && jobNo.equals(80);
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
            boardVO.setBoardRead(boardVO.getBoardRead()+1);//DTO 조회수 1증가
            memory.add(boardNo);//저장소에 추가(기억에 추가)
         }
         //System.out.println("memory = " + memory);
         session.setAttribute("memory", memory);//저장소 갱신
         
      }
     
      model.addAttribute("boardDto", boardVO);
      return "board/detail";
   }
   
   //경로 변수 방식의 상세조회
   //- 매핑 주소에 중괄호를 적고 변수명을 작성하면 스프링에서 수신해준다
   //- 매개변수에 @PathVariable 형태로 주소에 작성한 변수명을 선언한다
   //장점
   //- 주소의 가독성 증가
   //- 전송방식과 무관하게 사용이 가능
   //- 정규표현식 검사가 가능
   //단점
   //- 엔드포인트(endpoint)가 달라져서 상대경로를 쓰기 불편함
   //- 보내는 데이터 양이 많아질 수록 가독성이 오히려 안좋아진다
   //- 경로 변수 방식을 지원하지 않는 라이브러리들이 있음(수작업)
   @GetMapping("/detail/{boardNo}")
   public String detail2(@PathVariable int boardNo, Model model) {
      model.addAttribute("boardDto", boardRepo.selectOne(boardNo));
      return "board/detail";
   }
   
   @GetMapping("/write")
   public String write(
         @RequestParam(required = false) Integer boardParent,
         Model model) {
      model.addAttribute("boardParent", boardParent);
      return "board/write";
   }
   
//   @PostMapping("/write")
//   public String write(
//         @ModelAttribute BoardDto boardDto,//3개(말머리,제목,내용)
//         HttpSession session, RedirectAttributes attr
//         ) {
//      //번호와 회원아이디를 추출
//      int boardNo = boardRepo.sequence();
//      String empNo = (String)session.getAttribute("empNo");
//      
//      //작성한 게시글 정보에 첨부
//      boardDto.setBoardNo(boardNo);
//      boardDto.setBoardWriter(empNo);
//      
//      //게시글을 등록
//      boardRepo.insert(boardDto);
//      
//      //상세 페이지로 이동
//      attr.addAttribute("boardNo", boardNo);
//      return "redirect:detail";
//   }
   
   @PostMapping("/write")
   public String write(@ModelAttribute BoardVO boardVO,
         @RequestParam(required=false) List<Integer> attachmentNo,
         HttpSession session, RedirectAttributes attr) {
      //컨트롤러에서만 가능한 작업은 컨트롤러에서 처리
      //- 사용자의 요청을 처리하는 것
      //- 세션 사용
      //- 리다이렉트 관련 처리
      //- 그 외 사용자 요청 처리 관련 도구 사용
      String empNo = (String)session.getAttribute("empNo");
      boardVO.setBoardWriter(empNo);
      
      //나머지 일반 프로그래밍 코드는 서비스를 호출하여 처리
      int boardNo = boardService.write(boardVO, attachmentNo);
      
      //상세 페이지로 redirect
      attr.addAttribute("boardNo", boardNo);
      return "redirect:detail";
   }
   
   @GetMapping("/delete")
   public String delete(@RequestParam int boardNo) {
      boardRepo.delete(boardNo);
//      return "redirect:list";//상대경로
      return "redirect:/board/list";//절대경로
   }
   
   @GetMapping("/delete/{boardNo}")
   public String delete2(@PathVariable int boardNo) {
      boardRepo.delete(boardNo);
//      return "redirect:../list";//상대경로
      return "redirect:/board/list";//절대경로
   }
   
//   할일 : 
//   - 준비 : 글번호
//   - 처리 : 글정보 조회
//   - 결과 : 화면에 조회한 데이터 전달
   @GetMapping("/edit")
   public String edit(@RequestParam int boardNo, Model model) {
      model.addAttribute("boardDto", boardRepo.selectOne(boardNo));
      return "board/edit";
   }
   
   @PostMapping("/edit")
   public String edit(@ModelAttribute BoardVO boardVO, 
                                 RedirectAttributes attr) {
      boardRepo.update(boardVO);
      attr.addAttribute("boardNo", boardVO.getBoardNo());
      return "redirect:detail";
   }
   
   //관리자를 위한 전체 삭제 기능
   // - boardNo=1&boardNo=2&boardNo=3 형태로 전송됨
   // - List<Integer> 형태로 수신하거나 int[] 형태로 수신해야함
   // - @RequestParam에 value를 적으면 수신이름을 별도로 지정할 수 있음
   @PostMapping("/deleteAll")
   public String deleteAll(
         @RequestParam(value="boardNo") List<Integer> list) {
      for(int boardNo : list) {
         boardRepo.delete(boardNo);
      }
      return "redirect:list";
   }
   
}