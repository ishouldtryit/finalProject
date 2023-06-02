package com.kh.synergyZone.WebSocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.synergyZone.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WebSocketServer extends TextWebSocketHandler{
	@Autowired
	private ChatService chatService;
	
	//연결시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		chatService.connectHandler(session);
		
	}
	
	//연결종료시 
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.debug("status: " + status);
		chatService.disconnectHandler(session);
	}
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		chatService.receiveHandler(session, message);
	}
}
