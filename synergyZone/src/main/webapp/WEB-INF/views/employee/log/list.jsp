<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="row">
	<table>
		<thead>
			<tr>
				<th>시간</th>
				<th>이름(이메일)</th>
				<th>IP</th>
				<th>브라우저</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="loginRecordDto" items="${logs}">
				<tr>
					<td>${loginRecordDto.logLogin}</td>
					 <td>
		                <c:forEach var="employeeDto" items="${employees}">
		                    <c:if test="${loginRecordDto.empNo == employeeDto.empNo}">
		                        ${employeeDto.empName}
		                        (${employeeDto.empEmail})
		                    </c:if>
		                </c:forEach>
	            	 </td>
					<td>${loginRecordDto.logIp}</td>
					<td>${loginRecordDto.logBrowser}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>