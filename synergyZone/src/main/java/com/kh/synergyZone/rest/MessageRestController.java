package com.kh.synergyZone.rest;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.synergyZone.dao.MessageDao;
import com.kh.synergyZone.dao.MessageWithNickDao;
import com.kh.synergyZone.dto.MessageDto;
import com.kh.synergyZone.dto.MessageWithNickDto;
import com.kh.synergyZone.service.MessageService;
import com.kh.synergyZone.vo.PaginationVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/message")
public class MessageRestController {

  @Autowired
  private MessageDao messageDao;

  @Autowired
  private MessageService messageService;

  @Autowired
  private MessageWithNickDao messageWithNickDao;

  
  @GetMapping("/{recipient}")
  public String checkRecipientExists(@PathVariable String recipient) {
      // 실제 DB에 있는지 조회하는 로직을 구현합니다.
      // 예를 들어, 해당 recipient를 이용하여 DB에서 검색하고 결과에 따라 "Y" 또는 "N"을 반환합니다.
      // 이 예제에서는 임의로 "Y"를 반환하도록 하겠습니다.
      return "Y";
  }

  // 비동기 메세지 보내기(받는사람, 보내는사람, 제목, 내용을 입력받아 새로운 Message 생성)
  @PostMapping("/write")
  public void insert(MessageDto messageDto,@RequestParam("recipients") List<String> recipients) {
	// 메세지 보내는 대상자 확인
	    boolean result = true;
	    for (String recipient : recipients) {
	        String response = checkRecipientExists(recipient);
	        result &= response.equals("Y");
	    }

	    if (!result) {
	        // 대상자가 유효하지 않은 경우 처리
	        // 예를 들어, 예외를 던지거나 실패 메시지를 반환하도록 구현합니다.
	        // 여기에서는 단순히 콘솔에 오류 메시지를 출력하도록 하겠습니다.
//	        System.out.println("쪽지를 보낼 수 없습니다\n받는 주소를 확인해주세요");
	        return;
	    }

	    // 대상자가 유효한 경우 메시지 전송 처리
	    messageService.insert(messageDto, recipients);
	}
  // S 받은메세지 + 보낸시간List
  @GetMapping("/receive")
  public Map<String, List<? extends Object>> selectReceiveMessageTest(PaginationVO pageVo,
      @RequestParam(required = false, defaultValue = "") String mode, HttpSession session) {
    String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
    if (empNo == null)
      return null;

    List<MessageWithNickDto> list = new ArrayList<>();
    List<String> sendTimeList = new ArrayList<>();
    List<Object> pageVoList = new ArrayList<>();

    if ("new".equals(mode)) {
      pageVo.setCount(messageWithNickDao.getReceiveNRCount(pageVo, empNo));
      list = messageWithNickDao.selectReceiveNRMessage(pageVo, empNo);
      for (int i = 0; i < list.size(); i++) {
        SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. HH:mm");
        if (list.get(i).getMessageSendTime() == null) {
          sendTimeList.add(null);
        } else {
          java.util.Date utilSendDate = new java.util.Date(
              list.get(i).getMessageSendTime().getTime());
          String formattedSendDate = format.format(utilSendDate);
          sendTimeList.add(formattedSendDate);
        }
      }
    } else {
      // 페이지네이션 count 세팅
      pageVo.setCount(messageWithNickDao.getReceiveCount(pageVo, empNo));

      // 보낸 시간 리스트
      list = messageWithNickDao.selectReceiveMessage(pageVo, empNo);
      for (int i = 0; i < list.size(); i++) {
        SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. HH:mm");
        if (list.get(i).getMessageSendTime() == null) {
          sendTimeList.add(null);
        } else {
          java.util.Date utilSendDate = new java.util.Date(
              list.get(i).getMessageSendTime().getTime());
          String formattedSendDate = format.format(utilSendDate);
          sendTimeList.add(formattedSendDate);
        }
      }
    }
    // 페이지 Vo
    pageVoList.add(pageVo);

    return Map.of("list", list, "sendTimeList", sendTimeList, "pageVoList", pageVoList);
  }

  // S 보낸메세지 + 보낸, 받은시간List
  @GetMapping("/send")
  public Map<String, List<? extends Object>> selectSendMessage(PaginationVO pageVo, HttpSession session) {
    String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
    if (empNo == null)
      return null;
    pageVo.setCount(messageWithNickDao.getSendCount(pageVo, empNo));
    List<MessageWithNickDto> list = messageWithNickDao.selectSendMessage(pageVo, empNo);
    List<String> sendTimeList = new ArrayList<>();
    List<String> readTimeList = new ArrayList<>();
    List<Object> pageVoList = new ArrayList<>();
    for (int i = 0; i < list.size(); i++) {
      SimpleDateFormat format = new SimpleDateFormat("YYYY.MM.dd. hh:mm");
      if (list.get(i).getMessageSendTime() == null) {
        sendTimeList.add(null);
      } else {
        java.util.Date utilSendDate = new java.util.Date(
            list.get(i).getMessageSendTime().getTime());
        String formattedSendDate = format.format(utilSendDate);
        sendTimeList.add(formattedSendDate);
      }
      if (list.get(i).getMessageReadTime() == null) {
        readTimeList.add(null);
      } else {
        java.util.Date utilReadDate = new java.util.Date(
            list.get(i).getMessageReadTime().getTime());
        String formattedReadDate = format.format(utilReadDate);
        readTimeList.add(formattedReadDate);
      }
    }
    // 페이지 Vo
    pageVoList.add(pageVo);

    return Map.of("list", list, "sendTimeList", sendTimeList, "readTimeList", readTimeList, "pageVoList", pageVoList);
  }

  // [GET] 안 읽은 메세지 개수
  @GetMapping("/receive/notReadCount")
  public int selectNotReadReceiveCnt(PaginationVO pageVo, HttpSession session) {
    String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
    return messageWithNickDao.getReceiveNRCount(pageVo, empNo);
  }

  // 받은 메세지 1개 삭제
  @PutMapping("/receive")
  public void deleteReceive(@RequestParam int messageNo, HttpSession session) {
    String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
    messageDao.deleteReceiveMessage(messageNo, empNo);
    messageDao.deleteMessage(messageNo);
  }

  // 보낸 메세지 1개 삭제
  @PutMapping("/send")
  public void deleteSend(@RequestParam int messageNo, HttpSession session) {
    String empNo = session.getAttribute("empNo") == null ? null : (String) session.getAttribute("empNo");
    messageDao.deleteSendMessage(messageNo, empNo);
    messageDao.deleteMessage(messageNo);
  }

  // [Delete] 메세지 삭제
  @DeleteMapping("/{messageNo}")
  public boolean deleteMessage(@PathVariable int messageNo, HttpSession session) {
    String empNo = (String) session.getAttribute("empNo") == null ? null
        : (String) session.getAttribute("empNo");
    return messageDao.deleteSendCancle(messageNo, empNo);
  }

}




