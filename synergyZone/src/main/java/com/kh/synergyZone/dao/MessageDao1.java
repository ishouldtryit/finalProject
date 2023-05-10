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
import com.kh.synergyZone.dto.MessageDto1;

@Repository
public class MessageDao1 {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<MessageDto1> mapper = new RowMapper<MessageDto1>() {

		@Override
		@Nullable
		public MessageDto1 mapRow(ResultSet rs, int rowNum) throws SQLException {
			return MessageDto1
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
	
	//메세지 시퀀스 생성 
	public int sequence() {
		String sql = "select message_seq_nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//메세지 생성 C 
	public void insert(MessageDto1 messageDto) {
		String sql = "insert into message (message_no, message_recipient, message_sender, message_title, message_content, "
				+ "message_send_time, message_sender_store, message_recipient_store) values (?, ?, ?, ?, ?, sysdate, 1, 1)";
		Object[] param = {
				messageDto.getMessageNo(),
				messageDto.getMessageRecipient(),
				messageDto.getMessageSender(),
				messageDto.getMessageTitle(),
				messageDto.getMessageContent()
		};
		jdbcTemplate.update(sql, param);
	}
	
	//받은 메세지 부르기 R
	public List<MessageDto1> selectReceiveMessage(String messageRecipient) {
		String sql = "select * from message where message_recipient = ? and message_recipient_store = 1 order by message_no desc";
		Object[] param = { messageRecipient };
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	//읽지 않은 메시지 부르기 R
	public List<MessageDto1> selectNewReceiveMessage(String messageRecipient) {
		String sql = "select * from message where message_recipient = ? and message_recipient_store = 1 and "
				+ "message_read_time is null order by message_no desc";
		Object[] param = { messageRecipient };
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	//보낸 메세지리스트 부르기 R 
	public List<MessageDto1> selectSendMessage(String messageSender) {
		String sql = "select * from message where message_sender = ? and message_sender_store = 1 order by message_no desc";
		Object[] param = { messageSender };
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	//받은 메세지 중 1개 선택 R 
	public MessageDto1 selectReceiveOne(int messageNo) {//일단 사원번호 생략)
		String sql = "select * from message where message_no = ? and message_recipient = ? and message_recipient_store = 1";
	    Object[] param = { messageNo };
	    List<MessageDto1> list = jdbcTemplate.query(sql, mapper, param);
	    return list.isEmpty() ? null : list.get(0);
	}
	
	//보낸 메세지 중 1개 선택 R
	public MessageDto1 selectSendOne(int messageNo) { //일단 사원번호 생략)
		String sql = "select * from message where message_no = ? and message_sender = ? and message_sender_store = 1";
		Object[] param = { messageNo };
		List<MessageDto1> list = jdbcTemplate.query(sql, mapper, param);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//받은 메시지 중 안 읽은 메시지 카운트 R 
	public int countNotRead(String memberId) { //멤버 아이디로 임시처리
		String sql ="select * from message where message_recipient = ? and message_recipient_store = 1 and message_read_time is null";
		Object[] param = { memberId };
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	
	//받은 메세지 읽은시간 기록 U
	public boolean updateReceiveTime(int messageNo, String memberId) {
		String sql = "update message set message_read_time = sysdate where message_no = ? "
				+ "and message_recipient = ? and message_read_time = null";
		Object[] param = { messageNo, memberId };
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	// 받은 메세지 삭제 U 
	public boolean deleteReceiveMessage(int messageNo, String memberId) {
		String sql = "update message set message_recipient_store = 0 where message_no = ? and message_recipient = ?";
		Object[] param = { messageNo, memberId };
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//보낸 메시지 삭제 U
	public boolean deleteSendMessage(int messageNo, String memberId) {
		String sql = "update message set message_sender_store = 0 where message_no = ? and message_sender = ?";
		Object[] param = { messageNo, memberId };
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//store 확인 후 메시지 삭제 D
	public boolean deleteMessage(int messageNo) {
		String sql = "delete from message where message_no = ?, and message_sender_store = 0 and message_recipient_store= 0";
		Object[] param = { messageNo };
		return jdbcTemplate.update(sql, param) > 0;
	}
	 
	//메시지 발송 취소 삭제 D
//	public boolean deleteSendMessage(int messageNo) {
//		
//	}
//	
	 
	
}
