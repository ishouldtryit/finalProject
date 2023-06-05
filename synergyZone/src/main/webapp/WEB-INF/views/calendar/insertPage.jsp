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
function insertCalendar () {
        $.ajax({
            type: "POST",
            url: "/calander/insertDate",
            data:  {

            }
            contentType: "application/json",
            success: function() {
              alert("나만의 주소록에 추가되었습니다!");
            },
            error: function(xhr, status, error) {
            }
          });
}

</script>

<%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>

<%-- 답글일 때는 정보가 한 개 더 전송되어야 한다(boardParent) --%>
<c:if test="${boardParent != null}">
<input type="hidden" name="boardParent" value="${boardParent}">
</c:if>

<div class="container">

   <!-- 제목 -->
   <div class="row center">
      <c:choose>
         <c:when test="${boardParent == null}">
            <h2>일정 등록 </h2>
         </c:when>
         <c:otherwise>
            <h2>답글 작성</h2>
         </c:otherwise>
      </c:choose>
   </div>

    <div class="row p-3" >
         <label for="draftTitle" class="form-label">제목</label>
         <input type="text" id="draftTitle" name="boardTitle" v-model="boardlVO.boardDto.boardTitle" class="form-control" v-on:input="boardVO.boardDto.boardTitle = $event.target.value">
       </div>

       <div class="row p-3">
         <label for="draftContent" class="form-label">내용</label>
         <textarea id="draftContent" name="boardContent" required style="min-height: 300px;" v-model="boardVO.boardDto.boardContent" class="form-control" v-on:input="boardVO.boardDto.boardContent = $event.target.value"></textarea>
       </div>
              <input type="date" id="sdate" size="10"/>

       <div class="row mt-4">


   <div class="row">
      <button type="button" class="btn btn-info w-80 mt-3 reply-insert-btn" oncclick = "insertCalendar">등록</button>
   </div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>