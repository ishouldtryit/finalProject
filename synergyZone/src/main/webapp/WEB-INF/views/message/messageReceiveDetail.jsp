<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
  const messageNo = parseInt("${messageWithNickDto.getMessageNo()}");
  const messageSender = "${messageWithNickDto.getMessageSender()}";
  const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/static/js/message/messageReceiveDetail.js"></script>
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
    <div>
      <h1>${messageWithNickDto.getMessageTitle()}</h1>
    </div>
    <hr/>
    <div class="row flex">
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
      <b>보낸사람</b> 
      ${messageWithNickDto.getMessageSenderNick()}(${messageWithNickDto.getMessageSender().length() < 5 ?messageWithNickDto.getMessageSender():messageWithNickDto.getMessageSender().substring(0,4).concat("*".repeat(messageWithNickDto.getMessageSender().length()-4))}) [<fmt:formatDate value="${messageWithNickDto.getMessageSendTime()}" pattern="yyyy.MM.dd. H:m"/>]
    </div>
    <div class="row">
      <b>받은사람</b> 
      ${messageWithNickDto.getMessageRecipientNick()}(${messageWithNickDto.getMessageRecipient()}) [<fmt:formatDate value="${messageWithNickDto.getMessageReadTime()}" pattern="yyyy.MM.dd. H:m"/>]
    </div>
    <hr/>
    <div class="row message-content" style="min-height: 200px;">
      ${messageWithNickDto.getMessageContent()}
    </div>
    <hr/>
  </article>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>