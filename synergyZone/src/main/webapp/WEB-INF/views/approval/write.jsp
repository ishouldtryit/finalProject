<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>결재를 해보자~</h1>
<form action="/approval/write" method="post" >
<div>
	<span>제목</span>
	<input type="text" name="draftTitle" placeholder="제목">
</div>
<div>
	<span>내용</span>
	<textarea name="draftContent" required class="form-input w-100" style="min-height: 300px;"></textarea>
</div>

<div>
	<span>1차결재</span>
	<input type="text" name="firstApprover" placeholder="1차결재">
</div>

<button type="submit">등록</button>
</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>