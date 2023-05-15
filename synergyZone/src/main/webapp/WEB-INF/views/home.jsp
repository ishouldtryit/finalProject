<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
            const currentTime = dpTime();
            $("#timer").text(currentTime);

            //출근버튼 클릭시
            $("#start-btn").click(function(){
                const startTime = dpTime();  
                
                $("#start-time").text(startTime);
                $('#end-btn').prop('disabled', false);
                //폼에 데이터값 주기
    		    $(".startTime").attr("value", startTime);
            });

            //퇴근버튼 클릭시
            $("#end-btn").click(function(){
                const endTime = dpTime();  
                $("#end-time").text(endTime);
                $(".endTime").attr("value", endTime);
            });

 
            setInterval(function() {
                dpTime();
                var currentTime = dpTime();  
                $("#timer").text(currentTime);  
            }, 1000);
    });

    </script>

<h1>파이널 프로젝트에 오신것을 환영합니다.</h1>
<form action="/testuser1" method="post" >
	<button type="submit">testuser1</button>
</form>
<form action="/testuser2" method="post" >
	<button type="submit">testuser2</button>
</form>
<form action="/testuser3" method="post" >
	<button type="submit">testuser3</button>
</form>
<form action="/logout" method="post" >
	<button type="submit">로그아웃</button>
</form>

<div class="flex">
        <h5>근태관리</h5>
        <div>
            <label id="timer"></label>
        </div>
        
        <div>
	           	출근시간: <label id="start-time">${work.startTime}</label><br>
	            퇴근시간: <label id="end-time">${work.endTime}</label> <br>
	            주간 근무시간: <label id="">0h:0m:0s</label> 
        	
        </div>
        <div>
    	    <form action="/start" method="post" > 
    	    	<input class="startTime" type="hidden">
    	        <button type="submit" class="btn btn-primary btn-sm" id="start-btn">출근하기</button>
        	</form>
        	
        	<form action="/end" method="post">
        		<input class="endTime" type="hidden">
	            <button type="submit" class="btn btn-primary btn-sm" id="end-btn">퇴근하기</button>
        	</form>
        </div>
    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>