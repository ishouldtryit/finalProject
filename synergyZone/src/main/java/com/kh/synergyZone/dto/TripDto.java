package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class TripDto {
    private int tripNo;
    private String empNo;
    private String startPlace;
    private String middlePlace;
    private String endPlace;
    private String place;
    private String work;
    private String purpose;
    private String notes;
    private Date startDate;
    private Date endDate;
    private int status;
    private String name;
	private String selectedValue;
	private int period;
	private String empName;
}




