<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SynergyZone</title>
<link rel="icon" href="${pageContext.request.contextPath}/static/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
<style>
    a {
        color: black;
        text-decoration: none;
    }

    a:hover {
        color: darkblue;
    }
    
    .custom-alert {
        background-color: #f8d7da;
        border-color: #f5c6cb;
        color: #721c24;
        padding: .75rem 1.25rem;
        margin-bottom: 1rem;
        border-radius: .25rem;
    }
</style>
</head>
<body>
    <div id="app" style="background: linear-gradient(#7ba9ff6c 27%,#8a8eff65,#ddc7ff93,#f8c7ff6b)">
        <form action="login" method="post">
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
                            <input class="form-control rounded" type="text" v-model="empNo" name="empNo">
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">비밀번호</label>
                            <input class="form-control rounded" type="password" v-model="empPassword" name="empPassword">
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col">
                            <button type="button" class="btn btn-outline-info btn-lg w-100" @click="submitForm">
                                로그인
                            </button>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col text-center">
                            <a href="employee/findPw">비밀번호 찾기</a>
                        </div>
                    </div>
<!--                     <div class="row mt-2"> -->
<!--                         <div class="col text-center"> -->
<!--                             <span v-if="!empNoValid && showErrorMessage" style="color: red">아이디를 입력해 주세요.</span> -->
<!--                             <span v-else-if="!empPasswordValid && showErrorMessage" style="color: red">비밀번호를 입력해 주세요.</span> -->
<!--                         </div> -->
<!--                     </div> -->
					 <c:if test="${param.mode == 'error'}">
                        <div class="row mt-4">
                            <div class="col">
                                <div class="alert custom-alert" role="alert">
                                    아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다.
                                </div>
                            </div>
                        </div>
                    </c:if>
					

                </div>
            </div>
        </form>
    </div>

    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
    <script>
        Vue.createApp({
            data() {
                return {
                    empNo: "",
                    empPassword: "",
                };
            },
            computed: {
                empNoValid() {
                    return this.empNo.length > 0;
                },
                empPasswordValid() {
                    return this.empPassword.length > 0;
                },
            },
            methods: {
                submitForm() {
                    if (!this.empNoValid) {
                        alert("아이디를 입력해주세요.");
                        return;
                    } else if (!this.empPasswordValid) {
                        alert("비밀번호를 입력해주세요.");
                        return;
                    }
                    // Submit the form
                    document.querySelector("form").submit();
                },
            },
        }).mount("#app");
    </script>
</body>
</html>
