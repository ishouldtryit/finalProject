<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>파이널 프로젝트에 오신것을 환영합니다.</h1>
<form action="/testuser1" method="post" >
	<input type="hidden" name="memberId" value="testuser1">
	<input type="hidden" name="jobNo" value="99">
	<button type="submit">testuser1</button>
</form>
<form action="/testuser2" method="post" >
	<input type="hidden" name="memberId" value="testuser1">
	<input type="hidden" name="jobNo" value="99">
	<button type="submit">testuser2</button>
</form>
<form action="/testuser3" method="post" >
	<input type="hidden" name="memberId" value="testuser1">
	<input type="hidden" name="jobNo" value="99">
	<button type="submit">testuser3</button>
</form>
<form action="/logout" method="post" >
	<button type="submit">로그아웃</button>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>