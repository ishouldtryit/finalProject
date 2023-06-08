<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"> -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
    <style>
        a{
            color: black;
            text-decoration: none;
        }
        a:hover{
            color: darkblue;
        }
    </style>

</head>
 <body>
    <form action="findPw" method="post" autocomplete="off">

        <div id="app" style="background: linear-gradient(#7ba9ff6c 27%,#8a8eff65,#ddc7ff93,#f8c7ff6b)">
            
            <div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
                <div class="p-5 bg-light border border-2 rounded-3">
              
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
    
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        const app = Vue.createApp({
            data(){
                return{

                }
            },
        });
        app.mount('#app');
    </script>

  </body>
</html>