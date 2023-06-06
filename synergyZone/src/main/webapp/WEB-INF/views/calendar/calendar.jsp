<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>

<meta charset='utf-8' />
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src='../dist/index.global.js'></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>
<script>
 let events = [];
<c:forEach items="${result}" var="item">
              events.push({
                  title: '${item.TITLE}',
                  start: '${item.START_DTM}',
                  constraint: 'availableForMeeting',
                  end: '${item.END_DTM}',
                  color: '#85d0ed'
                });
</c:forEach>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
      },
      buttonText : {
      	today : "오늘",
      	dayGridMonth : "월간",
      	week : "주간",
      	day : "일간",
      	list : "목록"
      },
    navLinks: true,
    // 업무 시간 표시
    businessHours: true,
    // 편집 가능한 일정
    editable: true,
    // 선택 가능한 일정
    selectable: true,
      events : events
    });
    locale: 'ko' // 'ko'는 한국어를 의미합니다.,

    calendar.render();
  });


</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }

</style>
</head>
<body>
    <button onclick = "location.href='${pageContext.request.contextPath}/calendar/insertPage';">
        일정 등록
    </button>
  <div id='calendar'></div>

</body>
</html>