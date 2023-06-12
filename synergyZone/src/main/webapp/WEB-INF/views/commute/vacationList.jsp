<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
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
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/commute/write">휴가신청 </a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/commute/trip">출장신청 </a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/commute/record">근무시간 집계현황</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/commute/vacation">내 휴가 신청내역</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/commute/tripList">내 출장 신청내역</a>
                 </li> 
             </ul>
         </div>
     </div>
 </nav>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-auto">
				<h3>신청내역</h3>
			</div>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="table-secondary">이름</th>
					<th class="table-secondary">부서명</th>
					<th class="table-secondary">연차사용날짜</th>
					<th class="table-secondary">휴가종류</th>
					<th class="table-secondary">사용연차</th>
					<th class="table-secondary">승인 상태</th>
					<th class="table-secondary">신청일</th>
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
								<c:when test="${item.status == 0}"><label class="badge bg-success">대기중</label></c:when>
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