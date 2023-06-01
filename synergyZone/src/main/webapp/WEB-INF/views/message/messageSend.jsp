<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<html>
<head>
  <meta charset="UTF-8">
  
</head>
<body>

<script>
  var empNo = "${sessionScope.empNo}";
</script>
<script type="text/template" id="send-message-row">
  <hr class="mg-0"/>
  <div class="flex-row-grow message-row">
    <div class="flex-all-center message-check-column">
      <input class="message-check-one" type="checkbox"/>
    </div>
    <div>
      <a class="link message-recipient-col">받은사람</a>
    </div>
    <a class="link message-title-col">메세지 제목</a>
    <a class="link message-send-time-col">보낸시간</a>
    <a class="link message-read-time-col">받은시간</a>
    <div class="message-send-cancle-btn message-cancle-col">발송취소</div>
  </div>
</script>
<script src="${pageContext.request.contextPath}/static/js/message/messageSend.js"></script>

<!-- aside -->
<jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
<div class="container">

<div class="mb-30">
  <h1>보낸 쪽지함 <a class="deco-none message-send-cnt" style="color:black" href="${pageContext.request.contextPath}/message/send"></a></h1>
</div>

<div class="row flex">
  <div class="Trade-btn message-delete-btn">
    <i class="fas fa-times" style="color:red;"></i> 삭제
  </div>
  <div class="Trade-btn ml-auto message-refresh-btn">
    <i class="fas fa-sync-alt" style="color: gray;"></i> 새로고침
  </div>
</div>

<div class="row">
  <div class="flex-row-grow message-row message-head">
    <div class="flex-all-center message-check-column">
      <input class="message-check-all" type="checkbox">
    </div>
    <div class="flex-align-center">받은사람</div>
    <div class="flex-align-center">제목</div>
    <div class="flex-align-center">보낸시간</div>
    <div class="flex-align-center">읽은시간</div>
    <div class="flex-align-center message-cancle-col">발송취소</div>
  </div>
  <div class="target"></div>
</div>

<!-- 페이지네이션 -->
<div class="mt-50 center pagination"></div>

<!-- 검색창 -->
<div class="row center">
  <form class="message-send-search-form" action="/message/send" method="get" autocomplete="off">
    <select name="column" value="${param.column}" class="form-select">
      <option class="column-option" value="message_title">제목</option>
      <option class="column-option" value="message_recipient_nick">닉네임</option>
      <option class="column-option" value="message_recipient">아이디</option>
      <option class="column-option" value="message_content">내용</option>
    </select>
    <input name="keyword" class="form-control" value="${param.keyword}" placeholder="검색" />
    <button type="submit" class="btn btn-primary">검색</button>
  </form>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

</body>
</html>
