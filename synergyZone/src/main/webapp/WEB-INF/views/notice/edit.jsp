<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=noticeContent]').summernote({
            placeholder: '내용 작성',
            tabsize: 4,//탭키를 누르면 띄어쓰기 몇 번 할지
            height: 250,//최초 표시될 높이(px)
            toolbar: [//메뉴 설정
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
            ]
        });
    });
</script>

<form action="edit" method="post">
<input type="hidden" name="noticeNo" value="${noticeDto.noticeNo}">

<div class="container">

	<!-- 제목 -->
	<div class="row center">
		<h2>${noticeDto.noticeNo}번 게시글 수정</h2>
	</div>
	 <div class="row p-3" >
	      <label for="draftTitle" class="form-label">제목</label>
	      <input type="text" id="draftTitle" name="noticeTitle" v-model="noticelVO.noticeDto.noticeTitle" class="form-control" v-on:input="noticeVO.noticeDto.noticeTitle = $event.target.value">
	    </div>
	    <div class="row p-3">
	      <label for="draftContent" class="form-label">내용</label>
	      <textarea id="draftContent" name="noticeContent" required style="min-height: 300px;" v-model="noticeVO.noticeDto.noticeContent" class="form-control" v-on:input="noticeVO.noticeDto.noticeContent = $event.target.value"></textarea>
	    </div>
	<div class="row">
		<button type="submit" class="btn btn-info w-80 mt-3 noticeReply-insert-btn">변경</button>
	</div>
</div>
 
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>