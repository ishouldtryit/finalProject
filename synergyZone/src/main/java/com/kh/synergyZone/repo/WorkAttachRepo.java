package com.kh.synergyZone.repo;

import com.kh.synergyZone.vo.WorkAttachVO;

public interface WorkAttachRepo {
	void insert(WorkAttachVO workAttachVO);
	WorkAttachVO selectOne(int workNo);
	void delete(String uuid);
}
