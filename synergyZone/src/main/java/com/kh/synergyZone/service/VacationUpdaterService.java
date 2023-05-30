package com.kh.synergyZone.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.dto.VacationInfoDto;
import com.kh.synergyZone.repo.VacationInfoRepoImpl;

import lombok.extern.slf4j.Slf4j;
//입사일에따른 연차초기화 스케줄링구현

@Service
public class VacationUpdaterService {

    // DB에 접근하기 위해 선언
	@Autowired
    private VacationInfoRepoImpl infoRepo;

 
	 @Scheduled(cron = "0 0 0 1 1 * ") // 매년 1월 1일 자정에 실행
    public void resetVacation() {
        List<VacationInfoDto> list = infoRepo.list();
        

        // 가져온 정보들을 dto 내에 넣음
        for (VacationInfoDto info : list) {
        	VacationInfoDto dto= new VacationInfoDto();
        	//입사일뽑고 계산돌림
        	String empNo=info.getEmpNo();
        	Date empHireDate = info.getEmpHireDate();
        	int total=calculateVacation(empNo, empHireDate);
        	dto.setTotal(total);
        	dto.setUsed(0);
        	dto.setResidual(0);
        	dto.setEmpNo(empNo);
        	
            
            infoRepo.scheduling(dto);
        }
    }


    public int calculateVacation(String employeeId, Date empHireDate) {
    	//현재년도
        LocalDate currentDate = LocalDate.now();
        //현재년도 - 입사일 차
        int yearsOfService = currentDate.getYear() - empHireDate.toLocalDate().getYear();

        //입사일이 1년차이상이면
        if (yearsOfService > 0) {

        	//입사일 등차수열 계산
        	if (yearsOfService % 2 == 0) {
                return 15 + (yearsOfService / 2);
            } else {
                return 15 + (yearsOfService / 2) + 1;
            }

        	
        }else {
        	//0년차들
        	LocalDate joinDate = empHireDate.toLocalDate();

            // 입사일의 월 구하기
            int joinMonth = joinDate.getMonthValue();

            // 12월에서 입사일의 월 차이 계산
            int monthDifference = 12 - joinMonth;

        	return monthDifference;
        }
    }

}