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
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    var empNo = "${sessionScope.empNo}";
  </script>
  <script src="${pageContext.request.contextPath}/static/js/message/messageReceive.js"></script>

  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

  <div class="mb-3">
    <h1>받은 쪽지함 
    <a class="deco-none message-not-read-cnt" href="${pageContext.request.contextPath}/message/receive?mode=new" style="color:#5E78D3">
    ${notReadCnt}</a>
      <c:if test="${param.mode != 'new'}">/<a class="deco-none message-receive-cnt" style="color:black" 
      href="${pageContext.request.contextPath}/message/receive"></a></c:if>
    </h1>
  </div>
  <div class="row flex">
    <div class="pocketmonTrade-btn message-delete-btn">
      <i class="fa-solid fa-xmark" style="color: red"></i> 삭제
    </div>
    <div class="pocketmonTrade-btn ml-auto message-refresh-btn">
      <i class="fa-solid fa-rotate-right" style="color: gray"></i> 새로고침
    </div>
  </div>
  <div class="row">
    <div class="flex-row-grow message-row message-head">
      <div class="flex-all-center message-check-column">
        <input class="message-check-all" type="checkbox" />
      </div>
      
      <div class="flex-align-center">보낸사람</div>
      <div class="flex-align-center">제목</div>
      <div class="flex-align-center">날짜</div>
    </div>
    <div class="target"></div>
  </div>
  <!-- 페이지네이션 -->
  <div class="mt-3 center pagination"></div>
  <!-- 검색창 -->
  <div class="row center">
    <form class="message-receive-search-form" action="/message/receive" method="get" autocomplete="off">
      <select name="column" class="form-select">
        <option class="column-option" value="message_title">제목</option>
        <option class="column-option" value="message_sender_nick">닉네임</option>
        <option class="column-option" value="message_sender">아이디</option>
        <option class="column-option" value="message_content">내용</option>
      </select>
      <input name="keyword" class="form-control" value="${param.keyword}" placeholder="검색" />
      <input name="item" type="hidden" value="${param.item}" />
      <input name="order" type="hidden" value="${param.order}" />
      <input name="special" type="hidden" value="${param.special}" />
      <button class="btn btn-primary">검색</button>
    </form>
  </div>
</div>


</body>
</html>
