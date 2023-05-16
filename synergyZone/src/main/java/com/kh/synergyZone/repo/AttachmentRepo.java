package com.kh.synergyZone.repo;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;

import com.kh.synergyZone.dto.AttachmentDto;

public interface AttachmentRepo {
	int sequence();
	void insert(AttachmentDto attachmentDto);
	void update(int attachmentNo);
	void delete(int attachmentNo);
	AttachmentDto find(int attachmentNo);
}
