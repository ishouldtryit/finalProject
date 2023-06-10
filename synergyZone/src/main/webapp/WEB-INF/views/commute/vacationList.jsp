<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-auto">
				<h3>신청내역</h3>
			</div>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>이름</th>
					<th>부서명</th>
					<th>연차사용날짜</th>
					<th>휴가종류</th>
					<th>사용연차</th>
					<th>승인 상태</th>
					<th>사용 날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="item">
					<tr class=""
						onclick="location.href='detail?vacationNo=${item.vacationNo}'">
						<td>${item.empName}</td>
						<td>${item.deptName}</td>
						<td>${item.startDate}~${item.endDate}</td>
						<td>${item.vacationName}</td>
						<td>${item.useCount}</td>
						<td><c:choose>
								<c:when test="${item.status == 0}">대기중</c:when>
							</c:choose></td>
						<td>${item.usedDate}</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>



	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script>
        
    </script>
</body>
</html>