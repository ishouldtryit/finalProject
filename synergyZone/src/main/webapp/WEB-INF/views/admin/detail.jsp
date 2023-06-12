<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="row">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>프로필사진</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${employeeDto.empNo}</td>
				<td><img width="200" height="200" src="/attachment/download?attachmentNo=${profile.attachmentNo}"></td>
				<td><a href="edit?empNo=${employeeDto.empNo}">수정하기</a></td>
			</tr>
		</tbody>
	</table>
</div>
