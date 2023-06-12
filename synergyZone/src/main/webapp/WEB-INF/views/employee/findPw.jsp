<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
        <div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
            <div class="p-5 bg-light border border-2 rounded-3">
                <form action="findPw" method="post" autocomplete="off">
                    <div class="row mt-4">
                        <div class="col text-center">
                            <h3 class="text-dark">비밀번호 찾기</h3>
                            <br>
                            <h6 class="text-muted mt-2">사원번호와 본인확인 이메일을 입력해주세요</h6>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col">
                            <label class="form-label">사원번호</label>
                            <input class="form-control rounded" type="text" v-model="empNo" name="empNo">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col">
                            <label class="form-label">이메일</label>
                            <input class="form-control rounded" type="text" v-model="empEmail" name="empEmail">
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <span v-if="checkMessage" class="text-danger">{{ checkMessage }}</span>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="d-flex justify-content-center">
                        	<div class="d-grid gap-2 col-6 mx-auto">
                            <button class="btn btn-outline-info" type="submit" @click.prevent="submitForm">찾기</button>
                            </div>
                        </div>
                    </div>
                    <c:if test="${param.mode == 'error'}">
                        <div class="row mt-4">
                            <div class="col">
                                <div class="alert custom-alert" role="alert">
                                    입력하신 정보와 일치하는 회원이 없습니다.
                                </div>
                            </div>
                        </div>
                    </c:if>
                </form>
            </div>
        </div>
    </div>

    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
    <script>
        Vue.createApp({
            data() {
                return {
                    empNo: "",
                    empEmail: "",
                    checkMessage: "", // checkMessage를 data 속성으로 변경
                };
            },
            computed: {
                empNoValid() {
                    return this.empNo.length > 0;
                },
                empEmailValid() {
                    return this.empEmail.length > 0;
                },
            },
            methods: {
                submitForm() {
                    if (!this.empNoValid) {
                        this.checkMessage = "사원번호를 입력해 주세요.";
                        return;
                    } else if (!this.empEmailValid) {
                        this.checkMessage = "이메일을 입력해 주세요.";
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
