<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>main</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css"
   href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="stylesheet"
   href="https://unpkg.com/swiper/swiper-bundle.min.css">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">

<style>
#img {
   width: 280px;
   height: 50px;
   margin-top: 2px;
}

a {
   text-decoration: none;
   color: white;
}

a:hover {
   color: #FFEDCB;
}

html, body {
   height: 100%;
   overflow: hidden;
}

.container-fluid {
   height: 100%;
   overflow-y: auto;
}

.swiper-container {
   overflow: hidden;
   position: relative;
}

.swiper-button-prev, .swiper-button-next {
   position: absolute;
   top: 50%;
   transform: translateY(-50%);
}

.datepicker table {
   width: 400px;
   height: 300px;
   font-size: 18px;
}

#slide-img {
   height: 100%;
   width: 100%;
}
</style>
</head>
<body>

   <div class="modal" id="logoutModal" tabindex="-1">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title">로그아웃 확인</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal"
                  aria-label="Close"></button>
            </div>
            <div class="modal-body">
               <p>로그아웃 하시겠습니까?</p>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary"
                  data-bs-dismiss="modal">취소</button>
               <button type="button" class="btn btn-primary" @click="logout">로그아웃</button>
            </div>
         </div>
      </div>
   </div>

   <div class="container-fluid"
      style="background-color: rgba(194, 194, 194, 0.288);" id="app">


      <div class="row">
         <div class="col col-7 bg-info text-light">
            <img src="static/img/logo.png" id="img" class="p-1">
         </div>

         <div class="col bg-info text-light p-2">
            <input type="text" class="form-control" placeholder="검색어 입력">
         </div>

         <div class="col bg-info text-light p-1 d-flex justify-content-end">
            <i class="bi bi-diagram-3 fs-2"></i> <i class="bi bi-bell fs-2 ms-3"></i>
            <i class="bi bi-person-circle fs-2 ms-3"></i> <i
               class="bi bi-power fs-2 ms-3 me-2" data-bs-toggle="modal"
               data-bs-target="#logoutModal"></i>
         </div>
      </div>


		<div class="row">
			<div class="col-1 bg-info text-light"
				style="width: 75px; height: 913px;">
				<a href="#"> <i
					class="bi bi-house fs-3 d-flex justify-content-center mt-3"></i>
					<p class="text-center">홈</p>
				</a>   
				<a href="${pageContext.request.contextPath}/calendar/calendar"><i
					class="bi bi-calendar-check fs-3 d-flex justify-content-center mt-4"></i>
					<p class="text-center">일정</p>
				</a> 
				
	            <a href="${pageContext.request.contextPath}/message/receive">
				<i class="bi bi-envelope fs-3 d-flex justify-content-center mt-4"></i>
					<p class="text-center">쪽지</p>
				</a> 
				
				<a href="#"> <i
					class="bi bi-pencil-square fs-3 d-flex justify-content-center mt-4"></i>
					<p class="text-center">업무</p>
				</a> 
				<a href="${pageContext.request.contextPath}/board/list"> <i
               class="bi bi-clipboard fs-3 d-flex justify-content-center mt-4"></i>
               <p class="text-center">게시판</p>
            </a>
	            <a href="${pageContext.request.contextPath}/address/list">
				<i class="bi bi-journals fs-3 d-flex justify-content-center mt-4"></i>
					<p class="text-center">주소록</p>
				</a>
			</div>


         <div class="col col-2 mt-4">

            <div class="bg-light border p-2"
                 style="height: 230px; width: 290px; margin-left: 15px;">
                 
                <div class="d-flex justify-content-center">
                 <div class="profile-image employee-name">
                   <img width="100" height="100" :src="getProfileImageUrl(employeeInfo.attachmentNo)" 
                   alt="" style="border-radius: 50%; margin-top: 10px;">
                 </div>
               </div>

                
                
                <h5 class="text-center mt-4">{{ employeeInfo.empName }}</h5>
                <p class="text-center mt-3">{{ employeeInfo.deptName }}</p>
            </div>


            <div class="bg-light border p-2"
               style="width: 755px; height: 280px; margin-left: 15px; margin-top: 20px;">
               <p>쪽지함</p>
               <hr>
               <table class="table table-hover">
                  <tbody>
                     <tr>
                        <td>ㄱㄴㄷ</td>
                        <td>1111111111</td>
                        <td>2023.05.17</td>
                     </tr>
                     <tr>
                        <td>ㄱㄴㄷ</td>
                        <td>1111111111</td>
                        <td>2023.05.17</td>
                     </tr>
                     <tr>
                        <td>ㄱㄴㄷ</td>
                        <td>1111111111</td>
                        <td>2023.05.17</td>
                     </tr>
                     <tr>
                        <td>ㄱㄴㄷ</td>
                        <td>1111111111</td>
                        <td>2023.05.17</td>
                     </tr>
                  </tbody>
               </table>
            </div>

            <div class="bg-info text-light border"
               style="width: 380px; height: 315px; margin-left: 15px; margin-top: 20px;">
               <p class="p-2">Memo</p>
               <div>
                  <textarea v-if="isTextareaEnabled" v-model="memoText"
                     style="width: 362px; height: 210px;"
                     class="bg-info text-light border-info ms-2"></textarea>
                  <div v-else style="width: 362px; height: 210px; padding: 0.5rem;">{{
                     memoText }}</div>
               </div>
               <div class="d-flex justify-content-center">
                  <button class="btn btn-info" @click="saveMemo">
                     저장 <i class="bi bi-check"></i>
                  </button>
                  <button class="btn btn-info" @click="toggleTextarea">
                     추가 <i class="bi bi-plus-square"></i>
                  </button>
               </div>
            </div>

         </div>

         <div class="col col-3 mt-4">
            <div style="height: 230px; width: 100%; margin-left: 10px;"
               id="ww_7fd843d3cd9e8" v='1.3' loc='id'
               a='{"t":"horizontal","lang":"ko","sl_lpl":1,"ids":[],"font":"Arial","sl_ics":"one_a","sl_sot":"celsius","cl_bkg":"image","cl_font":"#FFFFFF",
                    "cl_cloud":"#FFFFFF","cl_persp":"#81D4FA","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722"}'>
               Weather Data Source: <a
                  href="https://wetterlang.de/seoul_wetter_30_tage/"
                  id="ww_7fd843d3cd9e8_u" target="_blank"> 30 tage Seoul wetter
               </a>
            </div>

            <div class="bg-light border"
               style="height: 315px; width: 348px; margin-top: 320px; margin-left: 102px;">
               2</div>
         </div>

         <div class="col col-3 mt-4">
            <div class="bg-light border swiper-container"
               style="height: 230px; margin-left: -5px;">
               <div class="swiper-wrapper">
                  <div class="swiper-slide">
                     <img
                        src="https://library.gabia.com/wp-content/uploads/2021/07/saas.jpeg"
                        id="slide-img">
                  </div>
                  <div class="swiper-slide">
                     <img
                        src="https://library.gabia.com/wp-content/uploads/2021/08/AdobeStock_278664962-1024x683.jpeg"
                        id="slide-img">
                  </div>
                  <div class="swiper-slide">
                     <img src="https://i.ytimg.com/vi/RH7Q4DVjSsk/maxresdefault.jpg"
                        id="slide-img">
                  </div>
               </div>
               <div class="swiper-pagination"></div>
               <div class="swiper-button-prev"></div>
               <div class="swiper-button-next"></div>
            </div>

            <div class="bg-light border p-2"
               style="height: 280px; margin-top: 20px; margin-left: -5px;">
               <p>공지사항</p>
               <hr>
               <table class="table table-hover">
                  <tbody>
                     <tr>
                        <td>aㅁㄴㅇㄻㄴㄻ</td>
                     </tr>
                     <tr>
                        <td>aㅁㄴㅇㄻㄴㄻ</td>
                     </tr>
                     <tr>
                        <td>aㅁㄴㅇㄻㄴㄻ</td>
                     </tr>
                     <tr>
                        <td>aㅁㄴㅇㄻㄴㄻ</td>
                     </tr>
                  </tbody>
               </table>
            </div>

            <div class="bg-light border p-2"
               style="height: 315px; margin-left: -5px; margin-top: 20px;">
               <p>게시판</p>
               <hr>
               <table class="table table-hover">
                  <tbody>
                     <tr>
                        <td>ddddd</td>
                     </tr>
                     <tr>
                        <td>ddddd</td>
                     </tr>
                     <tr>
                        <td>ddddd</td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div>

         <div class="col mt-4 mb-4">
            <div class="bg-light border p-2" style="height: 100%; width: 500px;">

               <div class="d-flex justify-content-center mt-4">
                  <h2>
                     현재 시각 <i class="bi bi-clock fs-2"></i> {{currentTime}}
                  </h2>
               </div>
               <hr>
               <div>
                  <div v-model="selectedDate" ref="datepicker" style="margin-left: 38px;"></div>
                  <hr>
                  <div>
                     <div>
                        출근시간:
                        <c:choose>
                           <c:when test="${empty w.startTime}">
                              <label id="start-time">미등록</label>
                           </c:when>
                           <c:otherwise>
                              <label id="start-time">${w.startTime}</label>
                           </c:otherwise>
                        </c:choose>
                        <br>
                     </div>
                     <div>
                        퇴근시간:
                        <c:choose>
                           <c:when test="${empty w.endTime}">
                              <label id="end-time">미등록</label>
                           </c:when>
                           <c:otherwise>
                              <label id="end-time">${w.endTime}</label>
                           </c:otherwise>
                        </c:choose>
                        <br>
                     </div>
                     <div>
                        주간근무시간: <label id="">0h:0m:0s</label>
                     </div>
                  </div>
                  <form action="/commute/change" method="post">
                     <div class="d-flex justify-content-center">
                        <c:choose>
                           <c:when test="${empty w.startTime && empty w.endTime}">
                              <button class="btn btn-outline-info btn-lg me-2" type="submit"
                                 value="1" name="status">출근하기</button>
                              <button class="btn btn-outline-info btn-lg me-2" type="submit"
                                 value="2" name="status" disabled>퇴근하기</button>
                           </c:when>
                           <c:when test="${not empty w.startTime && empty w.endTime}">
                              <button class="btn btn-outline-info btn-lg me-2" type="submit"
                                 value="1" name="status" disabled>출근하기</button>
                              <button class="btn btn-outline-info btn-lg me-2" type="submit"
                                 value="2" name="status">퇴근하기</button>
                           </c:when>
                           <c:otherwise>
                              <button class="btn btn-outline-info btn-lg me-2" type="submit"
                                 value="1" name="status" disabled>출근하기</button>
                              <button class="btn btn-outline-info btn-lg me-2" type="submit"
                                 value="2" name="status" disabled>퇴근하기</button>
                           </c:otherwise>
                        </c:choose>
                     </div>
                  </form>

                  <hr>

                  <div class="d-flex justify-content-center mt-4">
                     <h4>
                        남은 시간 <i class="bi bi-stopwatch"></i> {{remainingTime}}
                     </h4>
                  </div>
                  <div class="progress mt-3" style="height: 23px;">
                     <div
                        class="progress-bar progress-bar-striped progress-bar-animated bg-info"
                        role="progressbar" :style="barStyle"></div>
                  </div>
               </div>
            </div>
         </div>

      </div>

   </div>

   <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
   <script async src="https://app1.weatherwidget.org/js/?id=ww_7fd843d3cd9e8"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> -->
    <script src="https://unpkg.com/vue@3.2.26"></script>
   <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>



   <script>
    Vue.createApp({
        data() {
            return {
                currentTime: '',
                currentDate: '',
                remainingTime: '',
                barStyle: '',
                swiper: null,
                isTextareaEnabled: false,
                memoText: localStorage.getItem('memo') || '',
                employeeInfo: null,
            };
        },
        methods: {
           initSwiper() {
                this.swiper = new Swiper('.swiper-container', {
                    autoplay: true,
                    loop: true,
                    allowTouchMove: false,
                    slidesPerView: 1,
                    navigation: {
                        nextEl: ".swiper-button-next",
                        prevEl: ".swiper-button-prev",
                    },
                    pagination:{
                        el:'.swiper-pagination',
                    }
                });
            },
            updateTime() {
                setInterval(() => {
                    const now = new Date();
                    this.currentTime = now.toLocaleTimeString();
                }, 1000); // 1초마다 시간 업데이트
            },
            updateRemainingTime() {
                setInterval(() => {
                    const now = new Date();
                    const targetTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 18, 0, 0); // 오늘 오후 6시
                    const timeDiff = targetTime - now;

                    const hours = Math.floor(timeDiff / (1000 * 60 * 60));
                    const minutes = Math.floor((timeDiff / (1000 * 60)) % 60);
                    const seconds = Math.floor((timeDiff / 1000) % 60);

                    this.remainingTime = hours + `시간 ` + minutes + `분 ` + seconds + `초`;
                    this.updateProgressBar(timeDiff);
                }, 1000); // 1초마다 남은 시간 업데이트
            },
            updateProgressBar(timeDiff) {
                const totalSeconds = 9 * 60 * 60; // 9시간을 초로 환산
                const remainingSeconds = timeDiff / 1000;
                const percentage = 100 - (remainingSeconds / totalSeconds) * 100;

                if (percentage < 0) {
                    percentage = 0;
                    clearInterval(this.remainingTimer); // 타이머
                }

                this.barStyle = 'width: ' + percentage + '%';
            },
             toggleTextarea() {
                this.isTextareaEnabled = !this.isTextareaEnabled;
            },
            saveMemo() {
                // console.log('메모가 저장되었습니다:', this.memoText);
                localStorage.setItem('memo', this.memoText);
                this.isTextareaEnabled = false;
            },
            logout() {

            },
            initializeDatepicker() {
                 
               },
           
               //프사 띄우기 
                async fetchEmployeeInfo() {
                    const resp = await axios.get('/rest/employeeInfo/all');
                    this.employeeInfo = resp.data;
                },
                getProfileImageUrl(attachmentNo) {
                    if (attachmentNo > 0) {
                        return '/attachment/download?attachmentNo=' + attachmentNo;
                    } else {
                      return 'https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg';
                    }
                  },
        },
        
        created() {
            this.initializeDatepicker();
            this.initSwiper();
            this.updateTime();
            this.updateRemainingTime();
            this.fetchEmployeeInfo();
        },
    }).mount("#app");

    app.component('datepicker', {
        mounted() {
            const datepicker = this.$refs.datepicker;
            $(datepicker).datepicker({
            format: 'yyyy-mm-dd',
            beforShowday:(date)=>{ 
                // const currentDate = new Date().toISOString().split('T')[0];
                const now = new Date();
                const dateStr = $.datepicker.formatDate('yy-mm-dd', date);
                if (dateStr === currentDate) {
                    return [true, 'highlight', ''];
                }
                return [true, '', ''];
            },
            onSelect: (date) => {   
                this.$emit('update:selectedDate', date);
            },
            });
        },
        template: `
            <div v-model="selectedDate" ref="datepicker"></div> 
        `,
        props: ['selectedDate'],
    });

</script>

</body>
</html>