package com.kh.synergyZone.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.synergyZone.dao.MessageDao;
import com.kh.synergyZone.dto.MessageDto;

@Service
public class MessageService {

  @Autowired
  private MessageDao messageDao;

  public void insert(MessageDto messageDto, List<String> recipients) {
    for(String recipient : recipients){
      int newMessageSeq = messageDao.sequence();
      messageDto.setMessageNo(newMessageSeq);
      messageDto.setMessageRecipient(recipient);
      messageDao.insert(messageDto);
    }
  }
}