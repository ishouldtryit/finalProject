package com.kh.synergyZone.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.dto.WorkBoardDto;

public interface WorkBoardService {
	void write(WorkBoardDto workBoardDto, List<MultipartFile> attachments) throws IllegalStateException, IOException;
	void deleteFile(int workNo);
	void updateFile(int workNo, List<MultipartFile> attachments) throws IllegalStateException, IOException;
}
