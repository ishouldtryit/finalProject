package com.kh.synergyZone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.dto.BoardDto;
import com.kh.synergyZone.repo.BoardRepo;



//서비스(Service)
//- 컨트롤러에서 처리하기 복잡한 작업들을 단위작업으로 끊어서 수행하는 도구
//- 보통 하나의 기능을 하나의 메소드에 보관
//- 정해진 형태 없이 자유롭게 사용
@Service
public class BoardService {
	
	@Autowired
	private BoardRepo boardRepo;
	
	//게시글 등록 서비스
	//- 컨트롤러에게서 게시글 정보를 받는다
	//- 컨트롤러에게 등록된 게시글 번호를 반환한다
	public int write(BoardDto boardDto, List<Integer> attachmentNo) {
		//boardDto의 정보를 새글과 답글로 구분하여 처리 후 등록
		//- 새글일 경우 boardParent가 null이다.
		//		- 그룹번호(boardGroup)는 글번호와 동일하게 처리
		//		- 대상글번호(boardParent)는 null로 설정
		//		- 차수(boardDepth)는 0으로 설정
		//- 답글일 경우 boardParent가 null이 아니다.
		//		- 대상글의 정보를 조회한 결과를 이용하여 설정한다
		//		- 그룹번호(boardGroup)는 대상글의 그룹번호와 동일하게 처리
		//		- 대상글번호(boardParent)는 전달받은 값을 그대로 사용
		//		- 차수(boardDepth)는 대상글의 차수에 1을 더해서 사용
		
		//글 번호와 회원 아이디 구하기(새글/답글 공통)
		int boardNo = boardRepo.sequence();
		boardDto.setBoardNo(boardNo);
		
		//새글일 경우와 답글일 경우에 따른 추가 계산 작업
		//if(boardDto.getBoardParent() == null) {
		if(boardDto.isNew()) {
			boardDto.setBoardGroup(boardNo);//그룹번호를 글번호로 설정
			//boardDto.setBoardParent(null);//대상글번호를 null로 설정
			//boardDto.setBoardDepth(0);//차수를 0으로 설정
		}
		else {
			//전달받은 대상글번호의 모든 정보 조회
			BoardDto parentDto = boardRepo.selectOne(boardDto.getBoardParent());
			boardDto.setBoardGroup(parentDto.getBoardGroup());//대상글 그룹번호
			boardDto.setBoardDepth(parentDto.getBoardDepth()+1);//대상글 차수+1
		}
		
		//등록
		boardRepo.insert(boardDto);
		
		//글에 사용된 첨부파일번호(attachmentNo)와 글번호(boardNo)를 연결
		if(attachmentNo != null) {
			for(int no : attachmentNo) {
				boardRepo.connect(boardNo, no);
			}
		}
		
		return boardNo;
	}
}




