<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>

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
    <h1>근태기록 페이지</h1>

    <label for="year">년도:</label>
    <input type="number" id="year" min="2000" max="2100" value="" required>
    <label for="month">월:</label>
    <input type="number" id="month" min="1" max="12" value="" required>
    <button onclick="showAttendance()">조회</button>

    <div id="attendanceTable"></div>

    <script>
        function showAttendance() {
            var year = document.getElementById("year").value;
            var month = document.getElementById("month").value;

            var startDate = new Date(year, month - 1, 1);
            var endDate = new Date(year, month, 0);

            var tableHTML = "<table>" +
                "<tr>" +
                "<th>일자</th>" +
                "<th>출근시간</th>" +
                "<th>퇴근시간</th>" +
                "<th>근무시간</th>" +
                "</tr>";

            var weekCount = 1;
            var weekStartDate = new Date(startDate);
            weekStartDate.setDate(startDate.getDate() - startDate.getDay());  // Adjust to the previous Sunday

            while (weekStartDate < endDate) {
                var weekEndDate = new Date(weekStartDate);
                weekEndDate.setDate(weekStartDate.getDate() + 6);  // Adjust to the next Saturday

                tableHTML += "<tr><th colspan='4'>Week " + weekCount + "</th></tr>";

                for (var date = weekStartDate; date <= weekEndDate; date.setDate(date.getDate() + 1)) {
                    if (date >= startDate && date <= endDate) {
                        var formattedDate = formatDate(date);

                        // Find corresponding record for the date
                        var record = findRecord(formattedDate);

                        tableHTML += "<tr>" +
                            "<td>" + formattedDate + "</td>" +
                            "<td>" + (record ? record.startTime : "") + "</td>" +
                            "<td>" + (record ? record.endTime : "") + "</td>" +
                            "<td>" + (record ? record.workTime : "") + "</td>" +
                            "</tr>";
                    }
                }

                weekCount++;
                weekStartDate.setDate(weekEndDate.getDate() + 1);  // Adjust to the next Sunday
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



        
    </script>
</body>
</html>