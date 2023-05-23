package com.kh.synergyZone.advice;

public class RequirePermissionException extends RuntimeException {
	
	public RequirePermissionException(String message) {
		super(message);
	}
}
