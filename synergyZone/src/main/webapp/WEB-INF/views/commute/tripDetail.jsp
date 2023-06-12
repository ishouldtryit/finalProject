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
 <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid">

         <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
             <i class="fa fa-bars"></i>
         </button>
         
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
             <ul class="nav navbar-nav ml-auto">
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/">홈</a>
                 </li>
                 <li class="nav-item active" >
                     <a class="nav-link" href="${pageContext.request.contextPath}/approval/write">신규 결재</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/approval/myList">나의 기안 문서함</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/approval/waitApproverList">결재 수신 문서함</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/approval/recipientList">참조 문서함</a>
                 </li> 
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/approval/readerList">열람 문서함</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>
	<form action="/commute/approval2" method="post">
		<div class="container">
			<div class="container-md border border-dark border-1 p-5 mb-3">
				<div class="row justify-content-center mb-2">
					<div class="col-auto">
						<h3>출장 신청서</h3>
					</div>

				</div>
				<div class="d-flex justify-content-between mt-5">
					<div>
						<table class="table">
							<tbody>
								<tr>
									<th class="table-secondary">기안자</th>
									<td>${list.empName}</td>
								</tr>
								<tr>
									<th class="table-secondary">기안부서</th>
									<td>${list.deptName}</td>
								</tr>
								<tr>
									<th class="table-secondary">기안일</th>
									<td>${list.usedDate}</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div>
						<table class="table mr-4">
							<tbody>
								<tr>
									<th class="table-secondary">승인</th>
									<td>${id.empName}</td>
								</tr>
								<tr>
									<th class="table-secondary">직급</th>
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
							<th class="table-secondary col-2">유형/구분</th>
							<td>${list.name}</td>
						</tr>
						<tr>
							<th class="table-secondary">대상자</th>
							<td><table class="table">
									<thead class="table-secondary">
										<tr>
											<th>부서</th>
											<th>직급</th>
											<th>이름</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${person}" var="item">
										<tr>
											<td>${item.deptName}</td>
											<td>${item.jobName}</td>
											<td>${item.empName}</td>
										</tr>
									</c:forEach>
									</tbody>
								</table></td>
						</tr>
						<tr>
							<th class="table-secondary">일시</th>
							<td>${list.startDate}~${list.endDate}</td>
						</tr>
						<tr>
							<th class="table-secondary">출발지</th>
							<td>${list.startPlace}</td>
						</tr>
						<tr>
							<th class="align-middle table-secondary">목적지</th>
							<td class="align-middle">${list.endPlace}</td>
						</tr>
						<tr>
							<th class="align-middle table-secondary">장소</th>
							<td class="align-middle">${list.place}</td>
						</tr>
						<tr>
							<th class="align-middle table-secondary">이동수단</th>
							<td class="align-middle">${list.work}</td>
						</tr>
						<tr>
							<th class="align-middle table-secondary">목적</th>
							<td class="align-middle">${list.purpose}</td>
						</tr>
						<tr>
							<th class="align-middle table-secondary">비고</th>
							<td class="align-middle">${list.notes}</td>
						</tr>
						
					</tbody>
				</table>
			</div>
			<div class="text-right">
				<input type="hidden" name="tripNo" value="${list.tripNo}">
				<button class="btn btn-info" id="N" type="submit" value="2"
					name="btn">반려</button>
				<button class="btn btn-" id="Y" type="submit" value="1" name="btn">결재</button>
			</div>
		</div>
	</form>
</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
