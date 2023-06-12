<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	#img_2{
		width:550px;
	}
</style>

<div class="container">
	<div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="p-5 bg-light border border-2 rounded-3">
        <img src="/static/img/logo.png" id="img_2" class="mb-4">
        	<div class="text-center">
				<h3 class="text-center mt-4">비밀번호 변경이 완료되었습니다.</h3>
        	</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>