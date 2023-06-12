<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.icon-text {
	position: relative;
	display: inline-block;
}

.tooltip {
	position: absolute;
	top: -25px; /* 원하는 위치로 조정 */
	left: 50%;
	transform: translateX(-50%);
	background-color: #333;
	color: #fff;
	padding: 5px;
	border-radius: 3px;
	opacity: 0;
	transition: opacity 0.3s ease;
}

.icon-text:hover .tooltip {
	opacity: 1;
}
</style>
<head>
<title>근태기록 페이지</title>

</head>
<body>
	<div class="container">


		<h4 class="mb-4">근태기록 페이지</h4>

		<div class="mb-2">
			<button class="btn btn-outline-secondary me-2" onclick="decrementMonth()">&lt;</button>
			<!-- 이전 월로 이동하는 버튼 -->
			<strong><span id="year" required></span> <span>.</span> <span id="month"
				required></span></strong>
			<button class="btn btn-outline-secondary ms-2" onclick="incrementMonth()">&gt;</button>
			<!-- 다음 월로 이동하는 버튼 -->
		</div>
		<div id="attendanceTable"></div>
	</div>
	<script>
    $(function() {
        setYearMonth();
    });

    function setYearMonth() {
        var currentDate = new Date();
        var year = currentDate.getFullYear();
        var month = currentDate.getMonth() + 1;

        $("#year").text(year);
        $("#month").text(month);
        showAttendance();
    }

    function showAttendance() {
        var year = $("#year").text();
        var month = $("#month").text();

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

            tableHTML += "<tr><th colspan='4'>" + weekCount + "주차 </th></tr>";

            for (var date = weekStartDate; date <= weekEndDate; date.setDate(date.getDate() + 1)) {
                if (date >= startDate && date <= endDate) {
                    var formattedDate = formatDate(date);

                    var record = findRecord(formattedDate);

                    tableHTML += "<tr>" +
                        "<td>" + formattedDate + "</td>" +
                        "<td>" + (record && record.startTime !== '' ? record.startTime + "&nbsp;<span class='icon-text'><i class='fa-solid fa-user'><span class='tooltip'>" + "IP:" + record.startIp + "</span></span></i>" : "") + "</td>" +
                        "<td>" + (record && record.endTime !== '' ? record.endTime + "&nbsp;<span class='icon-text'><i class='fa-solid fa-user'><span class='tooltip'>" + "IP:" + record.endIp + "</span></span></i>" : "") + "</td>";


                    if (record && record.workTime !== 'null') {
                        var workTime = record.workTime;
                        if (workTime.startsWith('0 ')) {
                            workTime = workTime.slice(2);
                        }
                        var timeParts = workTime.split(':');
                        var hours = parseInt(timeParts[0]);
                        var minutes = parseInt(timeParts[1]);
                        var seconds = parseFloat(timeParts[2]);

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
        $("#attendanceTable").html(tableHTML);
    }

    function formatDate(date) {
        var year = date.getFullYear();
        var month = (date.getMonth() + 1).toString().padStart(2, '0');
        var day = date.getDate().toString().padStart(2, '0');

        return year + "-" + month + "-" + day;
    }

    function findRecord(date) {
        var list = "${list}";

        var parsedList = list
            .replace(/\[|\]/g, '')
            .split(/\), (?![^(]*\))/);

        var records = parsedList.map(function(item) {
            var parts = item.split(", ");

            var startTime = parts[1].split("=")[1];
            var endTime = parts[2].split("=")[1];
            var workTime = parts[3].split("=")[1];
            var workDate = parts[4].split("=")[1];
            var startIp = parts[5].split("=")[1];
            var endIp = parts[6].split("=")[1].replace(/[()]/g, '');

            if (endTime === 'null') {
                endTime = '';
            }

            return {
                "startTime": startTime,
                "endTime": endTime,
                "workTime": workTime,
                "workDate": workDate,
                "startIp": startIp,
                "endIp": endIp
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
        var yearSpan = $("#year");
        var monthSpan = $("#month");

        var year = parseInt(yearSpan.text());
        var month = parseInt(monthSpan.text());

        if (month === 1) {
            yearSpan.text(year - 1);
            monthSpan.text(12);
        } else {
            monthSpan.text(month - 1);
        }

        showAttendance();
    }

    function incrementMonth() {
        var yearSpan = $("#year");
        var monthSpan = $("#month");

        var year = parseInt(yearSpan.text());
        var month = parseInt(monthSpan.text());

        if (month === 12) {
            yearSpan.text(year + 1);
            monthSpan.text(1);
        } else {
            monthSpan.text(month + 1);
        }

        showAttendance();
    }
</script>


</body>
</html>