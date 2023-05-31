package com.kh.synergyZone.repo;

import java.util.List;

import com.kh.synergyZone.dto.ReplyDto;
import com.kh.synergyZone.vo.ReplyVO;

public interface ReplyRepo {
    void insert(ReplyDto replyDto);
    List<ReplyVO> selectList(int replyOrigin);
    void update(ReplyDto replyDto);
    void delete(int replyNo);
    ReplyVO selectOne(int replyNo);
}