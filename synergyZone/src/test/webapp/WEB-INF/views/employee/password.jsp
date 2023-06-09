<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
                            <div class="col">
                                <button type="button" class="btn btn-primary" @click="submitForm">변경</button>
                            </div>
                        </div>

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
                        return "변경할 비밀번호를 입력해주세요";
                    } else if (this.changePwCheckValid) {
                        return "비밀번호가 일치합니다";
                    } else {
                        return "비밀번호가 일치하지 않습니다";
                    }
                },
            },
            // 메소드 영역
            methods: {
                submitForm() {
                    if (!this.currentPwValid) {
                        alert("현재 비밀번호를 입력해주세요.");
                    } else if (!this.changePwValid) {
                        alert("변경할 비밀번호를 입력해주세요.");
                    } else if (!this.changePwCheckValid) {
                        alert("비밀번호 확인을 입력해주세요.");
                    } else {
                        // Submit the form
                        document.querySelector("form").submit();
                    }
                },
            },
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>