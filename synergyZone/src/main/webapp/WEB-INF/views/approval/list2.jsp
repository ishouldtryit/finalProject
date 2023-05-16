<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div id="app">

    <div class="container">
        <div class="row center">
            <h1>기안서 목록</h1>
        </div>

        <div class="row" v-for="(draft, index) in draftList" :key="draftNo">

            <div class="row">
                <label>번호</label>
                <div class="row ">{{draft.draftNo}}</div>
            </div>
            <div class="row">
                <label>제목</label>
                <div class="row">{{draft.draftTitle}}</div>    
            </div>
            <div class="row">
                <label>작성자</label>
                <div class="row">{{draft.draftId}}</div>   
            </div>

        </div>
    </div>
</div>


    <script>
        Vue.createApp({
            //데이터 설정 영역
            data(){
                return {
                    //화면에서 사용할 데이터를 선언
                	draftList : [],
                };
            },
            computed:{

            },
            methods:{
                async loadData(){
                    const resp = await axios.get("/rest/approval/");
                    this.draftList.push(...resp.data);
                }
            },
            created(){
            	this.loadData();
            }
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>