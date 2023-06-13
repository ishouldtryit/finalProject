package com.kh.synergyZone.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.WorkFileDto;

@Repository
public class WorkFileRepoImpl implements WorkFileRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(WorkFileDto workFileDto) {
		sqlSession.insert("workFile.insertFile", workFileDto);
	}

	@Override
	public WorkFileDto selectOne(int workNo) {
		List<WorkFileDto> files = sqlSession.selectList("workFile.find", workNo);
		if(files != null && !files.isEmpty()) {
			return files.get(0);
		}
		return null;
	}

	@Override
	public List<WorkFileDto> selectAll(int workNo) {
		List<WorkFileDto> files = sqlSession.selectList("workFile.find", workNo);
		if(files != null && !files.isEmpty()) {
			return files;
		}
		return null;
	}

	@Override
	public void delete(int attachmentNo) {
		sqlSession.delete("workFile.deleteALLFile", attachmentNo);
	}

	@Override
	public void update(int workNo) {
		sqlSession.update("workFile.update", workNo);
	}

	@Override
	public void editDelete(int attachmentNo) {
		sqlSession.delete("workFile.deleteSelectFile", attachmentNo);
	}
	
}
