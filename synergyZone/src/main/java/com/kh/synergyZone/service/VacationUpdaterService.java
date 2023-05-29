package com.kh.synergyZone.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.dto.VacationInfoDto;
import com.kh.synergyZone.repo.VacationInfoRepoImpl;

import lombok.extern.slf4j.Slf4j;


@Service
public class VacationUpdaterService {
	
	
    private Map<String, Integer> empVacationMap; // 각 사원의 연차 정보를 저장하는 맵

    // DB에 접근하기 위해 선언
    private VacationInfoRepoImpl infoRepo;

    // 생성자를 통해 의존성 주입
    public VacationUpdaterService(VacationInfoRepoImpl infoRepo) {
        this.infoRepo = infoRepo;
    }
 
    @Scheduled(cron = "0 0 0 1 1 *") // 매년 1월 1일 자정에 실행
    public void resetVacation() {
        List<VacationInfoDto> list = infoRepo.list();
        empVacationMap = new HashMap<>();

        // 가져온 정보들을 dto 내에 넣음
        for (VacationInfoDto dto : list) {
            // dto에 empNo와 total을 꺼내서 맵에 넣음
            String empNo = dto.getEmpNo();
            int total = dto.getTotal();
            empVacationMap.put(empNo, total);

            // 입사일과 사원번호를 기반으로 연차 계산
            Date empHireDate = dto.getEmpHireDate();
            calculateVacation(empNo, empHireDate);
            infoRepo.scheduling(dto);
        }
    }


    public void calculateVacation(String employeeId, Date empHireDate) {
        LocalDate currentDate = LocalDate.now();
        int yearsOfService = currentDate.getYear() - empHireDate.toLocalDate().getYear();

        if (yearsOfService > 0) {
            int vacationDays = (2 * yearsOfService) - 1;

            // 연차 정보 맵에 저장
            empVacationMap.put(employeeId, vacationDays);
        }
    }




 
}