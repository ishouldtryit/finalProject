package com.kh.synergyZone.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Repository;

import com.kh.synergyZone.dto.MessageDto;

@Repository
public class MessageDao {

  @Autowired
  private JdbcTemplate jdbcTemplate;

  private RowMapper<MessageDto> mapper = new RowMapper<MessageDto>() {
    @Override
    @Nullable
    public MessageDto mapRow(ResultSet rs, int rowNum) throws SQLException {
      return MessageDto
          .builder()
          .messageNo(rs.getInt("message_no"))
          .messageRecipient(rs.getString("message_recipient"))
          .messageSender(rs.getString("message_sender"))
          .messageTitle(rs.getString("message_title"))
          .messageContent(rs.getString("message_content"))
          .messageSendTime(rs.getDate("message_send_time"))
          .messageReadTime(rs.getDate("message_read_time"))
          .messageSenderStore(rs.getInt("message_sender_store"))
          .messageRecipientStore(rs.getInt("message_recipient_store"))
          .build();
    }
  };

  // 메세지 시퀀스 생성
  public int sequence() {
    String sql = "select message_seq.nextval from dual";
    return jdbcTemplate.queryForObject(sql, int.class);
  }

  // C 메세지 생성
  public void insert(MessageDto messageDto) {
    String sql = "insert into message (message_no, message_recipient, message_sender, message_title, message_content, message_send_time, message_sender_store, message_recipient_store) values (?, ?, ?, ?, ?, sysdate, 1, 1)";
    Object[] param = {
        messageDto.getMessageNo(),
        messageDto.getMessageRecipient(),
        messageDto.getMessageSender(),
        messageDto.getMessageTitle(),
        messageDto.getMessageContent(),
    };
    jdbcTemplate.update(sql, param);
  }

  // R 받은 메시지리스트 부르기
  public List<MessageDto> selectReceiveMessage(String messageRecipient) {
    String sql = "select * from message where message_recipient = ? and message_recipient_store = 1 order by message_no desc";
    Object[] param = { messageRecipient };
    return jdbcTemplate.query(sql, mapper, param);
  }

  // R 읽지 않은 메세지리스트 부르기
  public List<MessageDto> selectNewReceiveMessage(String messageRecipient) {
    String sql = "select * from message where message_recipient = ? and message_recipient_store = 1 and message_read_time is null order by message_no desc";
    Object[] param = { messageRecipient };
    return jdbcTemplate.query(sql, mapper, param);
  }

  // R 보낸 메세지리스트 부르기
  public List<MessageDto> selectSendMessage(String messageSender) {
    String sql = "select * from message where message_Sender = ? and message_sender_store = 1 order by message_no desc";
    Object[] param = { messageSender };
    return jdbcTemplate.query(sql, mapper, param);
  }

  // R 받은 메세지 한개 선택
  public MessageDto selectReceiveOne(int messageNo, String memberId) {
    String sql = "select * from message where message_no = ? and message_recipient = ? and message_recipient_store = 1";
    Object[] param = { messageNo, memberId };
    List<MessageDto> list = jdbcTemplate.query(sql, mapper, param);
    return list.isEmpty() ? null : list.get(0);
  }

  // R 보낸 메세지 한개 선택
  public MessageDto selectSendOne(int messageNo, String memberId) {
    String sql = "select * from message where message_no = ? and message_sender = ? and message_sender_store = 1";
    Object[] param = { messageNo, memberId };
    List<MessageDto> list = jdbcTemplate.query(sql, mapper, param);
    return list.isEmpty() ? null : list.get(0);
  }

  // R 받은 메세지 중 안 읽은 메세지 카운트
  public int countNotRead(String memberId) {
    String sql = "select count(*) from message where message_recipient = ? and message_recipient_store = 1 and message_read_time is null ";
    Object[] param = { memberId };
    return jdbcTemplate.queryForObject(sql, int.class, param);
  }

  // U 받은 메세지 읽은시간 기록
  public boolean updateReceiveTime(int messageNo, String memberId) {
    String sql = "update message set message_read_time = sysdate where message_no = ? and message_recipient = ? and message_read_time is null";
    Object[] param = { messageNo, memberId };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // U 받은 메세지 삭제
  public boolean deleteReceiveMessage(int messageNo, String memberId) {
    String sql = "update message set message_recipient_store = 0 where message_no = ? and message_recipient = ?";
    Object[] param = { messageNo, memberId };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // U 보낸 메세지 삭제
  public boolean deleteSendMessage(int messageNo, String memberId) {
    String sql = "update message set message_sender_store = 0 where message_no = ? and message_sender = ?";
    Object[] param = { messageNo, memberId };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // D store 확인 후 메세지 삭제
  public boolean deleteMessage(int messageNo) {
    String sql = "delete from message where message_no = ? and message_sender_store = 0 and message_recipient_store = 0";
    Object[] param = { messageNo };
    return jdbcTemplate.update(sql, param) > 0;
  }

  // D 메세지 발송취소 삭제
  public boolean deleteSendCancle(int messageNo, String messageSender) {
    String sql = "delete from message where message_no = ? and message_sender = ?";
    Object[] param = { messageNo, messageSender };
    return jdbcTemplate.update(sql, param) > 0;
  }
}