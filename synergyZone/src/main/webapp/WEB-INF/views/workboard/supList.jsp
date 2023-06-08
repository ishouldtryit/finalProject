<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Sup List</title>
</head>
<body>
    <h1>보고받은 업무일지 목록</h1>
    <table>
        <thead>
            <tr>
                <th>업무일지 번호</th>
                <th>담당자</th>
                <th>제목</th>
                <th>내용</th>
                <th>시작일</th>
                <th>마감일</th>
                <th>상태</th>
                <th>보고일자</th>
                <th>비밀 여부</th>
                <th>업무 유형</th>
                <th>담당자 이름</th>
                <th>부서 번호</th>
                <th>부서 이름</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="supWithWork" items="${supList}">
                <tr>
                    <td>${supWithWork.workNo}</td>
                    <td>${supWithWork.empNo}</td>
                    <td>${supWithWork.workTitle}</td>
                    <td>${supWithWork.workContent}</td>
                    <td>${supWithWork.workStart}</td>
                    <td>${supWithWork.workDeadline}</td>
                    <td>${supWithWork.workStatus}</td>
                    <td>${supWithWork.workReportDate}</td>
                    <td>${supWithWork.workSecret}</td>
                    <td>${supWithWork.workType}</td>
                    <td>${supWithWork.empName}</td>
                    <td>${supWithWork.deptNo}</td>
                    <td>${supWithWork.deptName}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
