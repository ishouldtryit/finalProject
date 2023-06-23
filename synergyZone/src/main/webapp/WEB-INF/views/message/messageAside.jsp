<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <!-- font-awesome CDN -->
   <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
       if (window.location.href.endsWith(contextPath+"/message/receive")) {
         $(".receive-store").addClass("back-dark-gray");
       } else if (window.location.href.endsWith(contextPath+"/message/send")) {
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
   
<section class="container py-4" style="margin-top: 10px;">
   <aside class="col-md-3 d-flex justify-content-start">
    
     <div class="row" style="margin-left:-33px">
       <div class="col reply-aside receive-store">
         <a href="${pageContext.request.contextPath}/message/receive" class="link d-flex align-items-center">
           <i class="fas fa-envelope mr-2" style="color: dodgerblue"></i>
           <span style="color:black" class="fw-bold">받은 쪽지함</span>
         </a>
       </div>
       <div class="col reply-aside send-store">
         <a href="${pageContext.request.contextPath}/message/send" class="link d-flex align-items-center">
           <i class="far fa-envelope mr-2" style="color: dodgerblue"></i>
           <span style="color:black" class="fw-bold">보낸 쪽지함</span>
         </a>
       </div>
     </div>
   </aside>
   
    
     
   </section>
   
     <!-- article -->
<article class="col-md-9">
       <!-- Content here -->
</article>
   