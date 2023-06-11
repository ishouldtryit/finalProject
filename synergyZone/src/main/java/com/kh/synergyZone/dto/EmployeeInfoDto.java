package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmployeeInfoDto {	//회원 정보 통합 뷰
	private String empName;
    private String empEmail;
    private String empPhone;
    private String empAddress;
    private String empDetailAddress;
    private String empPostcode;
    private Date empHireDate;
    private String isLeave;
    private int cpNumber;
    private int deptNo;
    private Integer attachmentNo;
    private int jobNo;
    private String jobName;
    private String empNo;
    private String deptName;
    private String empAdmin;
}
