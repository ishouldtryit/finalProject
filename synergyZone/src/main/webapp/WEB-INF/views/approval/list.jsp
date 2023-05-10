<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:forEach var="approvalDto" items="${list}">
	<div>
		번호:${approvalDto.draftNo}, 제목:${approvalDto.draftTitle}, 작성자:${approvalDto.drafterId} 
	</div>
	<hr>
</c:forEach>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>