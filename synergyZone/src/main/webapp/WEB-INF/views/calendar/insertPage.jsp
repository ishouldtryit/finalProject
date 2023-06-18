<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid">

         <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
             <i class="fa fa-bars"></i>
         </button>
         
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
             <ul class="nav navbar-nav ml-auto">
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/">홈</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/calendar/calendar">일정</a>
                 </li>
                 
             </ul>
         </div>
     </div>
 </nav>
<!-- summernote cdn -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $('#insertDate').submit(function() {
        if ($('#start_dtm').val() == '' || $('#end_dtm').val() =='' ) {
            alert('시작일,종료일을 선택해주세요  ');
            return false;
        }
    }); // end submit()
    // 수정으로 들어왔으면 등록버튼 hide
}); // end ready()
</script>

<%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>

<div class="container">
<form  method="post" action="insertDate" id ="insertDate">
   <!-- 제목 -->
   <div class="row center">
            <h2>일정 등록 </h2>
   </div>
   <input type="hidden" id="seq" name="seq"  value= "${result.seq}">
    <div class="row p-3" >
         <label for="draftTitle" class="form-label">제목</label>
         <input type="text" id="title" name="title"  value= "${result.title}" class="form-control">
       </div>

       <div class="row p-3">
         <label for="content" class="form-label" >내용</label>
         <textarea id="content" name="content" required style="min-height: 300px;" class="form-control" > ${result.content} </textarea>
       </div>
          시작일    <input type="date"  value= "${result.startDtm}" id ="start_dtm" name="startDtm" size="10">
          종료일    <input type="date"  value= "${result.endDtm}" id= "end_dtm" name="endDtm" size="10">
       <div class="row mt-4">


   <div class="row">
      <button type="submit" class="btn btn-info w-80 mt-3 reply-insert-btn" id ="doinsert">등록</button>
   </div>
</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>