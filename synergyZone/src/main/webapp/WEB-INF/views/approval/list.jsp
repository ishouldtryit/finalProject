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

	<!-- 강사 임시주석 -->
    <div class="container-fluid">
       <div class="row mb-3">
           <h3>기안서 목록</h3>
       </div>
       <div class="row mt-4">
           <div class="col">
               <table class="table table-hover">
                   <thead>
                       <tr>
                           <th>기안일자</th>
                           <th>긴급</th>
                           <th>제목</th>
                           <th>기안자</th>
                           <th>현재 결재자</th>
                           <th>최종 결재자</th>
                           <th>결재상태</th>
                       </tr>
                   </thead>
                   <tbody v-for="(approval, index) in approvalDataVO">
                       <tr>
                           <td>{{approval.approvalWithDrafterDto.draftDate}}</td>
                           <td>
                           	<span class="border border-primary text-primary" v-if="approval.approvalWithDrafterDto.isemergency == 1">긴급</span>
                           </td>
                           	<td @click="goToDetail(approval.approvalWithDrafterDto.draftNo)"  class="pointable">
                           	
                           	{{approval.approvalWithDrafterDto.draftTitle}}
                           	
                           	</td>
                           <td>{{approval.approvalWithDrafterDto.empName}}</td>
                           <td>
                           		{{ approval.approverList[approval.approvalWithDrafterDto.statusCode].empName }}
                           </td>
                           <td>
	                           {{ approval.approverList[approval.approverList.length - 1].empName }}
                           </td>
                           <td>
                           	<span class="border border-primary text-primary" >진행중</span>
                           </td>
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
                testObject(list) {
                	console.log(list[0]);
                	return "test";
                }
            },
            created(){
            	this.loadData();
            }
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>