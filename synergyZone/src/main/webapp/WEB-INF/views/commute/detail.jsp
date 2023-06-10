<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
</head>
<style>
.table-container {
	width: 100%;
	display: table;
}

.table-row {
	display: table-row;
}

.table-cell {
	display: table-cell;
	border: 1px solid black;
	padding: 8px;
}

.gray-header {
	background-color: gray;
	color: black;
}

.gray-header th {
	border: 1px solid black;
	border-collapse: collapse;
}

.gray-footer {
	background-color: gray;
	color: black;
}

.gray-footer td {
	border: 1px solid black;
	border-collapse: collapse;
}

.maximize-body {
	width: 100%;
}
</style>
</head>
<body>
	<form action="/commute/approval" method="post">
		<div class="container">
			<div class="row justify-content-center mb-2">
				<div class="col-auto">
					<h3>연차신청서</h3>
				</div>

			</div>
			<div class="d-flex justify-content-between mt-5">
				<div>
					<table class="table">
						<tbody>
							<tr>
								<th>기안자</th>
								<td>${list.empName}</td>
							</tr>
							<tr>
								<th>기안부서</th>
								<td>${list.deptName}</td>
							</tr>
							<tr>
								<th>기안일</th>
								<td>${list.usedDate}</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div>
					<table class="table mr-4">
						<tbody>
							<tr>
								<th>승인</th>
								<td>${id.empName}</td>
							</tr>
							<tr>
								<th>직급</th>
								<td>${job.jobName}</td>

							</tr>
						</tbody>
					</table>

				</div>
			</div>

			<br>
			<table class="table">
				<tbody>
					<tr>
						<th>휴가종류</th>
						<td>${list.vacationName}</td>
					</tr>
					<tr>
						<th>기간일시</th>
						<td><label class="form-label">${list.startDate}</label> ~ <label class="form-label">${list.endDate}</label></td>
					</tr>
					<tr>
						<th>반차여부</th>
						<td><c:choose>
								<c:when test="${list.leave == 0}">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="morningHalfDay" disabled> <label
											class="form-check-label" for="morningHalfDay">오전반차</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="afternoonHalfDay" disabled> <label
											class="form-check-label" for="afternoonHalfDay">오후반차</label>
									</div>
								</c:when>
								<c:when test="${list.leave == 1}">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="morningHalfDay" disabled checked> <label
											class="form-check-label" for="morningHalfDay">오전반차</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="afternoonHalfDay" disabled> <label
											class="form-check-label" for="afternoonHalfDay">오후반차</label>
									</div>
								</c:when>
								<c:when test="${list.leave == 2}">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="morningHalfDay" disabled> <label
											class="form-check-label" for="morningHalfDay">오전반차</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox"
											id="afternoonHalfDay" disabled checked> <label
											class="form-check-label" for="afternoonHalfDay">오후반차</label>
									</div>
								</c:when>
							</c:choose></td>
					</tr>
					<tr>
						<th>연차일수</th>
						<td><div class="ml-2">
						<label>잔여연차:15</label> <label class="ml-3">신청연차:${list.useCount}</label>
						</div></td>
					</tr>
					<tr>
						<th class="align-middle">휴가사유</th>
						<td class="align-middle">
							<div class="col-6">
								<input type="text" disabled="disabled" value="${list.reason}" class="form-control">
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="used" value="${list.useCount}"> <input
				type="hidden" name="empNo" value="${list.empNo}"> <input
				type="hidden" name="vacationNo" value="${list.vacationNo}">
			<button class="btn btn-primary" id="N" type="submit" value="1"
				name="btn">반려</button>
			<button class="btn btn-primary" id="Y" type="submit" value="2"
				name="btn">결재</button>
		</div>
	</form>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
