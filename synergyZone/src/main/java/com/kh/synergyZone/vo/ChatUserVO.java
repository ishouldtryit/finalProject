package com.kh.synergyZone.vo;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
//세션이 동일한지 판별
@EqualsAndHashCode(of= {"session"})
public class ChatUserVO {
	private String empNo,empName;
	private WebSocketSession session;
	
	//회원여부 판별
	public boolean isMember() {
		return this.empNo != null;
	}
	
	//메세지 전송
	public void send(TextMessage jsonMessage) throws IOException {
		session.sendMessage(jsonMessage);
	}
	
	//사용자등록
	public ChatUserVO(WebSocketSession session) {
		this.session = session;
		Map<String, Object> attr = session.getAttributes();
		this.empNo = (String)attr.get("empNo");
		this.empName= (String)attr.get("empName");
	}
}
