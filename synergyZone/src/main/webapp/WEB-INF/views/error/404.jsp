<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<head>
<title>404</title>
</head>
<body>
	<div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
		<div>
			<img src="${pageContext.request.contextPath}/static/img/404.png" alt="404">
			<h2>페이지를 찾을 수 없습니다.</h2>
			<a class="btn btn-info btn-lg btn-block" href="${pageContext.request.contextPath}/">메인으로</a>
		</div>
	</div>
</body>
</html>
