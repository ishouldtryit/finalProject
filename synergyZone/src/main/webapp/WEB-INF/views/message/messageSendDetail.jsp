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
<jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
<html>
<head>
  <meta charset="UTF-8">
  
</head>
<body>

<div class="container">
  <div class="row">
    <h1>${messageWithNickDto.getMessageTitle()}</h1>
  </div>
  <hr class="mt-0"/>
  <div class="row flex">
    <div class="pocketmonTrade-btn message-delete-btn">
      <i class="fas fa-times" style="color:red;"></i> 삭제
    </div>
    <a href="${pageContext.request.contextPath}/message/send" class="pocketmonTrade-btn message-list-btn ml-auto">
      <i class="fas fa-list" style="color: #9DACE4;"></i> 목록
    </a>
  </div>
  <hr/>
  <div class="row">
    <b>보낸사람</b>
    ${messageWithNickDto.messageSenderNick} (${messageWithNickDto.messageSender})
    <c:if test="${messageWithNickDto.getMessageSendTime() != null}">
      [<fmt:formatDate value="${messageWithNickDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/>]
    </c:if>
  </div>
  <div class="row">
    <b>받은사람</b>
    ${messageWithNickDto.messageRecipientNick} (${messageWithNickDto.messageRecipient})
    <c:if test="${messageWithNickDto.getMessageReadTime() != null}">
      [<fmt:formatDate value="${messageWithNickDto.getMessageReadTime()}" pattern="yyyy.MM.dd. H:m"/>]
    </c:if>
  </div>
  <hr/>
  <div class="row message-content">
    ${messageWithNickDto.getMessageContent()}
  </div>
  <hr/>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

</body>
</html>