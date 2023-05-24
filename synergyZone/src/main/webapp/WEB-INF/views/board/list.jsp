<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <title>Free Board List</title>
</head>
<body>
<h1>Free Board List</h1>
<hr>
<table align="center" cellpadding="5">
    <thead>
    <tr>
        <th width="50">No.</th>
        <th width="300">Title</th>
        <th width="100">Author</th>
        <th width="150">Created Date</th>
        <th width="80">Views</th>
    </tr>
    </thead>
    <tbody>
    
    <c:forEach items="${posts}" var="board">
        <tr>
            <td>${board.boardNo}</td>
            <td><a href="detail?boardNo=${board.boardNo}">${board.boardTitle}</a></td>
            <td>${board.boardWriter}</td>
            <td>${board.boardTime}</td>
            <td>${board.boardRead}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<br>
<div align="center">
    <a href="write" style="padding: 10px 20px; border: 1px solid #ccc;">새 글 쓰기</a>
</div>
</body>
</html>