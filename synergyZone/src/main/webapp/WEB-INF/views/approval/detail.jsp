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
	<div class="container-fluid" v-if="ApprovalDataVO != null">
		<div class="row mb-3 d-flex align-items-center"> 
			<div class="col">
			  <h3 style="margin:0;">기안서 상세 보기</h3>
			  </div>

		</div>
		<div class="row mb-3">
			<div class="col">
				<button type="button" class="btn btn-outline-info" v-if="isDrafterAndWaitApproval">
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
				<button type="button" class="btn btn-outline-info ms-2" v-if="isDrafterAndWaitApproval" >
					<i class="fa-solid fa-user-pen"></i>
					문서 수정
				</button>
				<button type="button" class="btn btn-outline-info ms-2">
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  Vue.createApp({
    data() {
      return {
    	  ApprovalDataVO : null,
      }
    },
    
    computed: {
        isApprover() { //로그인 유저가 결재대상자인지 검사, 회수 상태검사
        	const loginUser = this.ApprovalDataVO.loginUser; // 로그인한 사용자 정보
            const approverList = this.ApprovalDataVO.approverList; // 결재자 목록
            const approverOrder = this.ApprovalDataVO.approvalWithDrafterDto.resultCode; //결재 순서
            const isRecall = this.ApprovalDataVO.approvalWithDrafterDto.statusCode == 1; //회수 상태
        	     if (approverList[approverOrder].approverNo === loginUser && !isRecall) { // approverNo와 loginUser가 일치한다면 true
        	         return true; 
        	       }
	            return false;
          },
          isDrafterAndWaitApproval(){//작성자인지, 결재진행중인지 검사
        	  const drafterNo = this.ApprovalDataVO.approvalWithDrafterDto.drafterNo; //작성자 아이디
        	  const loginUser = this.ApprovalDataVO.loginUser; //로그인 유저
        	  const waitApproval = this.ApprovalDataVO.approvalWithDrafterDto.resultCode == 0; //결재 대기 중
        	  return drafterNo === loginUser && waitApproval;
          }
    },
    
    methods: {
        async loadData(){
            const urlParams = new URLSearchParams(window.location.search);
            const draftNo = urlParams.get("draftNo");
            
            const resp = await axios.get("/rest/approval/detail/"+draftNo);
            this.ApprovalDataVO = resp.data;
        },
        

    },
    
    mounted(){
    },
    created() {
      this.loadData();
    },
  }).mount("#app");
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>