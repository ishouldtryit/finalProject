<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
				 <td>
                <c:forEach var="departmentDto" items="${departments}">
                    <c:if test="${departmentDto.deptNo == employeeDto.deptNo}">
                        ${departmentDto.deptName}
                    </c:if>
                </c:forEach>
            </td>
            <td>
                <c:forEach var="jobDto" items="${jobs}">
                    <c:if test="${jobDto.jobNo == employeeDto.jobNo}">
                        ${jobDto.jobName}
                    </c:if>
                </c:forEach>
            </td>
					<td>${employeeDto.wtCode}</td>
					<td>
						<a href="exit?empNo=${employeeDto.empNo}">퇴사처리</a>
						<a href="detail?empNo=${employeeDto.empNo}">상세보기</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
