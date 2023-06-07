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
.textarea-container {
	position: relative;
}

.textarea-container textarea {
	width: 100%;
	resize: none;
	position: absolute;
	top: 0;
	left: 0;
}

th {
	background-color: lightgray;
	padding: 0;
}

th, td {
	padding: /* 적절한 패딩 값을 지정해주세요 */
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
							<td>마장웅</td>
						</tr>
						<tr>
							<th>기안부서</th>
							<td>영업부서</td>
						</tr>
						<tr>
							<th>기안일</th>
							<td>2023-05-12</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
				<div class="d-flex">
					<table class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th scope="col">신청</th>
							</tr>
						</thead>
						<tbody class="table-primary">
							<tr>
								<td>마장웅</td>
							</tr>
						</tbody>
						<tfoot class="thead-light">
							<tr>
								<td>2023-05-12</td>
							</tr>
						</tfoot>
					</table>
					<table class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th scope="col">승인</th>
							</tr>
						</thead>
						<tbody class="table-primary">
							<tr>
								<td>김상후</td>
							</tr>
						</tbody>
						<tfoot class="thead-light">
							<tr>
								<td></td>
							</tr>
						</tfoot>
					</table>
				</div>

			</div>
		</div>

		<br> <br>
		<table class="table">
			<tbody>
				<tr>
					<th>휴가종류</th>
					<td>연차</td>
				</tr>
				<tr>
					<th>기간일시</th>
					<td>2023-05-12 ~ 2023-05-30</td>
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
					<td>잔여연차: 15 신청연차:5</td>
				</tr>
				<tr class="mt-3">
					<th class="align-middle">휴가사유</th>
					<td class="align-middle">
						<div class="textarea-container">
							<textarea rows="4" class="form-control" disabled="disabled">집가고싶어</textarea>
						</div>
					</td>
				</tr>

			</tbody>
		</table>

	</div>

</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
