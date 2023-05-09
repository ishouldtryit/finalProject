package com.kh.synergyZone.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class MessageWithNickDto {
    private int messageNo;
    private String messageRecipient;
    private String messageSender;
    private String messageTitle;
    private String messageContent;
    private Date messageSendTime;
    private Date messageReadTime;
    private int messageSenderStore;
    private int messageRecipientStore;
    private String messageSenderNick;
    private String messageRecipientNick;
}