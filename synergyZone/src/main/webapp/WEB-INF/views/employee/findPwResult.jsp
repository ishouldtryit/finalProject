<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <style>
   .container-500 {
     margin-top: 100px;
   }
 </style>
<div class="container-500">
	<div class="row center">
<h2>임시비밀번호가 고객님의 이메일로 발송되었습니다.</h2>
<h2>로그인 후 원하는 비밀번호로 변경해주시기 바랍니다. </h2>
	</div>
<div class="row center">
<h2><a href="${pageContext.request.contextPath}/login">로그인 하러가기</a></h2>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>