package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.AttachmentDto;

public interface AttachmentRepo {
	int sequence();
	void insert(AttachmentDto attachmentDto);
	void update(int attachmentNo);
	void delete(int attachmentNo);
}
