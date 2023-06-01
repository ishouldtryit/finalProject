<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
 
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
  <script src="${pageContext.request.contextPath}/static/js/message/messageReceiveDetail.js"></script>
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

  <div class="mt-4">
    <h1>${messageWithNickDto.messageTitle}</h1>
  </div>
  <hr/>
  <div class="d-flex">
    <div class="pocketmonTrade-btn message-delete-btn">
      <i class="fa-solid fa-xmark" style="color:red;"></i> 삭제
    </div>
    <div class="pocketmonTrade-btn message-reply-btn">
      <i class="fa-solid fa-reply" style="color: #9DACE4;"></i> 답장
    </div>
    <a href="${pageContext.request.contextPath}/message/receive" class="pocketmonTrade-btn message-list-btn ml-auto">
      <i class="fa-solid fa-list" style="color: #9DACE4;"></i> 목록
    </a>
  </div>
  <hr/>
  <div class="row">
  <div class="d-flex">
    <div class="profile-image employee-name">
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
      <b>보낸사람</b>
      ${messageWithNickDto.messageSenderNick} (${messageWithNickDto.messageSender})
      [<fmt:formatDate value="${messageWithNickDto.messageSendTime}" pattern="yyyy.MM.dd. H:m"/>]
    </div>
  </div>
</div>
<hr>

<div class="row">
  <div class="d-flex">
    <div class="profile-image employee-name">
        <img width="40" height="40" src="<c:choose>
            <c:when test="${recipientProfile.attachmentNo > 0}">
                /attachment/download?attachmentNo=${recipientProfile.attachmentNo}
            </c:when>
            <c:otherwise>
                https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
            </c:otherwise>
        </c:choose>" alt="" style="border-radius: 50%;">
    </div>
  <b>받은사람 </b>
  ${messageWithNickDto.messageRecipientNick} (${messageWithNickDto.messageRecipient})
  [<fmt:formatDate value="${messageWithNickDto.messageReadTime}" pattern="yyyy.MM.dd. H:m"/>]
</div>


  <hr/>
  <div class="row message-content" style="min-height: 200px;">
    ${messageWithNickDto.messageContent}
  </div>
  <hr/>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


</body>
</html>
