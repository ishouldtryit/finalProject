package com.kh.synergyZone.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dto.EmployeeInfoDto;
import com.kh.synergyZone.dto.SearchInfoDto;
import com.kh.synergyZone.repo.EmployeeInfoRepo;

@RestController
@RequestMapping("/rest/employeeInfo")
public class EmployeeInfoRestController {
	@Autowired
    private  EmployeeInfoRepo employeeInfoRepo;


    @GetMapping("/all")
    public SearchInfoDto getAllEmployeeInfo(HttpSession session) {
    	String empNo = (String)session.getAttribute("empNo");
        return employeeInfoRepo.findAll(empNo);
    }

    @GetMapping("/{empNo}")
    public EmployeeInfoDto getEmployeeInfoByEmpNo(@PathVariable String empNo) {
        return employeeInfoRepo.findByEmpNo(empNo);
    }

    @PostMapping("/save")
    public void saveEmployeeInfo(@RequestBody EmployeeInfoDto employeeInfoDto) {
        employeeInfoRepo.save(employeeInfoDto);
    }

    @PutMapping("/update")
    public void updateEmployeeInfo(@RequestBody EmployeeInfoDto employeeInfoDto) {
        employeeInfoRepo.update(employeeInfoDto);
    }

    @DeleteMapping("/{empNo}")
    public void deleteEmployeeInfoByEmpNo(@PathVariable String empNo) {
        employeeInfoRepo.deleteByEmpNo(empNo);
    }
}
