package com.kh.synergyZone.service;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.mail.MessagingException;

public interface EmailService {
	void sendCert(String email) throws MessagingException, FileNotFoundException, IOException;
}
