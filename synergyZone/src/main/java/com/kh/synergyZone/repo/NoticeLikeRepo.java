package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.NoticeLikeDto;

public interface NoticeLikeRepo {

    // 좋아요 등록
    void insert(NoticeLikeDto noticeLikeDto);

    // 좋아요 해제
    void delete(NoticeLikeDto noticeLikeDto);

    // 좋아요 여부 확인
    boolean check(NoticeLikeDto noticeLikeDto);

    // 게시글 좋아요 개수
    int count(int noticeNo);
}