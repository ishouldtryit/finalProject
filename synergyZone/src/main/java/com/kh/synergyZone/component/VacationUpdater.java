package com.kh.synergyZone.component;

import java.time.LocalDate;
import java.time.Period;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.dto.VacationInfoDto;
import com.kh.synergyZone.repo.VacationInfoRepoImpl;


@Service
public class VacationUpdater {
//    private Map<String, Integer> empVacationMap; // 각 사원의 연차 정보를 저장하는 맵
//
//    @Autowired
//    private VacationInfoRepoImpl infoRepo; 
//    
//    List<VacationInfoDto> list= infoRepo.list();
//    
//    @Scheduled(cron = "0 0 0 1 1 *") // 매년 1월 1일 자정에 실행
//    public void resetVacation() {
//
//    	for(VacationInfoDto dto:list) {
//    		String empNo=dto.getEmpNo();
//    		int total=dto.getTotal();
//    		empVacationMap.put(empNo, total);
//    	}
//    }
//
//    public void calculateVacation(String employeeId, LocalDate hireDate) {
//        LocalDate currentDate = LocalDate.now();
//        Period period = Period.between(hireDate, currentDate);
//        int yearsOfService = period.getYears();
//
//        int vacationDays = 0;
//        // 근속년수에 따른 연차 부여
//        if (yearsOfService >= 1 && yearsOfService < 5) {
//            vacationDays = 10;
//        } else if (yearsOfService >= 5 && yearsOfService < 10) {
//            vacationDays = 15;
//        } else if (yearsOfService >= 10) {
//            vacationDays = 20;
//        }
//
//        // 연차 정보 맵에 저장
// 
//    }

 
}