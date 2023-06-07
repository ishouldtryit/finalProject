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
public class EmployeeDto {
    private String empNo;
    private String empName;
    private String empPassword;
    private String empEmail;
    private String empPhone;
    private String empAddress;
    private String empDetailAddress;
    private String empPostcode;
    private Date empHireDate;
    private String isLeave;
    private int cpNumber;
    private int jobNo;
    private int deptNo;
    private String empAdmin;
    private Integer attachmentNo;

}

