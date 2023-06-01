<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<head>
    <title>근태기록 페이지</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>근태기록 페이지</h1>

        <div>
            <button onclick="decrementMonth()">&lt;</button> <!-- 이전 월로 이동하는 버튼 -->
	        <span id="year" required></span>
	        <span>.</span>
            <span id="month" required></span>
            <button onclick="incrementMonth()">&gt;</button> <!-- 다음 월로 이동하는 버튼 -->
        </div>
        <div id="attendanceTable"></div>
    </div>
    <script>
        // 페이지 로딩 시 현재 년도와 달을 입력란에 넣는 함수
        function setYearMonth() {
            var currentDate = new Date();
            var year = currentDate.getFullYear();
            var month = currentDate.getMonth() + 1;

            document.getElementById("year").textContent = year;
            document.getElementById("month").textContent = month;
            showAttendance(); // 조회 버튼 실행
        }

        // 페이지 로딩이 완료되면 setYearMonth 함수 호출
        window.onload = setYearMonth;

        function showAttendance() {
            var year = document.getElementById("year").textContent;
            var month = document.getElementById("month").textContent;

            var startDate = new Date(year, month - 1, 1);
            var endDate = new Date(year, month, 0);

            var tableHTML = "<table class='table table-hover'>" +
                "<tr>" +
                "<th>일자</th>" +
                "<th>출근시간</th>" +
                "<th>퇴근시간</th>" +
                "<th>근무시간</th>" +
                "</tr>";

            var weekCount = 1;
            var weekStartDate = new Date(startDate);
            weekStartDate.setDate(startDate.getDate() - (startDate.getDay() + 1) % 7);

            while (weekStartDate <= endDate) {
                var weekEndDate = new Date(weekStartDate);
                weekEndDate.setDate(weekStartDate.getDate() + 6);

                tableHTML += "<tr><th colspan='4'>Week " + weekCount + "</th></tr>";

                for (var date = weekStartDate; date <= weekEndDate; date.setDate(date.getDate() + 1)) {
                    if (date >= startDate && date <= endDate) {
                        var formattedDate = formatDate(date);

                        var record = findRecord(formattedDate);

                        tableHTML += "<tr>" +
                            "<td>" + formattedDate + "</td>" +
                            "<td>" + (record ? record.startTime : "") + "</td>" +
                            "<td>" + (record ? record.endTime : "") + "</td>";

                        // 근무시간 처리
                        if (record && record.workTime !== 'null') {
                            var workTime = record.workTime;
                            if (workTime.startsWith('0 ')) {
                                workTime = workTime.slice(2);  // 맨 앞의 0 제거
                            }
                            var timeParts = workTime.split(':');
                            var hours = parseInt(timeParts[0]);
                            var minutes = parseInt(timeParts[1]);
                            var seconds = parseFloat(timeParts[2]);

                            // 시, 분, 초를 형식에 맞게 조합
                            var formattedWorkTime = '';
                            if (hours >= 0) {
                                formattedWorkTime += hours + 'h ';
                            }
                            if (minutes >= 0) {
                                formattedWorkTime += minutes + 'm ';
                            }
                            formattedWorkTime += seconds + 's';

                            tableHTML += "<td>" + formattedWorkTime + "</td>";
                        } else {
                            tableHTML += "<td></td>";
                        }

                        tableHTML += "</tr>";
                    }
                }

                weekCount++;
                weekStartDate.setDate(weekEndDate.getDate() + 1);
            }

            tableHTML += "</table>";
            document.getElementById("attendanceTable").innerHTML = tableHTML;
        }



        function formatDate(date) {
            var year = date.getFullYear();
            var month = (date.getMonth() + 1).toString().padStart(2, '0');
            var day = date.getDate().toString().padStart(2, '0');

            return year + "-" + month + "-" + day;
        }

        function findRecord(date) {
            var list = "${list}";

            // 문자열 파싱
            var parsedList = list
                .replace(/\[|\]/g, '')  // 대괄호 제거
                .split(/\), (?![^(]*\))/);  // 개별 객체 분리

            var records = parsedList.map(function(item) {
                var parts = item.split(", ");  // 속성 분리

                var startTime = parts[1].split("=")[1];
                var endTime = parts[2].split("=")[1];
                var workTime = parts[3].split("=")[1];
                var workDate = parts[4].split("=")[1].replace(/[()]/g, '');  // 괄호 제거

                // endTime이 null인 경우 빈 문자열로 설정
                if (endTime === 'null') {
                    endTime = '';
                }

                return {
                    "startTime": startTime,
                    "endTime": endTime,
                    "workTime": workTime,
                    "workDate": workDate
                };
            });

            for (var i = 0; i < records.length; i++) {
                if (records[i].workDate === date) {
                    return records[i];
                }
            }

            return null;
        }

        function decrementMonth() {
            var yearSpan = document.getElementById("year");
            var monthSpan = document.getElementById("month");

            var year = parseInt(yearSpan.textContent);
            var month = parseInt(monthSpan.textContent);

            if (month === 1) {
                yearSpan.textContent = year - 1;
                monthSpan.textContent = 12;
            } else {
                monthSpan.textContent = month - 1;
            }

            showAttendance();
        }

        function incrementMonth() {
            var yearSpan = document.getElementById("year");
            var monthSpan = document.getElementById("month");

            var year = parseInt(yearSpan.textContent);
            var month = parseInt(monthSpan.textContent);

            if (month === 12) {
                yearSpan.textContent = year + 1;
                monthSpan.textContent = 1;
            } else {
                monthSpan.textContent = month + 1;
            }

            showAttendance();
        }
    </script>
</body>
</html>
