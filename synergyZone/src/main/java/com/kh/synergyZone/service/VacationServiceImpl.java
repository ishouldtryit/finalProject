package com.kh.synergyZone.service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;


@Service
public class VacationServiceImpl implements VacationService {

    // 최초 회원가입시에만 실행되는 코드
	// 신규입사자의 연차를 구함
	@Override
    public int calculateVacationDays(Date empHireDate) {
        // 입사일을 LocalDate 객체로 변환
        LocalDate joinDate = empHireDate.toLocalDate();

        // 입사일의 월 구하기
        int joinMonth = joinDate.getMonthValue();

        // 12월에서 입사일의 월 차이 계산
        int monthDifference = 12 - joinMonth;

        return monthDifference;
    }

    
    
}
