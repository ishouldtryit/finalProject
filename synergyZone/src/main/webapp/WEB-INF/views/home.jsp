<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>파이널 프로젝트에 오신것을 환영합니다.</h1>
<form action="/testuser1" method="post" >
	<button type="submit">testuser1</button>
</form>
<form action="/testuser2" method="post" >
	<button type="submit">testuser2</button>
</form>
<form action="/testuser3" method="post" >
	<button type="submit">testuser3</button>
</form>
<a href="${pageContext.request.contextPath}/employee/login">로그인</a>
<a href="${pageContext.request.contextPath}/employee/logout">로그아웃</a>
<c:if test="${sessionScope.empNo != null}">
	<a href="${pageContext.request.contextPath}/employee/mypage">내 정보</a>
</c:if>
<form action="/logout" method="post" >
	<button type="submit">로그아웃</button>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>