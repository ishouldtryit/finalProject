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
				<th>전화번호</th>
				<th>프로필 사진</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="employeeDto" items="${employees}">
				<tr>
					<td>${employeeDto.empNo}</td>
					<td>${employeeDto.empName}</td>
					<td>${employeeDto.empEmail}</td>
					<td>${employeeDto.empPhone}</td>
<!-- 					<td> -->
<%-- 						<c:set var="attachmentNo" value="${employeeDto.attachmentNo}" /> --%>
<%-- 						<c:if test="${profileMap.containsKey(attachmentNo)}"> --%>
<%-- 							<img src="${profileMap[attachmentNo].body}" alt="Profile Image" width="100" height="100"> --%>
<%-- 						</c:if> --%>
<!-- 					</td> -->
					<td>
						<a href="detail?empNo=${employeeDto.empNo}">상세보기</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
