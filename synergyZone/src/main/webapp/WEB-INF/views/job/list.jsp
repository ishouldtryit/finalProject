<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
	<table>
		<thead>
			<tr>
				<th>직위번호</th>
				<th>직위명</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="jobDto" items="${jobs}">
				<tr>
					<td>${jobDto.jobNo}</td>
					<td>${jobDto.jobName}</td>
					<td><a href="/employee/job/delete?jobNo=${jobDto.jobNo}">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>