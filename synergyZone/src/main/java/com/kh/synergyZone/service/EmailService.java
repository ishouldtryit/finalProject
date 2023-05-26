package com.kh.synergyZone.service;

import javax.mail.MessagingException;

public interface EmailService {
	void sendTemporaryPw(String empNo, String empEmail) throws MessagingException;
}
