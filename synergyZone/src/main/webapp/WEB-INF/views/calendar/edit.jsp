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
<script type="text/javascript">
$(document).ready(function() {
    $('#insertDate').submit(function() {
        if ($('#start_dtm').val() == '' || $('#end_dtm').val() =='' ) {
            alert('시작일,종료일을 선택해주세요  ');
            return false;
        }
    }); // end submit()
    // 수정으로 들어왔으면 등록버튼 hide
   if('${result}'!= undefined  && '${result}'!=null && '${result}'!=''){
        $('#doinsert').hide();
      $("#insertDate").attr("action", "updateDate");

    } else {
     $("#insertDate").attr("action", "insertDate");
           $('#doupdate').hide();
    }
}); // end ready()
</script>

<%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>

<%-- 답글일 때는 정보가 한 개 더 전송되어야 한다(boardParent) --%>
<div class="container">
<form method="post" action="calendar/edit">
   <!-- 제목 -->
   <div class="row center">
            <h2>일정 수정</h2>
   </div>
   <input type="hidden" id="seq" name="seq" value="${result.seq}">
    <div class="row p-3" >
         <label for="draftTitle" class="form-label">제목</label>
         <input type="text" id="title" name="title"  value= "${result.title}" class="form-control">
       </div>

       <div class="row p-3">
         <label for="content" class="form-label" v-model="CalendarVO.content">내용</label>
         <textarea id="content" name="content" required style="min-height: 300px;" class="form-control"> ${result.content} </textarea>
       </div>
          시작일 <input type="date"  value= "${result.startDtm.substring(0, 10)}" id ="start_dtm" name="start_dtm" size="10"/>
		  종료일 <input type="date"  value= "${result.endDtm.substring(0, 10)}" id= "end_dtm" name="end_dtm" size="10"/>
       <div class="row mt-4">


   <div class="row">
      <button type="submit" class="btn btn-info w-80 mt-3 reply-insert-btn" id ="doinsert">등록</button>
       <button type="submit" class="btn btn-info w-80 mt-3 reply-insert-btn" id ="doupdate">수정</button>
   </div>
</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>