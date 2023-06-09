<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .pointable {
    cursor: pointer;
  }
    .profileImage {
    width: 200px;
    height: auto;
    object-fit: contain;
    max-width: 100%;
    max-height: 100%;
  }
  
</style>
<div id="app">

    <div class="container-fluid" v-if="ApprovalWithPageVO != null">
     	<div class="row">
    	<div class="col-10 offset-sm-1">         
       <div class="row mb-3">
           <h3>나의 기안서 목록</h3>
       </div>
       <div class="row mb-3">
             <div class="col-2" style=" width:150px;">
                <select class="form-select" style="width:150px;" v-model="ApprovalWithPageVO.paginationVO.column">
                   <option value="draft_title">제목</option>
                   <option value="emp_name">기안자</option>
                </select>
             </div>
          <div class="input-group mb-3 ms-3 col-1" style="width:300px;">
            <input type="search" class="form-control" placeholder="검색어" v-model="ApprovalWithPageVO.paginationVO.keyword" @keyup.enter="changeSearchPage">
            <button class="btn btn-info" type="button" @click="changeSearchPage">검색</button>
          </div>
          <div class="ms-3 col">
            <button class="btn btn-info" type="button" @click="allList">
            <i class="fa-solid fa-list-ul"></i>
             전체 목록
            </button>
          </div>
       </div>
       <div class="row mb-2 d-flex align-items-center">
             <div class="col-11 d-flex">
                <div class="btn-group" role="group">
                      <button type="button" 
                      class="btn" :class="{'btn-secondary': pageStatus != 'allPage', 'btn-info': pageStatus == 'allPage'}"
                      @click ="changeAllPage">
                    전체
                  </button>
                      <button type="button" 
                      class="btn" :class="{'btn-secondary': pageStatus != 'ingPage', 'btn-info': pageStatus == 'ingPage'}"
                      @click ="changeIngPage">
                    진행
                  </button>
                      <button type="button" 
                      class="btn" :class="{'btn-secondary': pageStatus != 'recallPage', 'btn-info': pageStatus == 'recallPage'}"
                      @click ="changeRecallPage">
                    회수
                  </button>
                      <button type="button" 
                      class="btn" :class="{'btn-secondary': pageStatus != 'returnPage', 'btn-info': pageStatus == 'returnPage'}"
                      @click ="changeReturnPage">
                    반려
                  </button>
                      <button type="button" 
                      class="btn" :class="{'btn-secondary': pageStatus != 'endPage', 'btn-info': pageStatus == 'endPage'}"
                      @click ="changeEndPage">
                    완료
                  </button>
               </div>   
                   <button type="button" 
                      class="btn ms-3" :class="{'btn-secondary': !isemergency, 'btn-info': isemergency }"
                      @click ="changeEmergencyPage">
                    긴급
                  </button>
               </div>      
                   <div class="col-1 d-flex">
                    <select class="form-select" style="width:100px;" v-model="ApprovalWithPageVO.paginationVO.size" @change="changeSize">
                      <option value="10">10</option>
                      <option value="20">20</option>
                      <option value="30">30</option>
                      <option value="40">40</option>
                      <option value="50">50</option>
                    </select>
                </div>    
             </div>
       <div class="row mt-4">
           <div>
               <table class="table table-hover">
                   <thead>
                       <tr class="col-12">
                           <th class="col-md-1">
                              <span class="ms-3">
                                 기안일자
                              </span>
                           </th>
                           <th class="col-1">긴급</th>
                           <th class="col-3">제목</th>
                           <th class="col-2">기안자</th>
                           <th class="col-2">현재 결재자</th>
                           <th class="col-2">최종 결재자</th>
                           <th class="col-1">결재상태</th>
                       </tr>
                   </thead>
                  <tbody v-if="ApprovalWithPageVO.approvalDataVO.length === 0">
                 <tr>
                   <td colspan="7" class="text-center">문서가 없습니다.</td>
                 </tr>
               </tbody>
               <tbody v-else>
                       <tr v-for="(approval, index) in ApprovalWithPageVO.approvalDataVO">
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
                           <td>
	                           <span class="pointable" @click="showDrafterInfoModal(index)">
	                           		{{approval.approvalWithDrafterDto.empName}}
	                           </span>
                           </td>
							<td v-if="approval.approvalWithDrafterDto.statusCode === approval.approverList.length">
							  -
							</td>
							<td v-else>
								<span class="pointable"  @click="showNowApproverInfoModal(index)">
								  {{ approval.approverList[approval.approvalWithDrafterDto.statusCode].empName }}
								</span>
							</td>
                           <td>
	                           	<span class="pointable"  @click="showFinalApproverInfoModal(index)">
	                              {{ approval.approverList[approval.approverList.length - 1].empName }}
	                           	</span>
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
           </div>
       </div>
       <div>
       
       </div>
           <div class="d-flex align-items-center justify-content-center mt-4">
              <div class="d-flex">
              <ul class="pagination">
                <li class="page-item" @click="firstMove"  :class="{ 'disabled': ApprovalWithPageVO.paginationVO.page == 1 }">
                  <span class="page-link" >
                  <i class="fa-solid fa-angles-left"></i>
                  </span>
                </li>
                <li class="page-item" @click="prevMove" :class="{ 'disabled': !ApprovalWithPageVO.paginationVO.prev }">
                  <span class="page-link" >
                  <i class="fa-solid fa-angle-left"></i>
                  </span>
                </li>
                
                <li 
                  v-for="(page, index) in ApprovalWithPageVO.paginationVO.viewBlock"
                  :key="index"
                  :class="{'page-item': true, 'active': ApprovalWithPageVO.paginationVO.startBlock + index === ApprovalWithPageVO.paginationVO.page}"
                  @click="move(ApprovalWithPageVO.paginationVO.startBlock + index)"
                  >
                  <span class="page-link">{{ ApprovalWithPageVO.paginationVO.startBlock + index }}</span>
                </li>

                <li class="page-item" @click="nextMove" :class="{ 'disabled': !ApprovalWithPageVO.paginationVO.next }">
                  <span class="page-link">
                  <i class="fa-solid fa-angle-right"></i>
                  </span>
                </li>
                <li class="page-item" @click="finishMove" :class="{ 'disabled': ApprovalWithPageVO.paginationVO.page == ApprovalWithPageVO.paginationVO.totalPage }">
                  <span class="page-link">
                     <i class="fa-solid fa-angles-right"></i>
                  </span>
                </li>
              </ul>
            </div>
         </div>   
        </div>
        
        	<!-- 기안자 회원 정보 modal -->
	<div class="modal" tabindex="-1" role="dialog" ref="drafterInfoModal"  >
        <div class="modal-dialog modal-dialog-centered modal-md" role="document" >
           <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="employeeModalLabel"></h5>
		        
		     <div class="profile-image">
			    <img class="profileImage" height="auto" :src="getAttachmentUrl(ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.attachmentNo)" alt="프로필 이미지">
			</div>
			
			  <div class="modal-body">
		        <p><strong>사원번호 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.drafterNo}}</span></p>
		        <p><strong>이름 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.empName}}</span></p>
		        <p><strong>전화번호 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.empPhone}}</span></p>
		        <p><strong>이메일 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.empEmail}}</span></p>
		        <p><strong>주소 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.empAddress}}</span></p>
		        <p><strong>상세주소 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.empDetailAddress}}</span></p>
		        <p><strong>부서 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.deptName}}</span></p> 
		        <p><strong>직위 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.jobName}}</span></p> 
		        <!-- 정보 추가 가능 -->
		      </div>
      
		      </div>
		      <div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="hideDrafterInfoModal">닫기</button>	      
	            </div>
		    </div>
          </div>
      </div>
      
        	<!-- 현재 결재자 회원 정보 modal -->
	<div class="modal" tabindex="-1" role="dialog" ref="nowApproverInfoModal"  >
        <div class="modal-dialog modal-dialog-centered modal-md" role="document" >
           <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="employeeModalLabel"></h5>
		        
		     <div class="profile-image">
			    <img class="profileImage" height="auto" :src="getAttachmentUrl(ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].attachmentNo)" alt="프로필 이미지">
			</div>
			
			  <div class="modal-body">
		        <p><strong>사원번호 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].empNo}}</span></p>
		        <p><strong>이름 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].empName}}</span></p>
		        <p><strong>전화번호 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].empPhone}}</span></p>
		        <p><strong>이메일 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].empEmail}}</span></p>
		        <p><strong>주소 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].empAddress}}</span></p>
		        <p><strong>상세주소 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].empDetailAddress}}</span></p>
		        <p><strong>부서 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].deptName}}</span></p> <!-- 부서 정보를 표시할 곳 -->
		        <p><strong>직위 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approvalWithDrafterDto.statusCode].jobName}}</span></p> <!-- 직위 정보를 표시할 곳 -->
		        <!-- 정보 추가 가능 -->
		      </div>
      
		      </div>
		      <div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="hideNowApproverInfoModal">닫기</button>	      
	            </div>
		    </div>
          </div>
      </div>
        	<!-- 최종 결재자 회원 정보 modal -->
	<div class="modal" tabindex="-1" role="dialog" ref="finalApproverInfoModal"  >
        <div class="modal-dialog modal-dialog-centered modal-md" role="document" >
           <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="employeeModalLabel"></h5>
		        
		     <div class="profile-image">
			    <img class="profileImage" :src="getAttachmentUrl(ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].attachmentNo)" alt="프로필 이미지">
			</div>
			
			  <div class="modal-body">
		        <p><strong>사원번호 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].empNo}}</span></p>
		        <p><strong>이름 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].empName}}</span></p>
		        <p><strong>전화번호 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].empPhone}}</span></p>
		        <p><strong>이메일 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].empEmail}}</span></p>
		        <p><strong>주소 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].empAddress}}</span></p>
		        <p><strong>상세주소 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].empDetailAddress}}</span></p>
		        <p><strong>부서 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].deptName}}</span></p> 
		        <p><strong>직위 :</strong> <span>{{ApprovalWithPageVO.approvalDataVO[empTarget].approverList[ApprovalWithPageVO.approvalDataVO[empTarget].approverList.length - 1].jobName}}</span></p>
		        <!-- 정보 추가 가능 -->
		      </div>
      
		      </div>
		      <div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" @click="hideFinalApproverInfoModal">닫기</button>	      
	            </div>
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
                   ApprovalWithPageVO : null,
                   pageStatus : "allPage",
                   isemergency : false,
                   empInfoModal : null,
                   empTarget : 0,
                };
            },
            computed:{
                 
            },
            methods:{
                async loadData(){
                    const resp = await axios.get("/rest/approval/myList");
                    this.ApprovalWithPageVO = resp.data;
                },
                
                async allList(){ //전체 목록 호출
                	await this.loadData();	
                	this.pageStatus = "allPage";
                },
                
                //페이지 이동
                async move(page) {
                    this.ApprovalWithPageVO.paginationVO.page = page;
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                     const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                     this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                     this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                  },
                  
                //페이지 prev 이동
                async prevMove() {
                     if(!this.ApprovalWithPageVO.paginationVO.prev) return;
                     this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = this.ApprovalWithPageVO.paginationVO.prevPage;
                     const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                     this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                     this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                  },
                  
                //페이지 next 이동
                async nextMove() {
                        if(!this.ApprovalWithPageVO.paginationVO.next) return;
                    this.ApprovalWithPageVO.paginationVO.page = this.ApprovalWithPageVO.paginationVO.nextPage;
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                     const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                     this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                     this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                  },
                  
                //첫 페이지 이동
                async firstMove() {
                     if(this.ApprovalWithPageVO.paginationVO.page == 1) return;
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                     const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                     this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                     this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                  },
                  
                //마지막 페이지 이동
                async finishMove() {
                        if(this.ApprovalWithPageVO.paginationVO.page == this.ApprovalWithPageVO.paginationVO.totalPage) return;
                    this.ApprovalWithPageVO.paginationVO.page = this.ApprovalWithPageVO.paginationVO.totalPage;
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                     const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                     this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                     this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                  },
                  
            //표시 갯수(count) 변경
                  async changeSize() {
                      this.ApprovalWithPageVO.paginationVO.page = 1;
                      this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                     const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                     this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                     this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                  },
                  
             //상세페이지 이동
                goToDetail(draftNo) {
                    window.location.href = "detail?draftNo=" + draftNo;
                },
                
                //전체 항목 조회
                async changeAllPage() {
                  if(this.pageStatus === "allPage") return;
                  this.pageStatus = "allPage";
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                    this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                    this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                },
                
                //긴급 항목우선 조회
                async changeEmergencyPage() {
                  if(this.isemergency) {
                     this.isemergency = false;
                  }
                  else{
                  this.isemergency = true;
                  }
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.isemergency = this.isemergency; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                    this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                    this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                },
                
                //진행 항목만 조회
                async changeIngPage() {
                  if(this.pageStatus === "ingPage") return;
                  this.pageStatus = "ingPage";
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                    this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                    this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                },
                
                //회수 항목만 조회
                async changeRecallPage() {
                  if(this.pageStatus === "recallPage") return;
                  this.pageStatus = "recallPage";
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                    this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                    this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                },
                
                //반려 항목만 조회
                async changeReturnPage() {
                  if(this.pageStatus === "returnPage") return;
                  this.pageStatus = "returnPage";
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                    this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                    this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                },
                
                //완료 항목만 조회
                async changeEndPage() {
                  if(this.pageStatus === "endPage") return;
                  this.pageStatus = "endPage";
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                    this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                    this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                },
                
                // 검색 조회
                async changeSearchPage() {
                    this.ApprovalWithPageVO.paginationVO.pageStatus = this.pageStatus; // pageStatus 추가
                    this.ApprovalWithPageVO.paginationVO.page = 1;
                    const resp = await axios.post("/rest/approval/myMoveList", this.ApprovalWithPageVO.paginationVO);
                    this.ApprovalWithPageVO = {}; // 기존 데이터 비우기
                    this.ApprovalWithPageVO = resp.data; // 새로운 데이터 추가
                },
                
                showDrafterInfoModal(index){	//기안자 정보 모달 보이기
                	this.drafterInfoModal.show();
                	this.empTarget = index;
                },
                
                hideDrafterInfoModal(){	//기안자 정보 모달 숨기기
                	this.drafterInfoModal.hide();
                },
                
                showNowApproverInfoModal(index){	//현재 결재자 정보 모달 보이기
                	this.nowApproverInfoModal.show();
                	this.empTarget = index;
                },
                
                hideNowApproverInfoModal(){	//현재 결재자정보 모달 숨기기
                	this.nowApproverInfoModal.hide();
                },
                
                showFinalApproverInfoModal(index){	//최종 결재자 정보 모달 보이기
                	this.finalApproverInfoModal.show();
                	this.empTarget = index;
                },
                
                hideFinalApproverInfoModal(){	//최종 결재자 정보 모달 숨기기
                	this.finalApproverInfoModal.hide();
                },
                getAttachmentUrl(attachmentNo) { //프로필 사진 주소
                    if (attachmentNo === null) {
                      return "/static/img/dummydog.jpg";
                    } else {
                      return "/attachment/download?attachmentNo=" + attachmentNo;
                    }
                 },
            },
            
            created(){
               this.loadData();
            },
            updated(){
                this.drafterInfoModal = new bootstrap.Modal(this.$refs.drafterInfoModal);
                this.nowApproverInfoModal = new bootstrap.Modal(this.$refs.nowApproverInfoModal);
                this.finalApproverInfoModal = new bootstrap.Modal(this.$refs.finalApproverInfoModal);

             },            
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>