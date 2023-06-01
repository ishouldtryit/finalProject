package com.kh.synergyZone.vo;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.web.socket.TextMessage;

public class ChatRoomVO {
	//사용자 저장소
	Set<ChatUserVO> users=new CopyOnWriteArraySet<>();
	
	//입장기능
	public void enter(ChatUserVO user) {
		users.add(user);
	}
	
	//퇴장기능
	public void leave(ChatUserVO user) {
		users.remove(user);
	}
	
	//사용자 인원
	public int size() {
		return users.size();
	}
	
	//사용자 유무 확인
	public boolean contains(ChatUserVO user) {
		return users.contains(user);
	}
	
	//방 사용자들에게 메세지 전송
	public void broadcast(TextMessage jsonMessage) throws IOException {
		for(ChatUserVO user:users) {
			user.send(jsonMessage);
		}
	}
	
}
