package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.repo.VacationRepoImpl;
import com.kh.synergyZone.vo.VacationVO;

import lombok.extern.slf4j.Slf4j;

@CrossOrigin
@RestController
@RequestMapping("/rest/vacation")
public class VacationRestController {
	@Autowired
	private VacationRepoImpl repo;
	
	//사원 연차기록조회
	@GetMapping("/")
	public List<VacationVO> list(HttpSession session,@RequestParam("selectedValue") String selectedValue) {
		VacationVO vo=new VacationVO();
		String empNo=(String)session.getAttribute("empNo");
		vo.setEmpNo(empNo);
		vo.setSelectedValue(selectedValue);
		return repo.selectList(vo);
		
	}
}
