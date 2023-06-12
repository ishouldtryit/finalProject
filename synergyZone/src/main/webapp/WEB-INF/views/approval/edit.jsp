<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>수정을 해보자~</h1>

<form action="/approval/edit" method="post" >
<div>
	<span>제목</span>
	<input type="hidden" name="draftNo" value="${approvalDto.draftNo}">
	<input type="text" name="draftTitle" placeholder="제목" value="${approvalDto.draftTitle}">
</div>
<div>
	<span>내용</span>
	<textarea name="draftContent" required class="form-input w-100" style="min-height: 300px;">${approvalDto.draftContent}</textarea>
</div>

<div>
	<span>1차결재자: ${approvalDto.firstApprover}</span>
</div>

<button type="submit">등록</button>
</form>



