package com.kh.synergyZone.dto;

import java.sql.Date;
import java.util.List;

import com.kh.synergyZone.vo.ApprovalVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class EmployeeDetailsDto {

	private String empName;
	private String empEmail;
	private String empPhone;
	private String empAddress;
	private String empDetailAddress;
	private String empPostcode;
	private Date empHireDate;
	private String isLeave;
	private String empAdmin;
	private int cpNumber;
	private int jobNo;
	private String jobName;
	private int deptNo;
	private String deptName;
	private int attachmentNo;
	private String empNo;
	
}
