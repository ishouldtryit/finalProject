<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
$(function () {
    const dpTime = function () {
        const now = new Date()
        let hours = now.getHours()
        let minutes = now.getMinutes()
        let seconds = now.getSeconds()
        let ampm = ''
        if (hours >= 12) {
            hours -= 12
            if (hours == 0) hours = 12
            ampm = '오후'
        } else {
            ampm = '오전'
        }
        if (hours < 10) {
            hours = '0' + hours
        }
        if (minutes < 10) {
            minutes = '0' + minutes
        }
        if (seconds < 10) {
            seconds = '0' + seconds
        }
        return ampm + hours + ":" + minutes + ":" + seconds;
    }

    const updateTimer = function () {
        var currentTime = dpTime();
        $("#timer").text(currentTime);
    };

    updateTimer();

    setInterval(function () {
        updateTimer();
    }, 1000);
});

    </script>

</head>
<body>
		<div>
			<label id="timer"></label>
		</div>
 		<div>
	           	출근시간: <label id="start-time">${w.startTime}</label><br>
	            퇴근시간: <label id="end-time">${w.endTime}</label> <br>
	            주간 근무시간: <label id="">0h:0m:0s</label> 
        	
        </div>

	
<form action="/commute/change" method="post">
		<c:choose>
			<c:when test="${empty w.startTime && empty w.endTime}">
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
	</form>
	
	<div>
		<h1>근태관리</h1>
    <ul>
        <li><a href="/commute/record">내 근태 현황</a></li>
        <li><a href="내_연차_내역_페이지_URL">내 연차 내역</a></li>
        <li><a href="내_인사정보_페이지_URL">내 인사정보</a></li>
    </ul>
	</div>
	
		<p class="mt-50 mb-50">
     		<h2>memberId=${sessionScope.empNo}</h2>
     		<h2>jobNo=${sessionScope.jobNo}</h2>
     		<span>
     		Copyright ©2023 SYNERGYZONE. All Rights Reserved.
     		</span>
     	</p>
</body>
</html>