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

    <div class="container-fluid">
       <div class="row mb-3">
           <h3>기안서 목록</h3>
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
                            <tbody v-for="(approval, index) in approvalDataVO">
                                <tr>
                                    <td>{{approval.approvalWithDrafterDto.draftNo}}</td>
                                    	<td @click="goToDetail(approval.approvalWithDrafterDto.draftNo)"  class="pointable">
                                    	
                                    	{{approval.approvalWithDrafterDto.draftTitle}}
                                    	
                                    	</td>
                                    <td>{{approval.approvalWithDrafterDto.empName}}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
		  	<div class="d-flex align-items-center justify-content-center">
		  		<div class="d-flex">
				  <ul class="pagination">
				    <li class="page-item disabled">
				      <a class="page-link" href="#">&laquo;</a>
				    </li>
				    <li class="page-item active">
				      <a class="page-link" href="#">1</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">2</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">3</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">4</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">5</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">&raquo;</a>
				    </li>
				  </ul>
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
                	approvalDataVO : [],
                };
            },
            computed:{

            },
            methods:{
                async loadData(){
                    const resp = await axios.get("/rest/approval/list");
                    this.approvalDataVO.push(...resp.data);
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