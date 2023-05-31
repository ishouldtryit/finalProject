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
           <div>
               <table class="table table-hover">
                   <thead>
                       <tr>
                           <th class="col-xs-1">
	                           <span class="ms-3">
	                           	기안일자
	                           </span>
                           </th>
                           <th class="col-xs-1">긴급</th>
                           <th class="col-xs-3">제목</th>
                           <th class="col-xs-2">기안자</th>
                           <th class="col-xs-2">현재 결재자</th>
                           <th class="col-xs-2">최종 결재자</th>
                           <th class="col-xs-1">결재상태</th>
                       </tr>
                   </thead>
                   <tbody v-for="(approval, index) in ApprovalWithPageVO.approvalDataVO">
                       <tr>
                           <td>
	                           <span class="ms-3">
		                           {{approval.approvalWithDrafterDto.draftDateForm}}
	                           </span>
                           </td>
                           <td>
                           	<span class="badge bg-primary" v-if="approval.approvalWithDrafterDto.isemergency == 1">긴급</span>
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
							  <span v-if="approval.approvalWithDrafterDto.resultCode === 0" class="badge bg-success">
							    진행중
							    {{ approval.approvalWithDrafterDto.statusCode }}/{{ approval.approverList.length }}
							  </span>
							  <span v-else-if="approval.approvalWithDrafterDto.resultCode === 1" class="badge bg-info">
							    회수
							  </span>
							  <span v-else-if="approval.approvalWithDrafterDto.resultCode === 2" class="badge bg-danger">
							    반려
							  </span>
							  <span v-else-if="approval.approvalWithDrafterDto.resultCode === 3" class="badge bg-secondary">
							    완료
							  </span>
							</td>
                       </tr>
                   </tbody>
               </table>
           </div>
       </div>
       <div>
       
       </div>
		  	<div class="d-flex align-items-center justify-content-center">
		  		<div class="d-flex">
				  <ul class="pagination">
				    <li class="page-item disabled">
				      <span class="page-link" >
						<i class="fa-solid fa-angles-left"></i>
						</span>
				    </li>
				    <li class="page-item disabled">
				      <span class="page-link" >
						<i class="fa-solid fa-angle-left"></i>
						</span>
				    </li>
				    
      <li
        v-for="page in getViewBlockRange"
        :key="page"
        :class="{'page-item': true, 'active': page === ApprovalWithPageVO.paginationVO.page}"
        @click="move(page)"
        >
        <span class="page-link">{{ page }}</span>
      </li>

				    <li class="page-item">
				      <span class="page-link">
						<i class="fa-solid fa-angle-right"></i>
						</span>
				    </li>
				    <li class="page-item">
				      <span class="page-link">
				      	<i class="fa-solid fa-angles-right"></i>
						</span>
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
                	ApprovalWithPageVO : {
                		
                	},
                };
            },
            computed:{
            	 getViewBlockRange() {
            	      const viewBlock = this.ApprovalWithPageVO.paginationVO.viewBlock;
            	      const startBlock = this.ApprovalWithPageVO.paginationVO.startBlock;
            	      const currentPage = this.ApprovalWithPageVO.paginationVO.page;
            	      const endBlock = startBlock + viewBlock - 1;

            	      const range = [];
            	      for (let i = startBlock; i <= endBlock; i++) {
            	        range.push(i);
            	      }
            	      return range;
            	    }
            	  
            },
            methods:{
                async loadData(){
                    const resp = await axios.get("/rest/approval/list");
                    this.ApprovalWithPageVO = resp.data;
                },
                async move(page) {
                	 this.ApprovalWithPageVO.paginationVO.page = page;
                	  const resp = await axios.post("/rest/approval/moveList", this.ApprovalWithPageVO.paginationVO);
                	  this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                	  this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
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