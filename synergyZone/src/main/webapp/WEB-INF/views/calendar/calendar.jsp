<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8' />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.1/js/bootstrap.bundle.min.js">
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <script src="/static/js/index.global.js"></script>
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
        buttonText: {
          today: "오늘",
          dayGridMonth: "월간",
          week: "주간",
          day: "일간",
          list:"목록"
        },
        navLinks: true,
        businessHours: true,
        editable: true,
        selectable: true,
        events: events,
        eventClick: function(event) {
        	
          let seq = event.event.extendedProps.seq;
          let empno = event.event.extendedProps.empno;
          document.getElementById('editBtn').addEventListener('click', function() {
        	    // 페이지 이동
        	    window.location.href = "/calendar/edit?seq=" + seq;
        	  });
          document.getElementById('eventTitle').textContent = event.event.title;
          document.getElementById('eventStart').textContent = moment(event.event.start).format('YYYY년 MM월 DD일 HH:mm:ss');
          document.getElementById('eventEnd').textContent = moment(event.event.end).format('YYYY년 MM월 DD일 HH:mm:ss');
		
          // 모달을 표시 (Bootstrap 5):
          var eventModal = new bootstrap.Modal(document.getElementById('eventModal'));
          eventModal.show();
        },
        locale: 'ko'
      });
      calendar.render();
    });
    document.getElementById('deleteBtn').onclick = function() {
    	  var deleteConfirm = confirm("정말로 이 일정을 삭제하시겠습니까?");
    	  if (deleteConfirm) {
    	    event.event.remove(); // 캘린더 이벤트를 삭제합니다
    	    eventModal.hide(); // 모달 창을 닫습니다
    	   	$.ajax({
      		  type: "POST",
      		url: "/calendar/deleteDate?seq=" + seq,
      		  data: { seq: seq, empno: empno },
      		  success: function(response) {
      		    // 요청이 성공적으로 처리되면 실행되는 함수
      		    alert("일정이 성공적으로 삭제되었습니다.");
      		  },
      		  error: function(jqXHR, textStatus, errorThrown) {
      		    // 요청 처리 실패시 실행되는 함수
      		    alert("오류가 발생했습니다. 다시 시도해주세요.");
      		  }
      		});
    	  }
    	};
 
  </script>
  <style>
    body {
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
  <div class="container-fluid">
    <a href="/calendar/insertPage" class="btn btn-info">일정 등록</a>
    <div id='calendar'>
    </div>
  </div>
  <div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="eventModalLabel">상세 정보</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p><strong>제목: </strong><span id="eventTitle"></span></p>
          <p><strong>시작: </strong><span id="eventStart"></span></p>
          <p><strong>종료: </strong><span id="eventEnd"></span></p>
          <!-- 추가하려는 정보에 따라 요소를 추가 -->
        </div>
       
		<div class="modal-footer">
  <button type="button" id="editBtn" class="btn btn-info">수정</button>
  <button type="button" id="deleteBtn" class="btn btn-danger">삭제</button>
  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
</div>
      </div>
    </div>
  </div>
</body>
</html>
