<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	.approvalInfo-container {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 9999;
	}
</style>

<div id="app">
	<div class="container-fluid" v-if="ApprovalDataVO.approverList.length > 0">
		<div class="row mb-3 d-flex align-items-center"> 
			<div class="col">
			  <h3 style="margin:0;">기안서 상세 보기</h3>
			  </div>

		</div>
		<div class="row mb-3">
			<div class="col">
				<button type="button" class="btn btn-outline-info ms-2" v-if="isDrafterAndWaitApproval" @click="showApprovalRecallModal">
					<i class="fa-solid fa-circle-xmark"></i>
					상신 취소
				</button>
				<button type="button" class="btn btn-outline-info ms-2" v-if="isApprover">
					<i class="fa-solid fa-pen-to-square"></i>
					결재
				</button>
				<button type="button" class="btn btn-outline-info ms-2" v-if="isApprover">
					<i class="fa-solid fa-share fa-rotate-180"></i>
					반려
				</button>
				<button type="button" class="btn btn-outline-info ms-2" v-if="isDrafterAndIsRecall" >
					<i class="fa-solid fa-user-pen"></i>
					문서 수정
				</button>
				<button type="button" class="btn btn-outline-info ms-2" v-if="isDrafterAndIsRecall" @click="showReApprovalModal">
					<i class="fa-solid fa-pen-to-square"></i>
					재기안
				</button>
				<button type="button" class="btn btn-outline-info ms-2" @click="showApprovalInfoModal">
					<i class="fa-solid fa-circle-exclamation"></i>
					결재 정보
				</button>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<div class="card border-secondary mb-3" style="min-height: 30rem;">
					  <div class="card-header">
						  제목 : {{ApprovalDataVO.approvalWithDrafterDto.draftTitle}}
					  </div>
					  <div class="card-body">
					    	{{ApprovalDataVO.approvalWithDrafterDto.draftContent}}
					    	
					  </div>
			  </div>
		  </div>
		</div>
		
	</div>
	
	<!-- 결재 정보 modal -->
	<div class="modal" tabindex="-1" role="dialog" ref="approvalInfoModal"  >
        <div class="modal-dialog modal-dialog-centered modal-md" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">결재 정보</h5>
                </div>
                <div class="modal-body">
                	<div class="container-fluid" style="overflow-y: scroll; height:300px;">
                		<div class="row">
                			<h6>결재자</h6>
                		</div>
              			<div class="row" v-for="(approver, index) in ApprovalDataVO.approverList">
       						<div class="col">
			       				<div class="badge bg-danger w-100">
			       					{{index+1}}.{{approver.deptName}} : {{approver.empName}}.{{approver.jobName}}
			       				</div>
       						</div>
      					</div>  	
      					<div class="row mt-3">
                			<h6>참조자</h6>
                		</div>
              			<div class="row" v-for="(recipient, index) in ApprovalDataVO.recipientList">
       						<div class="col">
			       				<div class="badge bg-success w-100">
			       					{{index+1}}.{{recipient.deptName}} : {{recipient.empName}}.{{recipient.jobName}}
			       				</div>
       						</div>
      					</div>  
      					<div class="row mt-3">
                			<h6>열람자</h6>
                		</div>      						
              			<div class="row" v-for="(reader, index) in ApprovalDataVO.readerList">
       						<div class="col">
			       				<div class="badge bg-secondary w-100">
			       					{{index+1}}.{{reader.deptName}} : {{reader.empName}}.{{reader.jobName}}
			       				</div>
       						</div>
      					</div>  	
      				</div>  	
              		
                </div>
                	
                <div class="modal-footer">
                	<div class="row">
                    <button type="button" class="btn btn-secondary ml-auto ms-2" data-bs-dismiss="modal" @click="hideApprovalInfoModal">닫기</button>
                    </div>
                </div>
            </div>
           </div>
       </div>
   
	<!-- 상신 취소 modal -->
	<div class="modal" tabindex="-1" role="dialog" ref="approvalRecallModal"  >
        <div class="modal-dialog modal-dialog-centered modal-md" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">상신 취소</h5>
                </div>
                <div class="modal-body">
                	<div class="container-fluid" >
                		<div class="row">
                			<h5 class="text-primary">정말 상신 취소하시겠습니까??</h5>
                		</div>
      				</div>  	
                </div>
                	
                <div class="modal-footer">
                	<div class="row">
	                	<div class="col">
	                  	  <button type="button" class="btn btn-danger ms-2" data-bs-dismiss="modal" @click="approvalRecall">확인</button>
	                  	  <button type="button" class="btn btn-secondary  ms-2" data-bs-dismiss="modal" @click="hideApprovalRecallModal">닫기</button>
	                	</div>
                    </div>
                </div>
            </div>
           </div>
       </div>
   
	<!-- 재기안 modal -->
	<div class="modal" tabindex="-1" role="dialog" ref="reApprovalModal"  >
        <div class="modal-dialog modal-dialog-centered modal-md" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">재기안</h5>
                </div>
                <div class="modal-body">
                	<div class="container-fluid" >
                		<div class="row">
                			<h5 class="text-primary">정말 재기안 하시겠습니까??</h5>
                		</div>
      				</div>  	
                </div>
                	
                <div class="modal-footer">
                	<div class="row">
	                	<div class="col">
	                  	  <button type="button" class="btn btn-danger ms-2" data-bs-dismiss="modal" @click="reApproval">확인</button>
	                  	  <button type="button" class="btn btn-secondary ms-2" data-bs-dismiss="modal" @click="hideReApprovalModal">닫기</button>
	                	</div>
                    </div>
                </div>
            </div>
           </div>
       </div>
       
   </div>            
	
	
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  Vue.createApp({
    data() {
      return {
    	  ApprovalDataVO : {
    		  agreeorList : [],
    		  approverList : [],
    		  readerList : [],
    		  recipientList : [],
    		  loginUser : "",
    		  approvalWithDrafterDto : {},
    	  },
    	  approvalInfoModal : null,
    	  approvalRecallModal : null,
    	  reApprovalModal : null,
    	  
      }
    },
    
    computed: {
        isApprover() { //로그인 유저가 결재대상자인지 검사, 회수 상태검사
        	const loginUser = this.ApprovalDataVO.loginUser; // 로그인한 사용자 정보
            const approverList = this.ApprovalDataVO.approverList; // 결재자 목록
            const approverOrder = this.ApprovalDataVO.approvalWithDrafterDto.resultCode; //결재 순서
            const isRecall = this.ApprovalDataVO.approvalWithDrafterDto.resultCode == 1; //회수 상태
        	     if (approverList[approverOrder].approverNo === loginUser && !isRecall) { // approverNo와 loginUser가 일치한다면 true
        	         return true; 
        	       }
	            return false;
          },
          isDrafterAndWaitApproval(){//작성자인지, 결재진행중인지 검사
        	  const drafterNo = this.ApprovalDataVO.approvalWithDrafterDto.drafterNo; //작성자 아이디
        	  const loginUser = this.ApprovalDataVO.loginUser; //로그인 유저
        	  const waitApproval = this.ApprovalDataVO.approvalWithDrafterDto.statusCode == 0; //결재 대기 중
        	  const approving = this.ApprovalDataVO.approvalWithDrafterDto.resultCode == 0; //결재 진행 중
        	  return drafterNo === loginUser && waitApproval && approving;
          },
          isDrafterAndIsRecall(){//작성자인지, 회수 상태 검사
        	  const drafterNo = this.ApprovalDataVO.approvalWithDrafterDto.drafterNo; //작성자 아이디
        	  const loginUser = this.ApprovalDataVO.loginUser; //로그인 유저
        	  const isRecall = this.ApprovalDataVO.approvalWithDrafterDto.resultCode == 1; //회수 상태
        	  return drafterNo === loginUser && isRecall;
          },
    },
    
    methods: {
        async loadData(){
            const urlParams = new URLSearchParams(window.location.search);
            const draftNo = urlParams.get("draftNo");
            
            const resp = await axios.get("/rest/approval/detail/"+draftNo);
            this.ApprovalDataVO = Vue.readonly(resp.data); //개발툴에서 조작 금지
        },
        
        showApprovalInfoModal(){	//결재정보 모달 보이기
        	this.approvalInfoModal.show();
        },
        hideApprovalInfoModal(){	//결재정보 모달 숨기기
        	this.approvalInfoModal.hide();
        },
        showApprovalRecallModal(){	//상신취소 모달 보이기
        	this.approvalRecallModal.show();
        },
        hideApprovalRecallModal(){	//상신취소 모달 숨기기
        	this.approvalRecallModal.hide();
        },
        showReApprovalModal(){	//재기안 모달 보이기
        	this.reApprovalModal.show();
        },
        hideReApprovalModal(){	//재기안 모달 숨기기
        	this.reApprovalModal.hide();
        },
        async approvalRecall(){	//문서 회수
            const urlParams = new URLSearchParams(window.location.search);
            const draftNo = urlParams.get("draftNo");
            const resp = await axios.patch("/rest/approval/detail/recall/"+draftNo);
            location.reload();
        },
        
        async reApproval(){	//재기안
            const urlParams = new URLSearchParams(window.location.search);
            const draftNo = urlParams.get("draftNo");
            const resp = await axios.patch("/rest/approval/detail/reApproval/"+draftNo);
            location.reload();        	
        },

    },
    
    mounted(){
    	this.approvalInfoModal = new bootstrap.Modal(this.$refs.approvalInfoModal);
    	this.approvalRecallModal = new bootstrap.Modal(this.$refs.approvalRecallModal);
    	this.reApprovalModal = new bootstrap.Modal(this.$refs.reApprovalModal);
    },
    created() {
      this.loadData();
    },
  }).mount("#app");
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>