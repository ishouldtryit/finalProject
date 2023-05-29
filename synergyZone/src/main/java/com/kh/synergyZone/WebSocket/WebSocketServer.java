package com.kh.synergyZone.WebSocket;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.synergyZone.vo.ChatUserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WebSocketServer extends TextWebSocketHandler{
 
	
	//연결시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		ChatUserVO chatUserVO=new ChatUserVO(session);
		
	}
	
	//연결종료시 
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

	}
	
	
	
	
}