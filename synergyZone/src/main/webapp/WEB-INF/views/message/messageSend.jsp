<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<html>
<head>
  <meta charset="UTF-8">
    <style>
    a {
      color: black;
    }
  </style>
</head>
<body>

<script>
  var empNo = "${sessionScope.empNo}";
</script>
  
<script type="text/html" id="send-message-row">
	 <tr>
      <td>
        <div class="form-check">
          <input class="form-check-input message-check-one" type="checkbox" value="">
        </div>
      </td>
      <td>
        <a class="message-recipient-col" href=""></a>
      </td>
      <td>
        <a class="message-title-col" href=""></a>
      </td>
      <td>
        <a class="message-send-time-col" href=""></a>
      </td>

      <td>
        <a class="message-read-time-col" href=""></a>
      </td>
      <td>
           <a class="message-send-cancle-btn message-cancle-col" href=""></a>
      </td>
    </tr>
</script>

<script src="${pageContext.request.contextPath}/static/js/message/messageSend.js"></script>

<!-- aside -->
<jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
<div class="container">

	<div class="message-header">
	  <h5>보낸 쪽지함 
	    <a class="message-count" style="color:black" href="${pageContext.request.contextPath}/message/send"></a>
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
      <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col">
              <div class="form-check">
                <input class="form-check-input message-check-all" type="checkbox">
              </div>
            </th>
            <th scope="col">받은사람</th>
            <th scope="col">제목</th>
            <th scope="col">보낸시간</th>
            <th scope="col">읽은시간</th>
            <th class="flex-align-center message-cancle-col">발송취소</th>
          </tr>
        </thead>
        <tbody class="target">
            <tr>
              <td>
                <div class="form-check">
                  <input class="form-check-input message-check-one" type="checkbox" value="">
                </div>
              </td>
              <td>
                <a class="message-recipient-col" href="" style="color: black;"></a>
              </td>
              <td>
                <a class="message-title-col" href=""></a>
              </td>
              <td>
                <a class="message-send-time-col" href=""></a>
              </td>
              <td>
                <a class="message-read-time-col" href=""></a>
              </td>
              <td>
                <a class="message-send-cancle-btn message-cancle-col" href=""></a>
              </td>
            </tr>
        </tbody>
      </table>
    </div>

<!-- 페이지네이션 -->
<div class="mt-0 mb-1 center pagination d-flex justify-content-center"></div>


<!-- 검색창 -->
<div class="row center">
  <form class="message-send-search-form" action="/message/send" method="get" autocomplete="off">
    <div class="input-group" style="width: 33%; margin: auto;">
      <select name="column"  class="form-select form-select-sm" style="width: 20%; height: 100%;">
        <option class="column-option" value="message_title">제목</option>
        <option class="column-option" value="message_recipient_nick">이름</option>
        <option class="column-option" value="message_recipient">사번</option>
        <option class="column-option" value="message_content">내용</option>
      </select>
      <input name="keyword" class="form-control form-control-sm" value="${param.keyword}" placeholder="검색" style="width: 60%; height: 100%;" />
      <input name="item" type="hidden" value="${param.item}" />
        <input name="order" type="hidden" value="${param.order}" />
        <input name="special" type="hidden" value="${param.special}" />
      <button class="btn btn-info btn-sm" style="width: 20%; height: 100%;">검색</button>
    </div>
  </form>
</div>





</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


</body>
</html>
