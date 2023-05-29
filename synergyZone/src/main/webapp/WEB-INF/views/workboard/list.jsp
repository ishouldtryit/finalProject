<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<table>
		<thead>
			<tr>
				<th>보고일</th>
				<th>보고서</th>
				<th>제목</th>
				<th>보고자</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="workBoardDto" items="${list}">
				<tr>
					<td>${workBoardDto.workReportDate}</td>
					<td>${workBoardDto.workType}</td>
					<td>${workBoardDto.workTitle}</td>
					 <td>
		                <c:forEach var="employeeDto" items="${employees}">
		                    <c:if test="${employeeDto.empNo == workBoardDto.empNo}">
		                        ${employeeDto.empName}
		                    </c:if>
		                </c:forEach>
		            </td>
		            <td><a href="detail?workNo=${workBoardDto.workNo}">상세보기</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
