package com.kh.synergyZone.service;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;

import javax.servlet.http.HttpServletRequest;

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

	@Override
	public String getLocation(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-Forwarded-For");
         
         if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
             ipAddress = request.getHeader("Proxy-Client-IP");
         }
         
         if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
             ipAddress = request.getHeader("WL-Proxy-Client-IP");
         }
         
         if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
             ipAddress = request.getHeader("HTTP_CLIENT_IP");
         }
         
         if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
             ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
         }
         
         if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
             ipAddress = request.getRemoteAddr();
             
             // Loopback Address 처리
             if (ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")) {
                 InetAddress inetAddress = null;
                 try {
                     inetAddress = InetAddress.getLocalHost();
                     ipAddress = inetAddress.getHostAddress();
                 } catch (UnknownHostException e) {
                     e.printStackTrace();
                 }
             }
         }

         return ipAddress;
     }

    
    
}
