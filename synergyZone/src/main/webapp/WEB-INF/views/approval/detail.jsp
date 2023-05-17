<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>상세페이지</h1>

<div>제목 : ${approvalDto.draftTitle}</div>
<div>내용 : ${approvalDto.draftContent}</div>
<div>작성자 : ${approvalDto.drafterId}</div>
<div>결재자 : ${approvalDto.firstApprover}</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>