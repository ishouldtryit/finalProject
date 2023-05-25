package com.kh.synergyZone.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

//웹소켓 설정파일
@Configuration
public class WebSocketConfiguration implements WebSocketConfigurer{

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(null, "ws/chat").withSockJS();
	}

}
