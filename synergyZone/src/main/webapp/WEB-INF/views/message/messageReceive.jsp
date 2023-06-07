<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    .message-sender-col {
      color: black;
    }
    .message-title-col{
      color: black;
    }
    .message-send-time-col{
      color: black;
    }
    
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    var empNo = "${sessionScope.empNo}";
  </script>
  <script src="${pageContext.request.contextPath}/static/js/message/messageReceive.js"></script>
 
  <script id="receive-message-row" type="text/html">
    <tr>
      <td>
        <div class="form-check">
          <input class="form-check-input message-check-one" type="checkbox" value="">
        </div>
      </td>
      <td>
        <a class="message-sender-col" href=""></a>
      </td>
      <td>
        <a class="message-title-col" href=""></a>
      </td>
      <td>
        <a class="message-send-time-col" href=""></a>
      </td>
    </tr>
  </script>
  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
  


 <div class="container">
    <div class="message-header">
	  <h5>받은 쪽지함 
        <a class="message-count"  href="${pageContext.request.contextPath}/message/receive?mode=new">(${notReadCnt})</a>
	  </h5>
	  <div class="row flex">
	    <div class="Trade-btn message-delete-btn">
	      <i class="fas fa-times" style="color:red;"></i> 삭제
	    </div>
			<div class="action-btn ml-auto message-refresh-btn">
			  <i class="fas fa-sync-alt custom-spin" style="color: gray;"></i> 새로고침
			</div>

	  </div>
	</div>
	
    <div class="table-responsive">
      <table class="table table-striped">
        <thead>
          <tr>
            <th scope="col">
              <div class="form-check">
                <input class="form-check-input message-check-all" type="checkbox">
              </div>
            </th>
            <th scope="col">보낸사람</th>
            <th scope="col">제목</th>
            <th scope="col">날짜</th>
          </tr>
        </thead>
        <tbody class="target">
        </tbody>
      </table>
    </div>
  
  <!-- 페이지네이션 -->
  <div class="mt-3 center pagination"></div>
  
  <!-- 검색창 -->
 <div class="row center">
  <form class="message-receive-search-form" action="/message/receive" method="get" autocomplete="off">
      <div class="input-group">
        <select name="column" class="form-select">
          <option class="column-option" value="message_title">제목</option>
          <option class="column-option" value="message_sender_nick">닉네임</option>
          <option class="column-option" value="message_sender">아이디</option>
          <option class="column-option" value="message_content">내용</option>
        </select>
        <input name="keyword" class="form-control search-input" value="${param.keyword}" placeholder="검색" />
        <input name="item" type="hidden" value="${param.item}" />
        <input name="order" type="hidden" value="${param.order}" />
        <input name="special" type="hidden" value="${param.special}" />
        <button class="btn btn-primary">검색</button>
      </div>
    </form>
	</div>


</div>


</body>

</html>