<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>결재를 해보자~</h1>

<div>
	<span>제목</span>
	<input type="text" name="draftTitle" placeholder="제목">
</div>
<div>
	<span>내용</span>
	<textarea name="boardContent" required class="form-input w-100" style="min-height: 300px;"></textarea>
</div>





<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>