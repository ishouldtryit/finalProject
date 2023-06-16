<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SynergyZone</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/static/favicon.ico"
	type="image/x-icon">




<!-- 사이드바 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">

<!-- 부트스트랩 css(journal) -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">

<!-- 부트스트랩 icon cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<!-- 폰트어썸 cdn -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- 뷰 cdn -->
<script src="https://unpkg.com/vue@3.2.26"></script>
<!-- axios -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<!-- moment -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>

<!-- 사이드바관련 -->
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/static/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/static/js/main.js"></script>
<!--     <script src="/static/js/jquery.min.js"></script> -->
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/main.js"></script>


<script>
       const contextPath = "${pageContext.request.contextPath}";
       const memberId = "${sessionScope.memberId}";
       const memberLevel = "${sessionScope.memberLevel}";
       const empAdmin = "${sessionScope.empAdmin}";
       function togglePopup() {
           var popup = document.getElementById("popup");
           if (popup.style.display === "block") {
               popup.style.display = "none";
           } else {
               popup.style.display = "block";
           }
           
       }
       function logout() {
    	   var form = document.createElement("form");
    	    form.setAttribute("id", "logoutForm");
    	    form.setAttribute("action", "${pageContext.request.contextPath}/logout");
    	    form.setAttribute("method", "post");

    	    // form 내용을 추가하세요.
    	    // 예: form 내부에 필요한 input 요소, 버튼 등을 추가할 수 있습니다.

    	    document.body.appendChild(form);
    	    form.submit();
    	}
    </script>

<style>
#rogo-img {
	width: 200px;
	width: 280px;
	height: 50px;
	margin-top: 2px;
}

a {
	text-decoration: none;
}

.bi {
	text-decoration: none;
	color: #ffffff;
}

a:hover {
	color: #FFEDCB;
}

html, body {
	height: 100%;
	/*                 overflow: hidden; */
}

.wrapper {
	height: 100%;
	/*                 overflow-y: auto; */
}

.form-control {
	margin-left: -2px;
}

article {
	flex-grow: 1;
}

.popup {
	display: none;
	position: absolute;
	width: 125px;
	padding: 10px;
	background-color: white;
	border: 1px solid black;
	border-radius: 5px;
	z-index: 9999;
	top: 50px;
}
</style>

