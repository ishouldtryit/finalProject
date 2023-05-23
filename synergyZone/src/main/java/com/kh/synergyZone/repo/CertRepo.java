package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.CertDto;

public interface CertRepo {
	void insert(CertDto certDto);
	boolean exist(CertDto certDto);
	void delete(CertDto certDto);
	void clean();
}
