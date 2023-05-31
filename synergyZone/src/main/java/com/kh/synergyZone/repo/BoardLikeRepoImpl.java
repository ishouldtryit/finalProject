package com.kh.synergyZone.repo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.BoardLikeDto;

@Repository
public class BoardLikeRepoImpl implements BoardLikeRepo {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    //좋아요 등록
    @Override
    public void insert(BoardLikeDto boardLikeDto) {
        String sql = "insert into board_like(emp_no, board_no) values(?, ?)";
        Object[] param = {boardLikeDto.getEmpNo(), boardLikeDto.getBoardNo()};
        jdbcTemplate.update(sql, param);
    }

    //좋아요 해제
    @Override
    public void delete(BoardLikeDto boardLikeDto) {
        String sql = "delete from board_like where emp_no = ? and board_no = ?";
        Object[] param = {boardLikeDto.getEmpNo(), boardLikeDto.getBoardNo()};
        jdbcTemplate.update(sql, param);
    }

    //좋아요 여부 확인
    @Override
    public boolean check(BoardLikeDto boardLikeDto) {
        String sql = "select count(*) from board_like where emp_no = ? and board_no = ?";
        Object[] param = {boardLikeDto.getEmpNo(), boardLikeDto.getBoardNo()};
        int count = jdbcTemplate.queryForObject(sql, int.class, param);
        return count == 1;
    }

    //게시글 좋아요 개수
    @Override
    public int count(int boardNo) {
        String sql = "select count(*) from board_like where board_no = ?";
        Object[] param = {boardNo};
        return jdbcTemplate.queryForObject(sql, int.class, param);
    }
}