</head>
<body>
	<main>
		<header>
			<div class="container-fluid">
				<div class="row">
					<div class="col col-7 bg-info text-light">
						<a href="${pageContext.request.contextPath}/"> <img
							src="${pageContext.request.contextPath}/static/img/logo.png" id="rogo-img" class="p-1">
						</a>
					</div>

					<div class="col col-1 bg-info text-light"></div>

					<div id="app1"
						class="col col-4 bg-info text-light p-1 d-flex justify-content-end align-items-center">
						<h5 class="text-light mt-3 me-4"
							style="margin-bottom: 10px; color: black; font-weight: normal;">
							<strong>{{ employeeInfo.empName }}</strong> 님 환영합니다.
						</h5>


						<div class="profile-image employee-name1 d-flex align-items-center">
							<img width="34" height="34"
								:src="getProfileImageUrl(employeeInfo.attachmentNo)" alt=""
								style="border-radius: 50%; margin-top: 0px; margin-right: 7px; margin-left: 7px;"
								onclick="togglePopup()">
						</div>
						<div id="popup" class="popup">
							<ul class="text-sm list-unstyled list-inline">
								<li><a href="${pageContext.request.contextPath}/employee/edit">기본정보</a></li>
								<li><a href="${pageContext.request.contextPath}/employee/password">비밀번호 변경</a></li>
								<li><a href="#" onclick="logout()">로그아웃</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</header>

		<section style="display: flex;">
			<aside>
				<div class="wrapper d-flex align-items-stretch">
					<nav id="sidebar" class="bg-info">
						<div class="p-4 pt-5" style="min-height: 100vh;">
							<a href="#"><h3 class="text-light mb-5">그룹웨어</h3></a>
							<ul class="list-unstyled components mb-5">
								<li><a
									href="${pageContext.request.contextPath}/calendar/calendar">일정</a>
								</li>
								<li><a href="#homeSubmenu" data-toggle="collapse"
									aria-expanded="false" class="dropdown-toggle">게시판</a>
									<ul class="collapse list-unstyled" id="homeSubmenu">
										<li><a
											href="${pageContext.request.contextPath}/notice/list">공지사항</a>
										</li>
										<li><a
											href="${pageContext.request.contextPath}/board/list">자유게시판</a>
										</li>
									</ul></li>

								<li><a href="#pageSubmenu" data-toggle="collapse"
									aria-expanded="false" class="dropdown-toggle">전자결재</a>
									<ul class="collapse list-unstyled" id="pageSubmenu">
										<li><a href="${pageContext.request.contextPath}/approval/write">신규 결재</a></li>
										<li><a href="${pageContext.request.contextPath}/approval/myList">나의 기안 문서함</a></li>
										<li><a href="${pageContext.request.contextPath}/approval/waitApproverList">결재 수신 문서함</a></li>
										<li><a href="${pageContext.request.contextPath}/approval/recipientList">참조 문서함</a></li>
										<li><a href="${pageContext.request.contextPath}/approval/readerList">열람 문서함</a></li>
									</ul></li>

								<li><a href="#addressSubmenu" data-toggle="collapse"
									aria-expanded="false" class="dropdown-toggle">주소록</a>
									<ul class="collapse list-unstyled" id="addressSubmenu">
										<li><a
											href="${pageContext.request.contextPath}/address/list">전체
												주소록</a></li>
										<c:if test="${empNo != null}">
											<li><a
												href="${pageContext.request.contextPath}/bookmark/mylist">개인
													주소록</a></li>
										</c:if>
									</ul> <c:if test="${empNo != null}">
										<a href="#messageSubmenu" data-toggle="collapse"
											aria-expanded="false" class="dropdown-toggle">쪽지함</a>
										<ul class="collapse list-unstyled" id="messageSubmenu">
											<li><a
												href="${pageContext.request.contextPath}/message/receive">받은
													쪽지함</a></li>
											<li><a
												href="${pageContext.request.contextPath}/message/send">보낸
													쪽지함</a></li>
										</ul>
									</c:if></li>

								
                               <li>
                           <a href="#workSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">업무</a>
                           <ul class="collapse list-unstyled" id="workSubmenu">
                                   <li>
                                   <a href="${pageContext.request.contextPath}/workboard/write">일지 작성</a>
                                   </li>
                                   <li>
                                       <a href="${pageContext.request.contextPath}/workboard/list">부서 업무일지</a>
                                   </li>
                                   <li>
                                       <a href="${pageContext.request.contextPath}/workboard/myWorkList">내 업무일지</a>
                                   </li>
                                    <li>
                                       <a href="${pageContext.request.contextPath}/workboard/supList">공유받은 업무일지</a>
                                   </li>
                               </ul>
                           </li>
                           	
                           	<c:if test="${empAdmin == 'Y'}">
                              <li>
                              <a href="#adminSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">관리자 페이지</a>
                              <ul class="collapse list-unstyled" id="adminSubmenu">
                                      <li>
                                      <a href="${pageContext.request.contextPath}/admin/join">사원 등록</a>
                                      </li>
                                      <li>
                                          <a href="${pageContext.request.contextPath}/admin/list">사원 통합관리</a>
                                      </li>
                                      <li>
                                          <a href="${pageContext.request.contextPath}/admin/waitingList">사원 퇴사관리</a>
                                      </li>
                                      <li>
                                          <a href="${pageContext.request.contextPath}/admin/add">관리자 통합관리</a>
                                      </li>
                                      <li>
                                          <a href="${pageContext.request.contextPath}/admin/log/list">사원 접근로그</a>
                                      </li>
                                      <li>
                                          <a href="${pageContext.request.contextPath}/admin/department/list">부서 관리</a>
                                      </li>
                                      <li>
                                          <a href="${pageContext.request.contextPath}/admin/job/list">직위 관리</a>
                                      </li>
                                      <li><a href="${pageContext.request.contextPath}/approval/adminList">기안서 전체 문서함</a></li>
                                      <li><a
											href="${pageContext.request.contextPath}/commute/adminList">연차결재
												</a></li>
												<li><a
											href="${pageContext.request.contextPath}/commute/adminList2">출장결재
												</a></li>
                                  </ul>
                              </li>
   
                           	</c:if>
                           	
                              <li>
                              <a href="#employeeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">마이 페이지</a>
                              <ul class="collapse list-unstyled" id="employeeSubmenu">
                              
                                      <li>
                                      <a href="${pageContext.request.contextPath}/employee/edit">기본정보</a>
                                      </li>
                                      <li>
                                          <a href="${pageContext.request.contextPath}/employee/password">비밀번호 변경</a>
                                      </li>
                        
                                  </ul>
                              </li>

								<li><a href="#commuteSubmenu" data-toggle="collapse"
									aria-expanded="false" class="dropdown-toggle">근태관리</a>
									<ul class="collapse list-unstyled" id="commuteSubmenu">
										<li><a
											href="${pageContext.request.contextPath}/commute/write">휴가
												신청 </a></li>
										<li><a
											href="${pageContext.request.contextPath}/commute/trip">출장
												신청</a></li>
										<li><a
											href="${pageContext.request.contextPath}/commute/record">근무시간
												집계현황 </a></li>
										<li><a
											href="${pageContext.request.contextPath}/commute/vacation">휴가
												신청내역</a></li>
										<li><a
											href="${pageContext.request.contextPath}/commute/tripList">출장
												신청내역</a></li>
												
									</ul></li>
							</ul>
						</div>
					</nav>
				</div>
			</aside>
			<!-- Page Content  -->
			<article>

				<script>
 Vue.createApp({
	  data() {
	    return {
		      employeeInfo: {
		    	  empName : "",
		      },
	    };
	  },
	  methods: {
	    async fetchEmployeeInfo() {
	      const resp = await axios.get(contextPath+'/rest/employeeInfo/all');
	      this.employeeInfo = resp.data;
	    },
	    getProfileImageUrl(attachmentNo) {
	      if (attachmentNo > 0) {
	        return contextPath+'/attachment/download?attachmentNo=' + attachmentNo;
	      } else {
	        return contextPath+"/static/img/dummydog.jpg";
	      }
	    },
	  },
	  created() {
	    this.fetchEmployeeInfo();
	  },
	}).mount("#app1");
</script>
