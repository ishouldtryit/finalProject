<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
 <script src="./datepicker/js/datepicker.js"></script> <!-- Air datepicker js -->
    <script src="./datepicker/js/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->
<script type="text/javascript">

$(document).ready(function() {
    $('#insertDate').submit(function() {
        if ($('#start_dtm').val() == '' || $('#end_dtm').val() =='' ) {
            alert('시작일,종료일을 선택해주세요  ');
            return false;
        }
    }); // end submit()
}); // end ready()

</script>

<%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>

<%-- 답글일 때는 정보가 한 개 더 전송되어야 한다(boardParent) --%>
<c:if test="${boardParent != null}">
<input type="hidden" name="boardParent" value="${boardParent}">
</c:if>

<div class="container">
<form action="insertDate" method="post" autocomplete="off" id ="insertDate">
   <!-- 제목 -->
   <div class="row center">
            <h2>일정 등록 </h2>
   </div>

    <div class="row p-3" >
         <label for="draftTitle" class="form-label">제목</label>
         <input type="text" id="title" name="title"  class="form-control">
       </div>

       <div class="row p-3">
         <label for="content" class="form-label" v-model="CalendarVO.content">내용</label>
         <textarea id="content" name="content" required style="min-height: 300px;" class="form-control"></textarea>
       </div>
          시작일    <input type="date"  id ="start_dtm" name="start_dtm" size="10"/>
          종료일    <input type="date"  id= "end_dtm" name="end_dtm" size="10"/>
       <div class="row mt-4">


   <div class="row">
      <button type="submit" class="btn btn-info w-80 mt-3 reply-insert-btn" >등록</button>
   </div>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>