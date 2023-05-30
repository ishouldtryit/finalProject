<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!doctype html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <title>자유게시판 List</title>
</head>
<body>
<h1>공지게시판 목록</h1>
<hr>
<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">글 번호</th>
      <th scope="col">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">작성일</th>
      <th scope="col">조회수</th>
    </tr>
  </thead>
    <tbody>
    <c:forEach items="${posts}" var="notice">
        <tr>
            <td>${notice.noticeNo}</td>
            <td><a href="detail?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</a></td>
            <td>${notice.noticeWriter}</td>
            <td>${notice.noticeTime}</td>
            <td>${notice.noticeRead}</td>
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