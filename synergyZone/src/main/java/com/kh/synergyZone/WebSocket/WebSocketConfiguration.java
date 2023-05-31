package com.kh.synergyZone.WebSocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

//웹소켓 설정파일
@Configuration
public class WebSocketConfiguration implements WebSocketConfigurer{

	@Autowired
	private WebSocketServer server;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(server, "ws/chat/info")
										.addInterceptors(new HttpSessionHandshakeInterceptor())
										.withSockJS();
	}

}
