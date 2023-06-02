package com.kh.synergyZone.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.BoardFileDto;

@Repository
public class BoardFileRepoImpl implements BoardFileRepo{
   @Autowired
   private SqlSession sqlSession;

   @Override
   public void insert(BoardFileDto boardFileDto) {
      sqlSession.insert("boardFile.insert", boardFileDto);
   }
   
   
}