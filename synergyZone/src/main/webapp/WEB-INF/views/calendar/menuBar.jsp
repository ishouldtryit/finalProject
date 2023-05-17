<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MenuBar</title>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="/static/css/menubar-style.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Changa:wght@400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="https://kit.fontawesome.com/c7853f4d26.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="menu">
        <p class="share">Share
        <p class="ware">Ware
        <div class="list-item ${myCondition eq 'home' ? 'active' : ''}"><a href="/home.sw">홈</a></div>
        <div class="list-item ${myCondition eq 'project' ? 'active' : ''}"><a href="/project/projectList.sw">프로젝트 관리</a></div>
        <div class="list-item ${myCondition eq 'report' ? 'active' : ''}"><a href="/report/dailyList.sw">업무일지</a></div>
        <div class="list-item ${myCondition eq 'attendance' ? 'active' : ''}"><a href="/attendance/attListViewEmp.sw">근태 관리</a></div>
        <div class="list-item ${myCondition eq 'organization' ? 'active' : ''}"><a href="/member/organizationView.sw">조직도</a></div>
        <div class="list-item ${myCondition eq 'member' ? 'active' : ''}"><a href="/member/address.sw">주소록</a></div>
        <div class="list-item ${myCondition eq 'board' ? 'active' : ''}"><a href="/community/list.sw">게시판</a></div>
        <div class="list-item ${myCondition eq 'meetingRoom' ? 'active' : ''}"><a href="/meetionRoom/meetingRoomReservationView.sw">회의실 예약</a></div>
        <div class="list-item ${myCondition eq 'approval' ? 'active' : ''}"><a href="/approval/draftListView.sw">전자결재</a></div>
        <div class="list-item ${myCondition eq 'chat' ? 'active' : ''}"><a href="/chat/chatListView.sw">채팅</a></div>
        <div class="list-item ${myCondition eq 'calendar' ? 'active' : ''}"><a href="/calendar/schListView.sw">일정</a></div>
        <div class="list-item ${myCondition eq 'mail' ? 'active' : ''}"><a href="/mail/SmailListView.sw">메일</a></div>
    </div>
    <div class="header">
   		<div class="header-right">
   			<button id="btn-mail" onclick="location.href='/mail/SmailListView.sw'">
		    	<span class="material-icons" style="font-size:45px;">
					mail_outline
				</span>
				<div id="mail-count"></div>
			</button>
			<button id="btn-alarm">
		    	<span class="material-icons" style="font-size:45px;">
					notifications_none
				</span>
				<div id="alarm-count"></div>
			</button>
			<button id="btn-info">
				<c:if test="${loginUser.photo != null }">
					<img src="../../resources/profile/${loginUser.photo }" alt="사진">
				</c:if>
				<c:if test="${loginUser.photo == null }">
					<span class="material-icons" style="font-size:45px;">
						account_circle
					</span>
				</c:if>
				<span class="user">${loginUser.memberName } 님</span>
			</button>
		</div>
    </div>
<%--     <jsp:include page="../alarm/alarmModal.jsp"></jsp:include> --%>
    <div id="profile-menu">
    	<button onclick="location.href='/member/myInfo.sw'">기본 정보 조회</button>
    	<button onclick="location.href='/member/logout.sw'">로그아웃</button>
    </div>
</body>
</html>