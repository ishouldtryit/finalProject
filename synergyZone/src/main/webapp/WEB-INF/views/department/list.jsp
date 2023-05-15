<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
	<table>
		<thead>
			<tr>
				<th>부서번호</th>
				<th>부서이름</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="departmentDto" items="${departments}">
				<tr>
					<td>${departmentDto.deptNo}</td>
					<td>${departmentDto.deptName}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>