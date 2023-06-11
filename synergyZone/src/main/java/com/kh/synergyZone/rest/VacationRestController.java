package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.TripDto;
import com.kh.synergyZone.repo.TripRepoImpl;
import com.kh.synergyZone.repo.VacationRepoImpl;
import com.kh.synergyZone.vo.VacationVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/vacation")
public class VacationRestController {
	@Autowired
	private VacationRepoImpl repo;
	@Autowired
	private TripRepoImpl tripRepo;
	
	//사원 연차기록조회
	@GetMapping("/")
	public List<VacationVO> list(HttpSession session,@RequestParam("selectedValue") String selectedValue) {
		VacationVO vo=new VacationVO();
		String empNo=(String)session.getAttribute("empNo");
		vo.setEmpNo(empNo);
		vo.setSelectedValue(selectedValue);
		return repo.selectList(vo);
		
	}
	
	@GetMapping("/trip")
	public List<TripDto> list2(HttpSession session,@RequestParam("selectedValue") String selectedValue){
		TripDto dto=new TripDto();
		String empNo=(String)session.getAttribute("empNo");
		dto.setEmpNo(empNo);
		dto.setSelectedValue(selectedValue);
		return tripRepo.list(dto);
	}
}
