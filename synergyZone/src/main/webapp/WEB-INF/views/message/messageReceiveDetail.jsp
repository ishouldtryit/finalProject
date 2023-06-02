<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/message.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
  <script src="${pageContext.request.contextPath}/static/js/message/messageReceiveDetail.js"></script>
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

  <div class="message-detail">
    <h1>제목 : ${messageWithNickDto.messageTitle}</h1>
    <div class="message-actions">
      <button class="message-delete-btn">
        <i class="fa-solid fa-xmark" style="color:red;"></i> 삭제
      </button>
      <button class="message-reply-btn">
        <i class="fa-solid fa-reply" style="color: #9DACE4;"></i> 답장
      </button>
      <a href="${pageContext.request.contextPath}/message/receive" class="message-list-btn">
        <i class="fa-solid fa-list" style="color: #9DACE4;"></i> 목록
      </a>
    </div>
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
          <div class="sender-info mt-2">
			    <b class="mt-2 ml-2">보낸사람:</b>
			    ${messageWithNickDto.messageSenderNick} (${messageWithNickDto.messageSender})
			    [<fmt:formatDate value="${messageWithNickDto.messageSendTime}" pattern="yyyy.MM.dd. H:m"/>]
		</div>

      </div>
      <hr>
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
        <div class="recipient-info mt-2">
          <b class="mt-2 ml-2">받은사람 :</b>
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
