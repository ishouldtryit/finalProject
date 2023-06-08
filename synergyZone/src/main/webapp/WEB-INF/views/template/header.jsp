
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홈페이지 레이아웃</title>
    
    <!-- 사이드바 css -->
    <link rel="stylesheet" href="/static/css/style.css">
    
    <!-- 부트스트랩 css(journal) -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
	
	<!-- 부트스트랩 icon cdn -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    
    <!-- 폰트어썸 cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- 뷰 cdn -->
    <script src="https://unpkg.com/vue@3.2.26"></script>
    <!-- axios -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    
    <!-- lodash -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
   
	<!-- 사이드바관련 -->
    <script src="/static/js/jquery.min.js"></script>
	<script src="/static/js/popper.js"></script>
	<script src="/static/js/popper.js"></script>
	<script src="/static/js/main.js"></script>
<!--     <script src="/static/js/jquery.min.js"></script> -->
    <script src="/static/js/bootstrap.min.js"></script>
	<script src="/static/js/main.js"></script>


    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    	const memberId = "${sessionScope.memberId}";
    	const memberLevel = "${sessionScope.memberLevel}";
    </script>
    
    <style>
      #rogo-img{
        width: 200px;
        width: 280px;
        height: 50px;
        margin-top: 2px;
      }
                  a{
                text-decoration: none;
            }
            html,body{
                height: 100%;
/*                 overflow: hidden; */
            }
            .wrapper{
                height: 100%;
/*                 overflow-y: auto; */
            }
            .form-control{
                margin-left: -2px;
            }
            article {
   				flex-grow: 1;
  			}
    </style>
    
