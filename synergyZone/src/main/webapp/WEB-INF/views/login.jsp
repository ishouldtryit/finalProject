<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"> -->
 <link rel="icon" href="${pageContext.request.contextPath}/static/favicon.ico" type="image/x-icon">
 
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
    <form action="login" method="post">

        <div id="app" style="background: linear-gradient(#7ba9ff6c 27%,#8a8eff65,#ddc7ff93,#f8c7ff6b)">
            
            <div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
                <div class="p-5 bg-light border border-2 rounded-3">
                    <div class="row">
                        <div class="col">
                        <img src="static/img/logo.png">
                        </div>
                    </div>
                <div class="row mt-5">
                    <div class="col">
                        <label class="form-label">사원번호</label>
                        <input class="form-control rounded" type="text" name="empNo">
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col">
                        <label class="form-label">비밀번호</label>
                        <input class="form-control rounded" type="password" name="empPassword">
                    </div>
                </div>
                
                <div class="row mt-5">
                    <div class="col">
                        <button type="submit" class="btn btn-outline-info btn-lg w-100">
                            로그인
                        </button>
                    </div>
                </div>
                
                <div class="row mt-1">
                    <div class="col text-center">
                        <label class="ms-1 me-1">/</label>
                        <a href="employee/findPw">비밀번호 찾기</a>
                    </div>
                </div>
                
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