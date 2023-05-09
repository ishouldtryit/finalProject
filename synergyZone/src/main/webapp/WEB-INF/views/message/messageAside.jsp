<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!-- font-awesome CDN -->
<link
  rel="stylesheet"
  type="text/css"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"
/>
<script type="text/template" id="receive-message-row">
  <hr class="mg-0"/>
  <div class="flex-row-grow message-row">
    <div class="flex-all-center message-check-column">
      <input class="message-check-one" type="checkbox"/>
    </div>
    <div>
      <a class="link message-sender-col">메세지 보낸 사람</a>
    </div>
    <a class="link message-title-col">메세지 제목</a>
    <a class="link message-send-time-col">메세지 보낸 시간</a>
  </div>
</script>
<script>
  $(function () {
    var href = window.location.href;
    if (window.location.href.endsWith("/message/receive")) {
      $(".receive-store").addClass("back-dark-gray");
    } else if (window.location.href.endsWith("/message/send")) {
      $(".send-store").addClass("back-dark-gray");
    }
  });
</script>
<style>
  .message-send-btn {
    text-align: center;
    text-decoration: none;
    box-shadow: 0 0 0 1px #5e78d3;
  }
  .reply-aside:hover {
    background-color: #e5e5e5;
  }
  .message-nav {
  }
</style>
<!-- section -->
<section class="container-1200 mt-50 mb-50">
  <aside class="message-nav">
    <div class="flex-row-grow">
      <a class="back-sc white-bold message-send-btn" href="${pageContext.request.contextPath}/message/write"
        >쪽지쓰기</a
      >
      <a
        class="back-sc white-bold message-send-btn"
        href="${pageContext.request.contextPath}/message/write?recipient=${sessionScope.memberId}"
        >내게쓰기</a
      >
    </div>
    <div class="row reply-aside receive-store">
      <a href="${pageContext.request.contextPath}/message/receive" class="link"
        ><i class="fa-solid fa-message" style="color: #9dace4"></i>
        &nbsp;받은쪽지함</a
      >
    </div>
    <div class="row reply-aside send-store">
      <a href="${pageContext.request.contextPath}/message/send" class="link"
        ><i class="fa-regular fa-message" style="color: #9dace4"></i>
        &nbsp;보낸쪽지함</a
      >
    </div>
  </aside>

  <!-- article -->
  <article class="container-1000 ps-30">