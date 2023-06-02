package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.NoticeReplyDto;
import com.kh.synergyZone.vo.NoticeReplyVO;

public interface NoticeReplyRepo {
    void insert(NoticeReplyDto noticeReplyDto);
    List<NoticeReplyVO> selectList(int noticeReplyOrigin);
    void update(NoticeReplyDto noticeReplyDto);
    void delete(int noticeReplyNo);
    NoticeReplyVO selectOne(int noticeReplyNo);
}