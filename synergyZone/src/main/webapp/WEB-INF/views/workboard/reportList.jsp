<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>supList 페이지</title>
</head>
<body>
    <h1>업무일지 목록</h1>
    <table>
        <tr>
            <th>업무 번호</th>
            <th>업무 담당자</th>
            <th>업무 일지 내용</th>
        </tr>
        <c:forEach var="report" items="${reportList}">
            <tr>
                <td>${report.workReportDto.workNo}</td>
                <td>${report.workReportDto.workSup}</td>
                <td>
                    <ul>
                        <c:forEach var="board" items="${report.workBoardList}">
                            <li>${board.workContent}</li>
                        </c:forEach>
                    </ul>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
