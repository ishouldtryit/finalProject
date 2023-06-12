<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <style>
        a{
            color: black;
            text-decoration: none;
        }
        a:hover{
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
<body>

    <div id="app" class="container-500">
        <form action="password" method="post">

            <div class="container-fluid mt-4">

                <div class="row">
                    <div class="offset-md-2 col-md-8">

                        <div class="row mt-4">
                            <div class="col">
                                <label class="form-label">현재 비밀번호</label>
                                <input class="form-control rounded" v-model="currentPw" type="password" name="currentPw">
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col">
                                <label class="form-label">변경할 비밀번호</label>
                                <input class="form-control rounded" v-model="changePw" type="password" name="changePw">
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col">
                                <label class="form-label">비밀번호 확인</label>
                                <input class="form-control rounded" type="password" v-model="changePwCheck" name="changePwCheck">
                                <span>{{changePwCheckMessage}}</span>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="d-grid gap-2 col-6 mx-auto">
                                <button type="button" class="btn btn-outline-info" @click="submitForm">변경</button>
                            </div>
                        </div>
                        
                        <c:if test="${param.mode == 'error'}">
                        <div class="row mt-4">
                            <div class="col">
                                <div class="alert custom-alert" role="alert">
                                    현재 비밀번호를 정확하게 입력해 주세요.
                                </div>
                            </div>
                        </div>
                    </c:if>

                    </div>
                </div>


            </div>

        </form>
    </div>

    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
    <script>
        Vue.createApp({
            // 데이터 설정 영역
            data() {
                return {
                    currentPw: "",
                    changePw: "",
                    changePwCheck: "",
                };
            },
            // 데이터 실시간 계산 영역
            computed: {
                currentPwValid() {
                    return this.currentPw.length > 0;
                },
                
                changePwValid(){
                    return this.changePw.length > 0;
                },

                changePwCheckValid() {
                    return this.changePw === this.changePwCheck;
                },

                changePwCheckMessage() {
                    if (this.changePwCheck.length === 0) {
                        return "";
                    } else if (this.changePw.length === 0) {
                        return "변경할 비밀번호를 입력해 주세요.";
                    } else if (this.changePwCheckValid) {
                        return "비밀번호가 일치합니다.";
                    } else {
                        return "비밀번호가 일치하지 않습니다.";
                    }
                },
            },
            // 메소드 영역
            methods: {
                submitForm() {
                    if (!this.currentPwValid) {
                        alert("현재 비밀번호를 입력해 주세요.");
                    } else if (!this.changePwValid) {
                        alert("변경할 비밀번호를 입력해 주세요.");
                    } else if (!this.changePwCheckValid) {
                        alert("비밀번호 확인을 입력해 주세요.");
                    } else {
                        // Submit the form
                        document.querySelector("form").submit();
                    }
                },
            },
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>