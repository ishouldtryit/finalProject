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
  
  <style>
.custom-pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
}

.custom-pagination a {
  display: inline-block;
  padding: 8px;
  margin: 0 5px;
  text-decoration: none;
  color: #333;
  border-radius: 4px;
  border: 1px solid #ccc;
}

.custom-pagination a i {
  margin-right: 5px;
}

.custom-pagination a.disabled {
  opacity: 0.6;
  pointer-events: none;
}

.custom-pagination a.on {
  background-color: #007bff;
  color: #fff;
  border-color: #007bff;
}

.custom-pagination a:hover {
  background-color: #eee;
}

.custom-pagination a:first-child,
.custom-pagination a:last-child {
  padding: 4px;
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
<div class="container">
     <h4>보낸 쪽지함 
       <a class="message-count" style="color:black" href="${pageContext.request.contextPath}/message/send"></a>
     </h4>
<jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

   <div class="message-header d-flex justify-content-between">
  <div class="d-flex mb-2">
    <button class="btn btn-outline-primary Trade-btn message-delete-btn me-2 ms-2">
      <i class="fas fa-times" style="color:red;"></i> 삭제
    </button>
    <button class="btn btn-outline-secondary action-btn ml-auto message-refresh-btn">
      <i class="fas fa-sync-alt custom-spin" style="color: gray;"></i> 새로고침
    </button>
  </div>
  <div class="d-flex mb-2 justify-content-end">
    <a class="btn btn-outline-info me-2" href="${pageContext.request.contextPath}/message/write">쪽지쓰기</a>
    <a class="btn btn-outline-info" href="${pageContext.request.contextPath}/message/write?recipient=${sessionScope.empNo}">내게쓰기</a>
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
        </tbody>
      </table>
    </div>

<!-- 페이지네이션 -->
<div class="mt-3 center pagination d-flex justify-content-center">
</div>


<!-- 검색창 -->
<div class="row center mt-3">
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


</body>
</html>