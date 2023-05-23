<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                               <input class="form-control rounded" type="password" v-model="changePwCheck" name="changePw">
                                <span>{{changePwCheckMessage}}</span>
                            </div>
                       </div>

                       <div class="row mt-4">
	                        <div class="col">
	                            <button type="submit" class="btn btn-primary" v-bind:disabled="!allValid">변경</button>
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
            //데이터 설정 영역
            data(){
                return {
                    currentPw:"",
                    changePw:"",
                    changePwCheck:"",
                };
            },
            //데이터 실시간 계산 영역
            //- 사용하고 싶은 변수명으로 함수를 선언
            //- 함수 내부에는 보여주고 싶은 값을 코드로 반환하도록 작성
            //- Vue에 등록한 값에 접근할 때 반드시 this를 붙여야 함
            //- 코드가 길면 안됨(무리가 많이 감)
            computed:{
                currentPwValid(){
                    return this.currentPw.length > 0;
                },
                
                changePwCheckValid(){
                    return this.changePw == this.changePwCheck;
                },

                changePwCheckMessage(){
                    if(this.changePwCheck.length == 0){
                        return "";
                    }
                    else if(this.changePw.length == 0){
                        return "변경할 비밀번호를 입력해주세요";
                    }
                    else if(this.changePwCheckValid){
                        return "비밀번호가 일치합니다";
                    }
                    else{
                        return "비밀번호가 일치하지 않습니다";
                    }
                },

                allValid(){
                    return this.changePwCheckValid
                            && this.currentPwValid;
                }
            },
            //메소드 영역
            //- 코드를 저장해두고 필요 시 호출할 수 있다
            //- 필요하다면 매개변수를 설정할 수 있고, 반환값을 가질 수 있다
            methods:{
            },
            //감시 영역(watch)
            //- data의 변동사항이 생기면 자동으로 실행되는 영역
            //- computed와 유사한 역할을 수행하지만 다름
            //- computed는 새로운 값을 계산하는 용도
            //- watch는 데이터가 변했을 때 특정 코드를 실행하는 용도
            watch:{
                
            },
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>