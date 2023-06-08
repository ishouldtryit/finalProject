<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="row">
	<table>
		<thead>
			<tr>
				<th>부서번호</th>
				<th>부서명</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="departmentDto" items="${departments}">
				<tr>
					<td>${departmentDto.deptNo}</td>
					<td>${departmentDto.deptName}</td>
					<td><a href="/employee/department/delete?deptNo=${departmentDto.deptNo}">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>