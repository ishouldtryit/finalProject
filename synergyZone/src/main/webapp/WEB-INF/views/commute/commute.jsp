<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:choose>
			<c:when test="${}">
				<button type="submit" class="" style="margin:2px" value="1" name="status">출근하기</button>
				<button type="submit" class="" style="margin:2px" value="2" name="status" disabled>퇴근하기</button>
			</c:when>
			<c:when test="${not empty w.startTime && empty w.endTime}">
				<button type="submit" class="" style="margin:2px" value="1" name="status" disabled>출근하기</button>
				<button type="submit" class="" style="margin:2px" value="2" name="status">퇴근하기</button>
			</c:when>
			<c:otherwise>
				<button type="submit" class="" style="margin:2px" value="1" name="status" disabled>출근하기</button>
				<button type="submit" class="" style="margin:2px" value="2" name="status" disabled>퇴근하기</button>
			</c:otherwise>
		</c:choose>
</body>
</html>