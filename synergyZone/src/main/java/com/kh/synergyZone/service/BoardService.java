package com.kh.synergyZone.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.dto.AttachmentDto;
import com.kh.synergyZone.dto.BoardFileDto;
import com.kh.synergyZone.repo.AttachmentRepo;
import com.kh.synergyZone.repo.BoardFileRepo;
import com.kh.synergyZone.repo.BoardRepo;
import com.kh.synergyZone.vo.BoardVO;



//서비스(Service)
//- 컨트롤러에서 처리하기 복잡한 작업들을 단위작업으로 끊어서 수행하는 도구
//- 보통 하나의 기능을 하나의 메소드에 보관
//- 정해진 형태 없이 자유롭게 사용
@Service
public class BoardService {
	
	@Autowired
	private BoardRepo boardRepo;
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private BoardFileRepo boardFileRepo;
	
	@Autowired
	private CustomFileUploadProperties customFileUploadProperties;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(customFileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	//게시글 등록 서비스
	//- 컨트롤러에게서 게시글 정보를 받는다
	//- 컨트롤러에게 등록된 게시글 번호를 반환한다
	public int write(BoardVO boardVO, List<MultipartFile> attachments) throws IllegalStateException, IOException {
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
		boardVO.setBoardNo(boardNo);
		
		//새글일 경우와 답글일 경우에 따른 추가 계산 작업
		//if(boardDto.getBoardParent() == null) {
		if(boardVO.isNew()) {
			boardVO.setBoardGroup(boardNo);//그룹번호를 글번호로 설정
			//boardDto.setBoardParent(null);//대상글번호를 null로 설정
			//boardDto.setBoardDepth(0);//차수를 0으로 설정
		}
		else {
			//전달받은 대상글번호의 모든 정보 조회
			BoardVO parentDto = boardRepo.selectOne(boardVO.getBoardParent());
			boardVO.setBoardGroup(parentDto.getBoardGroup());//대상글 그룹번호
			boardVO.setBoardDepth(parentDto.getBoardDepth()+1);//대상글 차수+1
		}
		
		//등록
		boardRepo.insert(boardVO);
		
		for (MultipartFile attach : attachments) {
	        if (!attach.isEmpty()) {
	            // Generate attachment number
	            int attachmentNo = attachmentRepo.sequence();

	            // Save file
	            File target = new File(dir, String.valueOf(attachmentNo));
	            attach.transferTo(target);

	            // Store in the database
	            attachmentRepo.insert(AttachmentDto.builder()
	                    .attachmentNo(attachmentNo)
	                    .attachmentName(attach.getOriginalFilename())
	                    .attachmentType(attach.getContentType())
	                    .attachmentSize(attach.getSize())
	                    .build());
	            
	            boardFileRepo.insert(BoardFileDto.builder()
	            		.boardNo(boardVO.getBoardNo())
	            		.attachmentNo(attachmentNo)
	            		.build());
	        }
	    }
		
		return boardNo;
	}
}




