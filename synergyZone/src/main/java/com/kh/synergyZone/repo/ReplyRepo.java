package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.ReplyDto;

public interface ReplyRepo {
    void insert(ReplyDto replyDto);
    List<ReplyDto> selectList(int replyOrigin);
    void update(ReplyDto replyDto);
    void delete(int replyNo);
    ReplyDto selectOne(int replyNo);
}