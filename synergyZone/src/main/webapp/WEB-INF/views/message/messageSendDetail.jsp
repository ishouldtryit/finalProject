<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
  var messageNo = parseInt("${messageWithNickDto.getMessageNo()}");
  var messageSender = "${messageWithNickDto.getMessageSender()}";
</script>
<script src="${pageContext.request.contextPath}/static/js/message/messageSendDetail.js"></script>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    .message-detail {
      max-width: 1400px;
      min-height:550px;
      margin: 0 auto;
      padding: 20px;
      background-color: #F8F8F8;
      border: 1px solid #DDD;
      border-radius: 5px;
    }
  
    h1 {
      font-size: 24px;
      margin: 0;
      margin-bottom: 20px;
    }
  
    .message-delete-btn {
      display: inline-block;
      margin-right: 10px;
      padding: 8px 12px;
      border: none;
      border-radius: 4px;
      color: #FFF;
      font-weight: bold;
      cursor: pointer;
      background-color: #E74C3C;
      transition: background-color 0.3s;
    }
  
    .message-reply-btn {
      display: inline-block;
      margin-right: 10px;
      padding: 8px 12px;
      border: none;
      border-radius: 4px;
      color: #FFF;
      font-weight: bold;
      cursor: pointer;
      background-color: #9DACE4;
      transition: background-color 0.3s;
    }
  
    .message-list-btn {
      display: inline-block;
      margin-right: 10px;
      padding: 8px 12px;
      border: none;
      border-radius: 4px;
      color: #FFF;
      font-weight: bold;
      cursor: pointer;
      background-color: #9DACE4;
      text-decoration: none;
      transition: background-color 0.3s;
    }
  
    .message-info {
      margin-bottom: 20px;
    }
  
    .message-info .d-flex {
      align-items: center;
    }
  
    .profile-image {
      margin-right: 10px;
    }
  
    .profile-image img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
    }
  
    .sender-info,
    .recipient-info {
      font-size: 14px;
      font-weight: bold;
    }
  
    .message-content {
      font-size: 16px;
    }
    .message-actions button.message-delete-btn {
      background-color: #ffffff;
      color:#EC6C64;
      border:1px solid #EC6C64;
    }
  .message-actions button.message-delete-btn:hover{
  	background-color:#EC6C64;
  	color:#ffffff;
  }
    .message-actions button.message-reply-btn {
      background-color: #ffffff;
      color:#34649C;
      border:1px solid #34649C
    }
    .message-actions button.message-reply-btn:hover{
    	background-color: #34649C;
    	color:#ffffff;
    }
  </style>
</head>
<body>

  <script src="${pageContext.request.contextPath}/static/js/message/messageReceiveDetail.js"></script>

<div class="container">
<div class="message-detail">
  <div class="d-flex justify-content-between">
    
      <div class="message-actions">
      
      <button class="message-reply-btn">
      <i class="fa-solid fa-reply" style="color: darkblue;"></i> 답장
    </button>
      	<button class="message-delete-btn">
        <i class="fa-solid fa-xmark" style="color:red;"></i> 삭제
      </button>
    </div>
      <a href="${pageContext.request.contextPath}/message/receive" class="btn btn-outline-secondary">
        <i class="fa-solid fa-list" style="color:gray"></i> 목록
      </a>
    </div>
  
   <h1 class="mt-5">${messageWithNickDto.messageTitle}</h1>
   <hr>
  <div class="message-info">
    <div class="d-flex mt-2">
      <div class="profile-image">
        <img width="40" height="40" src="<c:choose>
            <c:when test="${senderProfile.attachmentNo > 0}">
                /attachment/download?attachmentNo=${senderProfile.attachmentNo}
            </c:when>
            <c:otherwise>
                https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
            </c:otherwise>
        </c:choose>" alt="" style="border-radius: 50%;">
      </div>
      <div class="sender-info">
        <b class="mt-2 ml-2">보낸사람:</b>
        ${messageWithNickDto.messageSenderNick} (${messageWithNickDto.messageSender})
        [<fmt:formatDate value="${messageWithNickDto.messageSendTime}" pattern="yyyy.MM.dd. H:m"/>]
      </div>
    </div>

    <div class="d-flex">
      <div class="profile-image">
        <img width="40" height="40" src="<c:choose>
            <c:when test="${recipientProfile.attachmentNo > 0}">
                /attachment/download?attachmentNo=${recipientProfile.attachmentNo}
            </c:when>
            <c:otherwise>
                https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
            </c:otherwise>
        </c:choose>" alt="" style="border-radius: 50%;">
      </div>
      <div class="recipient-info">
        <b class="mt-2 ml-2">받은사람:</b>
        ${messageWithNickDto.messageRecipientNick} (${messageWithNickDto.messageRecipient})
        [<fmt:formatDate value="${messageWithNickDto.messageReadTime}" pattern="yyyy.MM.dd. H:m"/>]
      </div>
    </div>
    <hr>
    <div class="message-content">
      ${messageWithNickDto.messageContent}
    </div>
  </div>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

</body>
</html>
