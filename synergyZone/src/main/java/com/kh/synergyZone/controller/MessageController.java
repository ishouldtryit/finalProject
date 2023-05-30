package com.kh.synergyZone.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.synergyZone.dao.MessageDao;
import com.kh.synergyZone.dao.MessageWithNickDao;
import com.kh.synergyZone.dto.MessageWithNickDto;

@Controller
@RequestMapping("/message")
public class MessageController {

  @Autowired
  private MessageDao messageDao;

  @Autowired
  private MessageWithNickDao messageWithNickDao;

  // 받은메세지 리스트
  @GetMapping("/receive")
  public String receiveList() {
    return "message/messageReceive";
  }
  // 보낸메세지 리스트
  @GetMapping("/send")
  public String sendList() {
    return "message/messageSend";
  }
  // 메세지 쓰기
  @GetMapping("/write")
  public String messageWrite(
      @RequestParam(required = false, defaultValue = "") String recipient) {
    return "message/messageWrite";
  }
  
//받은메세지 상세
@GetMapping("/receive/detail")
public String receiveDetail(
   @RequestParam int messageNo,
   HttpSession session,
   Model model) {
 String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
 // 처음 읽었을 때 시간 기록
 messageDao.updateReceiveTime(messageNo, empNo);

 // 받은 메세지 1개 가져오기
 MessageWithNickDto messageWithNickDto = messageWithNickDao.selectReceiveMessage(messageNo, empNo);
 model.addAttribute("messageWithNickDto", messageWithNickDto);

 return "/message/messageReceiveDetail";
}

//보낸메세지 상세
@GetMapping("/send/detail")
public String sendDetail(
   @RequestParam int messageNo,
   HttpSession session,
   Model model) {
 String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");

 MessageWithNickDto messageWithNickDto = messageWithNickDao.selectSendMessage(messageNo, empNo);
 model.addAttribute("messageWithNickDto", messageWithNickDto);
 return "/message/messageSendDetail";
}

}