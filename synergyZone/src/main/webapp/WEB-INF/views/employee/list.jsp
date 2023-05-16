<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>이메일</th>
				<th>비밀번호</th>
				<th>전화번호</th>
				<th>입사일</th>
				<th>퇴사여부</th>
				<td>사업자번호</td>
				<th>직위번호</th>
				<th>부서번호</th>
				<th>형태코드</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="employeeDto" items="${employees}">
				<tr>
					<td>${employeeDto.empNo}</td>
					<td>${employeeDto.empName}</td>
					<td>${employeeDto.empEmail}</td>
					<td>${employeeDto.empPassword}</td>
					<td>${employeeDto.empPhone}</td>
					<td>${employeeDto.empHireDate}</td>
					<td>${employeeDto.isLeave}</td>
					<td>${employeeDto.cpNumber}</td>
					<td>${employeeDto.jobNo}</td>
					<td>${employeeDto.deptNo}</td>
					<td>${employeeDto.wtCode}</td>
					<td>
						<a href="delete?empNo=${employeeDto.empNo}">퇴사처리</a>
						<a href="detail?empNo=${employeeDto.empNo}">상세보기</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>