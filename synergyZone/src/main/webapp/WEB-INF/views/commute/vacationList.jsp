<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
</head>
<body>
	<div class="container">
		<h3>신청내역</h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>이름</th>
					<th>부서명</th>
					<th>연차사용날짜</th>
					<th>휴가종류</th>
					<th>사용연차</th>
					<th>승인 상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="item">
					<tr class="modal-trigger" data-toggle="modal"
						data-target="#myModal">
						<td>${item.empName}</td>
						<td>${item.deptName}</td>
						<td>${item.startDate}~${item.endDate}</td>
						<td>${item.vacationName}</td>
						<td>${item.useCount}</td>
						<td><c:choose>
								<c:when test="${item.status == 0}">대기중</c:when>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 모달창 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myModalLabel">상세 정보</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
						<h1>연차 신청서</h1>
					<table class="">
							<tr>
								<th>기안자</th>
								<td>테스트모달</td>
							</tr>
							<tr>
								<th>기안 부서</th>
								<td>테스트모달</td>
							</tr>
							<tr>
								<th>기안일</th>
								<td>테스트모달</td>
							</tr>
					</table>
					<br><br>
					<table class="table">
							<tr>
								<th>휴가종류</th>
								<td>연차</td>
							</tr>
							<tr>
								<th>기간 일시</th>
								<td></td>
							</tr>
							<tr>
								<th>연차일수</th>
								<td>테스트모달</td>
							</tr>
							<tr>
								<th>휴가 사유</th>
								<td></td>
							</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script>
        
    </script>
</body>
</html>
