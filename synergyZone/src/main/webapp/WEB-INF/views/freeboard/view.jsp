<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko-KR">
<head>
    <meta charset="UTF-8">
    <title>View Post</title>
</head>
<body>
<h1>${freeboard.freeTitle}</h1>
<p>Author: ${freeboard.writer}</p>
<p>Date: ${freeboard.regDate}</p>
<p>Views: ${freeboard.viewCount}</p>
<hr>
<p>${freeboard.content}</p>

<br>
<div align="center">
    <a href="/freeboard/delete/${freeboard.freeNo}" style="padding: 10px 20px; border: 1px solid red;">글 삭제</a>
</div>
</body>
</html>