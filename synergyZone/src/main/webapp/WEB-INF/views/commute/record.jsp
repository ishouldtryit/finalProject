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
     <script>
            function generateMonthList(year, month) {
                var startDate = new Date(year, month - 1, 1); // 주어진 년도와 월의 첫 번째 날짜
                var endDate = new Date(year, month, 0); // 주어진 년도와 월의 마지막 날짜

                var monthList = [];

                // 날짜 목록 생성
                for (var date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
                    var formattedDate = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
                    var formattedDay = getDayOfWeek(date.getDay());
                    monthList.push(formattedDate + " (" + formattedDay + ")");
                }

                return monthList;
                }

                // 요일을 가져오는 함수
                function getDayOfWeek(day) {
                var daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
                return daysOfWeek[day];
            }

            var year = 2023;
            var month = 6;

            var monthList = generateMonthList(year, month);
            window.onload = function () {
            var datesElement = document.getElementById("dates");

            // monthList를 datesElement에 출력
            for (var i = 0; i < monthList.length; i++) {
                var dateText = document.createTextNode(monthList[i]);
                var brElement = document.createElement("br");
                datesElement.appendChild(dateText);
                datesElement.appendChild(brElement);
            }
        };

        </script>
    </head>
    <body>
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
            <tbody>                
                <tr>
                    <td id="dates"></td>
                    <c:forEach var="list" items="${list}" varStatus="status">
                        <td></td>
                        <td></td>
                        <td>${list.startTime}</td>
                        <td>${list.endTime}</td>
                    </c:forEach>
                    </tr>
            </tbody>
        </table>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
