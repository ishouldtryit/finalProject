package com.kh.synergyZone.repo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.NoticeLikeDto;

@Repository
public class NoticeLikeRepoImpl implements NoticeLikeRepo {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    //좋아요 등록
    @Override
    public void insert(NoticeLikeDto noticeLikeDto) {
        String sql = "insert into notice_like(emp_no, notice_no) values(?, ?)";
        Object[] param = {noticeLikeDto.getEmpNo(), noticeLikeDto.getNoticeNo()};
        jdbcTemplate.update(sql, param);
    }

    //좋아요 해제
    @Override
    public void delete(NoticeLikeDto noticeLikeDto) {
        String sql = "delete from notice_like where emp_no = ? and notice_no = ?";
        Object[] param = {noticeLikeDto.getEmpNo(), noticeLikeDto.getNoticeNo()};
        jdbcTemplate.update(sql, param);
    }

    //좋아요 여부 확인
    @Override
    public boolean check(NoticeLikeDto noticeLikeDto) {
        String sql = "select count(*) from notice_like where emp_no = ? and notice_no = ?";
        Object[] param = {noticeLikeDto.getEmpNo(), noticeLikeDto.getNoticeNo()};
        int count = jdbcTemplate.queryForObject(sql, int.class, param);
        return count == 1;
    }

    //게시글 좋아요 개수
    @Override
    public int count(int noticeNo) {
        String sql = "select count(*) from notice_like where notice_no = ?";
        Object[] param = {noticeNo};
        return jdbcTemplate.queryForObject(sql, int.class, param);
    }
}