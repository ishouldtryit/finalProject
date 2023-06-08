<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

  <body>

    <!--
        container - 화면이 배치될 기본 위치

        1. container : 기본 컨테이너이며 폭에 반응하여 자동 조정(뚝뚝끊김)
        2. container-fluid : 폭의 변화에 부드럽게 반응하는 컨테이너(100%)

        row - 한 줄 영역 , col - 한 칸 영역

        사이즈 - sm, md, lg, xl
    -->
    <form action="findPw" method="post" autocomplete="off">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">

                    <div class="row mt-4">
                        <div class="col">
                            <h2>비밀번호 찾기</h2>
                            <h3>아이디와 본인확인 이메일을 입력해주세요</h3>
                        </div>
                    </div>
    
                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사원번호</label>
                            <input class="form-control rounded" type="text" name="empNo">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">이메일</label>
                            <input class="form-control rounded" type="text" name="empEmail">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <button class="btn btn-primary" type="submit">찾기</button>
                        </div>
                    </div>
                    
                    <c:if test="${param.mode == 'error'}">
                    	<div class="row mt-4">
	                        <div class="col">
	                            <h3 class="error">입력하신 정보와 일치하는 회원이 없습니다.</h3>
	                        </div>
                    	</div>
                    </c:if>
    
                </div>
            </div>
    
            
        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
