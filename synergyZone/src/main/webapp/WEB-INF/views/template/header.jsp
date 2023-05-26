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
	<script src="/static/js/popper.js"></script>
	<script src="/static/js/main.js"></script>
    <script src="/static/js/jquery.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>


    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
    
    <style>
      #rogo-img{
        width: 200px;
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
	            <img src="/static/img/logo.png" id="rogo-img" class="p-1">
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
	                <div class="p-4 pt-5">
	                    <a href="#"><h3 class="text-light mb-5">게시판</h3></a>
	                    <ul class="list-unstyled components mb-5">
	                        <li>
	                            <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">회사 게시판</a>
	                            <ul class="collapse list-unstyled" id="homeSubmenu">
	                                <li>
	                                    <a href="#">공지사항</a>
	                                </li>
	                                <li>
	                                    <a href="#">자유게시판</a>
	                                </li>
	                                <li>
	                                    <a href="#">ㅋㅋㅋ</a>
	                                </li>
	                            </ul>
	                        </li>
	
	                        <li>
	                        <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">부서 게시판</a>
	                        <ul class="collapse list-unstyled" id="pageSubmenu">
	                                <li>
	                                <a href="#">공지사항</a>
	                                </li>
	                                <li>
	                                    <a href="#">자유게시판</a>
	                                </li>
	                                <li>
	                                    <a href="#">팀 게시판</a>
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
	
	        <div id="content" class="p-4 p-md-5" style="height:200px;">
	            
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
	            여기에 작성
		    </div>
		    
