<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
	<div class="container">
		<div class="row justify-content-center">
			<h1>연차신청서</h1>
		</div>
		<div class="d-flex justify-content-between">
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
				<table class="table">
					<tbody>
						<tr>
							<th>승인</th>
							<td></td>
						</tr>
						<tr>
							<th>직급</th>
							<td></td>
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
					<td>${list.startDate} ~ ${list.endDate}</td>
				</tr>
				<tr>
					<th>반차여부</th>
					<td>
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
					</td>
				</tr>
				<tr>
					<th>연차일수</th>
					<td>잔여연차: 15 신청연차:${list.useCount}</td>
				</tr>
				<tr>
					<th class="align-middle">휴가사유</th>
					<td class="align-middle">
						<div class="">
							<input type="text" disabled="disabled" value="${list.reason}">
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<button class="btn btn-primary">반려</button> <button class="btn btn-primary">결재</button>
	</div>

</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
