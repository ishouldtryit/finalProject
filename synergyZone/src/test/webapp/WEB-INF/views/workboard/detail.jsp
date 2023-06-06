<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="row">
    <table>
        <thead>
            <tr>
                <th>제목</th>
                <th>작성자</th>
                <th>첨부파일</th>
                <th>보고일</th>
                <th>글 내용</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>${workBoardDto.workTitle}</td>
                <td>
                   <c:forEach var="employeeDto" items="${employees}">
                      <c:if test="${employeeDto.empNo == workBoardDto.empNo}">
                         ${employeeDto.empName}
                      </c:if>
                   </c:forEach>
                </td>
                <td>
		            <c:forEach var="file" items="${files}">
					    <a href="/attachment/download?attachmentNo=${file.attachmentNo}">${file.attachmentNo}</a>                
					</c:forEach>
				</td>
                <td>${workBoardDto.workReportDate}</td>
                <td>${workBoardDto.workContent}</td>
                <td><a href="edit?workNo=${workBoardDto.workNo}">수정하기</a></td>
            </tr>
        </tbody>
    </table>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
