package com.kh.synergyZone.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.MessageWithNickDto;
import com.kh.synergyZone.vo.PaginationVO;

@Repository
public class MessageWithNickDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<MessageWithNickDto> mapper = new RowMapper<MessageWithNickDto>() {
        @Override
        @Nullable
        public MessageWithNickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
            return MessageWithNickDto
                    .builder()
                    .messageNo(rs.getInt("MESSAGE_NO"))
                    .messageRecipient(rs.getString("MESSAGE_RECIPIENT"))
                    .messageSender(rs.getString("MESSAGE_SENDER"))
                    .messageTitle(rs.getString("MESSAGE_TITLE"))
                    .messageContent(rs.getString("MESSAGE_CONTENT"))
                    .messageSendTime(rs.getDate("MESSAGE_SEND_TIME"))
                    .messageReadTime(rs.getDate("MESSAGE_READ_TIME"))
                    .messageSenderStore(rs.getInt("MESSAGE_SENDER_STORE"))
                    .messageRecipientStore(rs.getInt("MESSAGE_RECIPIENT_STORE"))
                    .messageSenderNick(rs.getString("MESSAGE_SENDER_NICK"))
                    .messageRecipientNick(rs.getString("MESSAGE_RECIPIENT_NICK"))
                    .build();
        }

    };

    // R 받은메세지 + 닉네임 리스트 가져오기
    public List<MessageWithNickDto> selectReceiveMessage(PaginationVO pageVo, String empNo) {
        String sql;
        Object[] param;
        if ("".equals(pageVo.getKeyword())) {
        	sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 order by message_no desc) tmp) where rn between ? and ?";
        	param = new Object[] { empNo, pageVo.getBegin(), pageVo.getEnd() };

        } else {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 and instr(#1, ?) > 0 order by message_no desc) tmp) where rn between ? and ?";
            sql = sql.replace("#1", pageVo.getColumn());
            param = new Object[] {
                    empNo,
                    pageVo.getKeyword(),
                    pageVo.getBegin(),
                    pageVo.getEnd(),
            };
        }
        return jdbcTemplate.query(sql, mapper, param);
    }

    // R 보낸메세지 + 닉네임 리스트 가져오기
    public List<MessageWithNickDto> selectSendMessage(PaginationVO pageVo, String empName) {
        String sql;
        Object[] param;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_sender = ? and message_sender_store = 1 order by message_no desc) tmp) where rn between ? and ?";
            param = new Object[] { empName, pageVo.getBegin(), pageVo.getEnd() };
        } else {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_sender = ? and message_sender_store = 1 and instr(#1, ?) > 0 order by message_no desc) tmp) where rn between ? and ?";
            sql = sql.replace("#1", pageVo.getColumn());
            param = new Object[] {
                    empName,
                    pageVo.getKeyword(),
                    pageVo.getBegin(),
                    pageVo.getEnd(),
            };
        }
        return jdbcTemplate.query(sql, mapper, param);
    }

    // R 안 읽은 받은메세지 + 닉네임 리스트 가져오기
    public List<MessageWithNickDto> selectReceiveNRMessage(PaginationVO pageVo, String empName) {
        String sql;
        Object[] param;
        if (pageVo.getKeyword().equals("")) {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 and message_read_time is null order by message_no desc) tmp) where rn between ? and ?";
            param = new Object[] { empName, pageVo.getBegin(), pageVo.getEnd() };
        } else {
            sql = "select * from (select rownum rn, tmp.* from (select * from message_with_nick where message_recipient = ? and message_recipient_store = 1 and instr(#1, ?) > 0 and message_read_time is null order by message_no desc) tmp) where rn between ? and ?";
            sql = sql.replace("#1", pageVo.getColumn());
            param = new Object[] {
                    empName,
                    pageVo.getKeyword(),
                    pageVo.getBegin(),
                    pageVo.getEnd(),
            };
        }
        return jdbcTemplate.query(sql, mapper, param);
    }

    // R 받은 메세지 + 닉네임 가져오기
    public MessageWithNickDto selectReceiveMessage(int messageNo, String empName) {
        String sql = "select * from message_with_nick where message_no = ? and message_recipient = ?";
        Object[] param = { messageNo, empName };
        List<MessageWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0);
    }

    // R 보낸 메세지 + 닉네임 가져오기
    public MessageWithNickDto selectSendMessage(int messageNo, String empName) {
        String sql = "select * from message_with_nick where message_no = ? and message_sender = ?";
        Object[] param = { messageNo, empName };
        List<MessageWithNickDto> list = jdbcTemplate.query(sql, mapper, param);
        return list.isEmpty() ? null : list.get(0);
    }

    // R 받은메세지 카운트 세기
    public int getReceiveCount(PaginationVO pageVo, String empName) {
        String sql;
        int cnt;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ?";
            Object[] param = { empName };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        } else {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ? and instr(#1, ?) > 0";
            sql = sql.replace("#1", pageVo.getColumn());
            Object[] param = { empName, pageVo.getKeyword() };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        }
        return cnt;
    }

    // R 안 읽은 받은메세지 카운트 세기
    public int getReceiveNRCount(PaginationVO pageVo, String empName) {
        String sql;
        int cnt;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ? and message_read_time is null";
            Object[] param = { empName };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        } else {
            sql = "select count(*) from message_with_nick where message_recipient_store = 1 and message_recipient = ? and instr(#1, ?) > 0 and message_read_time is null";
            sql = sql.replace("#1", pageVo.getColumn());
            Object[] param = { empName, pageVo.getKeyword() };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        }
        return cnt;
    }

    // R 보낸메세지 카운트 세기
    public int getSendCount(PaginationVO pageVo, String empName) {
        String sql;
        int cnt;
        if ("".equals(pageVo.getKeyword())) {
            sql = "select count(*) from message_with_nick where message_sender_store = 1 and message_sender = ?";
            Object[] param = { empName };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        } else {
            sql = "select count(*) from message_with_nick where message_sender_store = 1 and message_sender = ? and instr(#1, ?) > 0";
            sql = sql.replace("#1", pageVo.getColumn());
            Object[] param = { empName, pageVo.getKeyword() };
            cnt = jdbcTemplate.queryForObject(sql, int.class, param);
        }
        return cnt;
    }

}