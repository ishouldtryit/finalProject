package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.NoticeReplyDto;

public interface NoticeReplyRepo {
    void insert(NoticeReplyDto noticeReplyDto);
    List<NoticeReplyDto> selectList(int noticeReplyOrigin);
    void update(NoticeReplyDto noticeReplyDto);
    void delete(int noticeReplyNo);
    NoticeReplyDto selectOne(int noticeReplyNo);
}