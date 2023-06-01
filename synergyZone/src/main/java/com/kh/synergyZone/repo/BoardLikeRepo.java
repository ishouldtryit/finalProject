package com.kh.synergyZone.repo;

import com.kh.synergyZone.dto.BoardLikeDto;

public interface BoardLikeRepo {

    // 좋아요 등록
    void insert(BoardLikeDto boardLikeDto);

    // 좋아요 해제
    void delete(BoardLikeDto boardLikeDto);

    // 좋아요 여부 확인
    boolean check(BoardLikeDto boardLikeDto);

    // 게시글 좋아요 개수
    int count(int boardNo);
}