</head>
<body>
    <main>
     <header>
        <div class="container-fluid">
	      <div class="row">
	          <div class="col col-7 bg-info text-light">
	            <a href="http://localhost:8080/">
	            <img src="/static/img/logo.png" id="rogo-img" class="p-1">
	            </a>
	          </div>
	      
	          <div class="col bg-info text-light p-2">
	            <input type="text" class="form-control" placeholder="검색어 입력">
	          </div>
	                  
	          <div class="col bg-info text-light p-1 d-flex justify-content-end">
	            <i class="bi bi-bell fs-3 ms-5"></i>
	            <i class="bi bi-person-circle fs-3 ms-3 me-3"></i>
	          </div>
	        </div>
	    </div>
    </header>
    
    <section style = "display:flex;">
    <aside>
	     <div class="wrapper d-flex align-items-stretch" >
	            <nav id="sidebar" class="bg-info">
	                <div class="p-4 pt-5" style=" min-height: 70vh;">
	                    <a href="#"><h3 class="text-light mb-5">그룹웨어</h3></a>
	                    <ul class="list-unstyled components mb-5">
	                     <li>
	                            <a href="${pageContext.request.contextPath}/calendar/calendar">일정</a>
	                        </li>
	                        <li>
	                            <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">게시판</a>
	                            <ul class="collapse list-unstyled" id="homeSubmenu">
	                                <li>
	                                    <a href="/notice/list">공지사항</a>
	                                </li>
	                                <li>
	                                    <a href="/board/list">자유게시판</a>
	                                </li>
	                            </ul>
	                        </li>
	
	                        <li>
	                        <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">전자결재</a>
	                        <ul class="collapse list-unstyled" id="pageSubmenu">
	                                <li>
	                                <a href="/approval/write">신규 결재</a>
	                                </li>
	                                <li>
	                                    <a href="/approval/adminList">전체 문서함 (관리자)</a>
	                                </li>
	                                <li>
	                                    <a href="/approval/myList">나의 기안 문서함</a>
	                                </li>
	                                <li>
	                                    <a href="/approval/waitApproverList">결재 대기 문서함</a>
	                                </li>
	                                <li>
	                                    <a href="/approval/waitAgreeorList">합의 대기 문서함</a>
	                                </li>
	                                <li>
	                                    <a href="/approval/recipientList">참조 문서함</a>
	                                </li>
	                                <li>
	                                    <a href="/approval/readerList">열람 문서함</a>
	                                </li>
	                                <li>
	                                    <a href="#">부서 문서함</a>
	                                </li>
	                            </ul>
	                        </li>
	
	 <li>
	                            <a href="#addressSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">주소록</a>
	                            <ul class="collapse list-unstyled" id="addressSubmenu">
	                                <li>
	                                    <a href="${pageContext.request.contextPath}/address/list">전체 주소록</a>
	                                </li>
	                                <c:if test="${empNo != null}">
									  <li>
									    <a href="${pageContext.request.contextPath}/bookmark/mylist">개인 주소록</a>
									  </li>
									</c:if>
	                            </ul>
	                            
	                           <c:if test="${empNo != null}">
	                            <a href="#messageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">쪽지함</a>
	                            <ul class="collapse list-unstyled" id="messageSubmenu">
	                                <li>
	                                    <a href="${pageContext.request.contextPath}/message/receive">받은 쪽지함</a>
	                                </li>
									  <li>
									    <a href="${pageContext.request.contextPath}/message/send">보낸 쪽지함</a>
									  </li>
	                            </ul>
									</c:if>
									
	                        </li>
	                        
	                            <li>
	                        <a href="#workSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">업무</a>
	                        <ul class="collapse list-unstyled" id="workSubmenu">
	                                <li>
	                                <a href="/workboard/write">일지 작성</a>
	                                </li>
	                                <li>
	                                    <a href="/workboard/list">부서 업무일지</a>
	                                </li>
	                                <li>
	                                    <a href="/workboard/reportList">내 업무일지</a>
	                                </li>
	                                 <li>
	                                    <a href="/workboard/supList">공유받은 업무일지</a>
	                                </li>
	                            </ul>
	                        </li>
	                        
		                        <li>
		                        <a href="#adminSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">관리자 페이지</a>
		                        <ul class="collapse list-unstyled" id="adminSubmenu">
		                                <li>
		                                <a href="/admin/join">사원 등록</a>
		                                </li>
		                                <li>
		                                    <a href="/admin/list">사원 통합관리</a>
		                                </li>
		                                <li>
		                                    <a href="/admin/waitingList">사원 퇴사관리</a>
		                                </li>
		                                <li>
		                                    <a href="/admin/adminList">관리자 통합관리</a>
		                                </li>
		                                <li>
		                                    <a href="/admin/log/list">사원 접근로그</a>
		                                </li>
		                                <li>
		                                    <a href="/admin/department/list">부서</a>
		                                </li>
		                                <li>
		                                    <a href="/admin/job/list">직위</a>
		                                </li>
		                            </ul>
		                        </li>
	
	                        <li>
	                            <a href="#">공지사항</a>
	                        </li>
	                        <li>
	                            <a href="#">Contact</a>
	                        </li>
	                    </ul>
	            </div>
	        </nav>
	        </div>
        </aside>
        <!-- Page Content  -->
        <article>
	
   <!--   <div id="content" class="p-4 p-md-5" style="height:200px;">	  -->           
	            
	            <nav class="navbar navbar-expand-lg navbar-light bg-light">
	                <div class="container-fluid">
	
	                    <button type="button" id="sidebarCollapse" class="btn btn-primary" style="background-color:#34659cc4; border-color: #34659c00;">
	                        <i class="fa fa-bars"></i>
	                        <span class="sr-only">Toggle Menu</span>
	                    </button>
	                    <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	                        <i class="fa fa-bars"></i>
	                    </button>
	                    
	                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	                        <ul class="nav navbar-nav ml-auto">
	                            <li class="nav-item">
	                                <a class="nav-link" href="#">홈</a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="#">일정</a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="#">쪽지</a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="#">업무</a>
	                            </li>
	                            <li class="nav-item active">
	                                <a class="nav-link" href="#">게시판</a>
	                            </li> 
	                            <li class="nav-item">
	                                <a class="nav-link" href="#">조직도</a>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
	            </nav>
	            
	            <!-- 내용 -->
