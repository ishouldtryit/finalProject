<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
     <script type="text/javascript">
        function getCurrentMonth() {
            var currentDate = new Date();
            var year = currentDate.getFullYear();
            var month = ("0" + (currentDate.getMonth() + 1)).slice(-2);
            var lastDay = new Date(year, currentDate.getMonth() + 1, 0).getDate();
            var monthString = year + "-" + month;
            var dateContainer = document.getElementById("dates");
            
            for (var day = 1; day <= lastDay; day++) {
                var date = monthString + "-" + ("0" + day).slice(-2);
                var dateElement = document.createElement("p");
                dateElement.textContent = date;
                dateContainer.appendChild(dateElement);
            }
        }
    </script>
</head>
<body onload="getCurrentMonth()">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>일자</th>
					<th>구분</th>
					<th>근무계획</th>
					<th>출근시간</th>
					<th>퇴근시간</th>
				</tr>
			</thead>
	<c:forEach var="list" items="${list}">
			<tbody>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td>${list.startTime}</td>
					<td>${list.endTime}</td>
				</tr>
	</c:forEach>
			</tbody>
		</table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>