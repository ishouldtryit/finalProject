<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>프로필사진</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${employeeDto.empNo}</td>
				<td><img width="200" height="200" src="/attachment/download?empNo=${profile.empNo}"></td>
			</tr>
		</tbody>
	</table>
</div>
