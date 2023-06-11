<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid">

         <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
             <i class="fa fa-bars"></i>
         </button>
         
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
             <ul class="nav navbar-nav ml-auto">
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/">홈</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/reservation/">회의실 예약</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>

<div id="app">
	<div class="container-fluid" >
	    <div class="row">
	    	<div class="col-10 offset-sm-1">   
				<div class="row mb-3 d-flex align-items-center"> 
					<div class="col">
					  <h3 style="margin:0;">회의실 예약</h3>
					</div>
				</div>
				<div class="row">
					<div ref="calendar" :options="calendarOptions"></div>
				</div>
			</div>
		</div>
		
	</div>
	
	
</div>            
	
	
	
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

 <script>
      Vue.createApp({
        data() {
          return {
        	  loginUser : "나야",
              calendarOptions: {
	              initialView: "timeGridWeek",
	              locale: 'ko',	//한국어 설정
	              editable: true, // 일정 편집 가능하도록 설정
	              selectable: true, // 일정 선택 가능하도록 설정
	              select: this.handleDateSelect, // 일정 선택 시 이벤트 핸들러
	              eventClick: this.handleEventClick, // 일정 클릭 시 이벤트 핸들러
	              validRange: {
	                  start: new Date().toISOString(), // 현재 시간을 시작으로 설정
	                  end: moment().add(1, 'months').toISOString(), // 현재 시간에서 1달 후로 설정
	             	 },
	              events: [ ],
	              headerToolbar: {
	                  left: "prev,next today",
	                  center: "title",
	                  right: "timeGridWeek,timeGridDay,list"
	                },
     	       },
            calendar: null,
          };
        },
        methods : {
        	loadData(){
//         		console.log(this.calendar.currentData.viewTitle);
        	},
        	  handleDatesSet(info) {
        	    const currentMonth = info.view.currentStart.getMonth() + 1;
        	    console.log(currentMonth);
        	  },
        	handleDateSelect(info) {	//일정 추가
        		  if (!confirm("예약 등록 하시겠습니까?")) return;
                const start = info.startStr; // 선택한 일정의 시작 날짜
                const end = info.endStr; // 선택한 일정의 종료 날짜
                
                const existingEvent = this.calendarOptions.events.find(event => { //일정 중복 검사
                    return (
                      (event.start <= start && start < event.end) ||
                      (event.start < end && end <= event.end) ||
                      (start <= event.start && event.end <= end)
                    );
                  });

                  if (existingEvent) {
                    alert("이미 예약되었습니다.");
                    return;
                  }
                
               const newEvent = {
                  title: "예약자 : " + this.loginUser,
                  start,
                  end,
                };
                this.calendar.addEvent(newEvent);
                this.calendarOptions.events.push(newEvent);
              },
                     
              handleEventClick(info) {
                    console.log(info.event);
                  if (confirm("예약을 취소하시겠습니까?")) {
                    const eventId = info.event.id;
                    // 예약 취소
                    this.calendar.getEventById(eventId).remove();
                    this.removeEventFromEvents(eventId);
                  }
                },
                
                removeEventFromEvents(eventId) {
                    const index = this.calendarOptions.events.findIndex(event => event.id === eventId);
                    if (index > -1) {
                      this.calendarOptions.events.splice(index, 1);
              }
                },
        },
        mounted() {
          this.calendar = new FullCalendar.Calendar(this.$refs.calendar, this.calendarOptions);
          this.calendar.render();
          this.calendar.on("datesSet", this.handleDatesSet);
        	this.loadData();
        },
        created() {
        },
      })
        .mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>