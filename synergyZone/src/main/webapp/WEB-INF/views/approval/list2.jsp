<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .pointable {
    cursor: pointer;
  }
</style>
<div id="app">

    <div class="container">

		<div class="row mt-4">
                    <div class="col">
                        <h2>기안서 목록</h2>
                    </div>
                 </div>
                <div class="row mt-4">
                    <div class="col">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                </tr>
                            </thead>
                            <tbody v-for="(draft, index) in draftList" :key="draft.draftNo">
                                <tr>
                                    <td>{{draft.draftNo}}</td>
                                    	<td @click="goToDetail(draft.draftNo)"  class="pointable">
                                    	
                                    	{{draft.draftTitle}}
                                    	
                                    	</td>
                                    <td>{{draft.drafterId}}</td>
                                </tr>
                            </tbody>
                        </table>
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
                },
                goToDetail(draftNo) {
                    window.location.href = 'detail?draftNo=' + draftNo;
                },
            },
            created(){
            	this.loadData();
            }
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>