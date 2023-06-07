<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                  color: '#85d0ed',
                  seq : '${item.SEQ}',
                  empno : '${item.EMP_NO}'

                });
</c:forEach>
console.log(events)
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
      events : events,
      eventClick: function(event) {
          let seq = event.event.extendedProps.seq // 테이블 seq 값
          let empno = event.event.extendedProps.empno // 저장되있는 사번

          console.log(JSON.stringify(event))
          location.href='${pageContext.request.contextPath}/calendar/insertPage?seq='+seq;
      }
    });
    locale: 'ko',

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