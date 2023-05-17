<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <head>
 	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
 </head>


<div class="container-500">
	<div class="row center">
		<h1>사원 정보 변경</h1>
	</div>
	<div class="row">
		<form action="edit" method="post" class="edit_form">
			<input type="hidden" name="empNo" value="${employeeDto.empNo}">
			<table class="table center ms-20">
			<colgroup>
				<col style="width: 30%;">
           		<col style="width: 70%;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">이름</th>
					<td scope="col">
						<input type="text" name="empName" value="${employeeDto.empName}">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="empPhone" value="${employeeDto.empPhone}">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="empEmail" value="${employeeDto.empEmail}">
					</td>
				</tr>
				<tr>
					<th>입사일</th>
					<td>
						<input type="date" name="empHireDate" value="${employeeDto.empHireDate}">
					</td>
				</tr>
				<tr>
				<th>등급<th>
					<td>
					<c:choose>
						<c:when test="${employeeDto.adminCk == 0 }">
							<select name="adminCk" >
								<option value=1>관리자</option>
								<option value=0 selected>일반회원</option>
							</select>
						</c:when>
						
						<c:when test="${employeeDto.adminCk == 1 }">
							<select name="adminCk" >
								<option value=1 selected>관리자</option>
								<option value=0>일반회원</option>
							</select>
						</c:when>
					</c:choose>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="memberPost" value="${employeeDto.empPostcode }">
						<input type="text" name="memberBasicAddr" value="${employeeDto.empAddress }">
						<input type="text" name="memberDetailAddr" value="${employeeDto.empDetailAddress }">
					</td>
				</tr>
			</tbody>
			</table>
			<div class="row right">
				<button class="edit-btn">수정</button>
				<a class="link" href="${pageContext.request.contextPath}/admin/member/list">목록</a>
			</div>
			</form>
		</div>

</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

