package com.kh.synergyZone.service;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.synergyZone.dto.ChatMessageDto;
import com.kh.synergyZone.dto.ChatRoomDto;
import com.kh.synergyZone.dto.ChatUserDto;
import com.kh.synergyZone.repo.ChatMessageRepo;
import com.kh.synergyZone.repo.ChatRoomRepo;
import com.kh.synergyZone.repo.ChatUserRepo;
import com.kh.synergyZone.vo.ChatReceiveVO;
import com.kh.synergyZone.vo.ChatRoomVO;
import com.kh.synergyZone.vo.ChatUserVO;
import com.kh.synergyZone.vo.MemberMessageVO;
import com.kh.synergyZone.websocket.WebSocketConstant;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatServiceImpl implements ChatService {

	//여러 개의 방을 관리할 저장소
	private Map<String, ChatRoomVO> rooms = 
					Collections.synchronizedMap(new HashMap<>());
	
	//메세지 해석기
	private ObjectMapper mapper = new ObjectMapper();
	
	@Autowired
	private ChatRoomRepo chatRoomRepo;
	
	@Autowired
	private ChatUserRepo chatUserRepo;
	
	@Autowired
	private ChatMessageRepo chatMessageRepo;
	
	//channel vo에서 구현했던 모든 메소드
	//필요한 기능
	//- 방생성/제거/확인
	public void createRoom(String roomName) {
		if(containsRoom(roomName)) return;
		rooms.put(roomName, new ChatRoomVO());
		
		//방 등록(DB)
		boolean isWaitingRoom = roomName.equals(
									WebSocketConstant.WAITING_ROOM);
		if(!isWaitingRoom && chatRoomRepo.find(roomName) == null) {
			ChatRoomDto dto = new ChatRoomDto();
			dto.setRoomName(roomName);
			chatRoomRepo.create(dto);
		}
	}
	public void deleteRoom(String roomName) {
		rooms.remove(roomName);
		
		//방 제거(DB)
	}
	public boolean containsRoom(String roomName) {
		return rooms.containsKey(roomName);
	}
	
	//- 사용자를 방에 입장/퇴장
	public void join(ChatUserVO user, String roomName) {
		createRoom(roomName);//방 생성(있으면 안만들어짐)
		
		ChatRoomVO room = rooms.get(roomName);
		room.enter(user);
		
		//참여자 등록(DB) - 기존에 참여중이 아닌 경우 실행
		boolean isWaitingRoom = roomName.equals(
							WebSocketConstant.WAITING_ROOM);
		if(isWaitingRoom) return;//대기실이면 이후의 작업을 모두 취소
		
		ChatUserDto userDto = new ChatUserDto();
		userDto.setRoomName(roomName);
		userDto.setEmpNo(user.getEmpNo());
		boolean isJoin = chatUserRepo.check(userDto);
		if(isJoin) return;//참여한 적이 있다면 이후의 작업을 모두 취소
		
		ChatUserDto dto = new ChatUserDto();
		dto.setRoomName(roomName);
		dto.setEmpNo(user.getEmpNo());
		dto.setEmpName(user.getEmpName());
		chatUserRepo.add(dto);
		
		log.debug("{} 님이 {} 방으로 참여하였습니다", user.getEmpNo(), roomName);
	}
	public void exit(ChatUserVO user, String roomName) {
		if(containsRoom(roomName) == false) return;
		
		ChatRoomVO room = rooms.get(roomName);
		room.leave(user);
		
		//참여자 제거(DB)
		
		log.debug("{} 님이 {} 방에서 퇴장하였습니다", user.getEmpNo(), roomName);
	}

	//- 방에 메세지를 전송하는 기능(그룹채팅)
	public void broadcastRoom(ChatUserVO user, String roomName, TextMessage jsonMessage) throws IOException {
		if(containsRoom(roomName) == false) return;
		
		ChatRoomVO room = rooms.get(roomName);
		room.broadcast(jsonMessage);
		
		//메세지 발송 기록 등록
		//- 사용자 아이디, 방 이름, 메세지 내용
		ChatMessageDto dto = new ChatMessageDto();
		dto.setEmpNo(user.getEmpNo());
		dto.setRoomName(roomName);
		dto.setEmpName(user.getEmpName());
		dto.setMsgBody(jsonMessage.getPayload());
		chatMessageRepo.add(dto);
	}
	
	//- 사용자가 존재하는 방의 이름을 찾는 기능
	//-> 모든 방을 뒤져서 나오면 해당 방 이름을 반환
	public String findUser(ChatUserVO user) {
		for(String roomName : rooms.keySet()) {//모든 방의 이름을 꺼내서
			ChatRoomVO room = rooms.get(roomName);//방 객체를 추출하고
			if(room.contains(user)) {//해당 방 객체에 사용자가 있다면
				return roomName;//방 이름을 반환
			}
		}
		return null;//없네?
	}

	//- 사용자를 방에서 방으로 이동시키는 기능
	public void moveUser(ChatUserVO user, String roomName) {
		String beforeRoomName = findUser(user);//사용자 위치를 찾아라!
		exit(user, beforeRoomName);//나가!
		join(user, roomName);//들어가!
	}
	
	//- 방 개수
	//- 전체 방에 메세지를 전송하는 기능(공지)
	
	
	@Override
	public void connectHandler(WebSocketSession session) {
		//사용자 정보를 객체로 변환하여 저장
		ChatUserVO user = new ChatUserVO(session);
		String roomName = WebSocketConstant.WAITING_ROOM;
		this.join(user, roomName);
	}
	
	@Override
	public void disconnectHandler(WebSocketSession session) {
		//삭제의 조건
		//[1] 자료형이 일치해야 함(ChatUserVO)
		//[2] 비교기준이 설정되어있어야 함(hashCode, equals)
		ChatUserVO user = new ChatUserVO(session);
		String roomName = this.findUser(user);
		this.exit(user, roomName);
	}
	
	@Override
	public void receiveHandler(WebSocketSession session, TextMessage message) throws IOException {
		//회원 정보를 생성
		ChatUserVO user = new ChatUserVO(session);

		//비회원 차단 - 메세지만 전송을 하지 않음
		if(user.isMember() == false) return;
		
		//메세지를 수신(ChatReceiveVO)
		//- 이 메세지의 type을 분석하여 작업에 맞는 처리를 수행
		ChatReceiveVO receiveVO = 
				mapper.readValue(message.getPayload(), ChatReceiveVO.class);
		log.debug("receiveVO = {}", receiveVO);
		
		//채팅메세지인 경우
		if(receiveVO.getType() == WebSocketConstant.CHAT) {
			//receiveVO.content에 채팅 메세지가 있다
			
			String roomName = this.findUser(user);//찾아
			if(roomName == null) return;//없으면 하지마
			
			//(옵션) 대기실인경우 메세지 전송이 불가
			if(roomName.equals(WebSocketConstant.WAITING_ROOM)) 
				return;
			
			//보낼 메세지 생성
			MemberMessageVO msg = new MemberMessageVO();
			msg.setContent(receiveVO.getContent());//전송내용
			msg.setTime(System.currentTimeMillis());//전송시각
			msg.setEmpNo(user.getEmpNo());//아이디
			msg.setEmpName(user.getEmpName());
			
			//JSON 변환
			String jsonStr = mapper.writeValueAsString(msg);
			TextMessage jsonMessage = new TextMessage(jsonStr);
			
			this.broadcastRoom(user, roomName, jsonMessage);//방에 메세지 보내
		}
		//입장메세지인 경우
		else if(receiveVO.getType() == WebSocketConstant.JOIN) {
			//receiveVO.room에 방 번호가 있다
			String roomName = receiveVO.getRoomNo();
			this.moveUser(user, roomName);
		}
	}
}






