<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.custom-list-item {
	  list-style-type: none; /* 리스트 스타일 제거 */
	}
	.duplicate-alert-container {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 9999;
	}
	.btn{
	width: 120px;
	}
	ul li span, .form-check-input, .form-check-label {
    cursor: pointer;
  }
</style>


<div id="app">
	<div class="container-fluid">
	     	<div class="row">
    	<div class="col-10 offset-sm-1">  
		<div class="row mb-3"> 
			<div class="col">
			  <h3>기안서 수정</h3>
			</div>
		</div>
	  <div class="row mb-2">
	  	<div class="col-4">
		   	<button type="button" class="btn mb-2" :class="ApprovalDataVO.approverList.length ? 'btn-info' : 'btn-secondary'" @click="showApproverModal">
		  		{{ ApprovalDataVO.approverList.length ? '결재자 정보' : '결재자 추가' }}
			</button>
		   	<button type="button" class="btn ms-3 mb-2" :class="ApprovalDataVO.recipientList.length ? 'btn-info' : 'btn-secondary'" @click="showRecipientModal">
		  		{{ ApprovalDataVO.recipientList.length ? '참조자 정보' : '참조자 추가' }}
			</button>
		   	<button type="button" class="btn ms-3 mb-2" :class="ApprovalDataVO.readerList.length ? 'btn-info' : 'btn-secondary'" @click="showReaderModal">
		  		{{ ApprovalDataVO.readerList.length ? '열람자 정보' : '열람자 추가' }}
			</button>
	  	</div>
	  	<div class="col-2 d-flex align-items-center justify-content-center">
	  		<div class="form-check form-switch d-flex">
			  <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" :checked="ApprovalDataVO.approvalWithDrafterDto.isemergency === 1" @change="emergencyCheck">
			  <label class="form-check-label" for="flexSwitchCheckDefault">긴급 문서</label>
			</div>
	  	</div>
	  </div>
	  
	    <div class="row p-3" >
	      <label for="draftTitle" class="form-label">제목</label>
	      <input type="text" id="draftTitle" name="draftTitle" v-model="ApprovalDataVO.approvalWithDrafterDto.draftTitle" class="form-control" v-on:input="ApprovalDataVO.approvalWithDrafterDto.draftTitle = $event.target.value">
	    </div>
	    
	    <div class="row p-3">
	      <label for="draftContent" class="form-label">내용</label>
	      <textarea id="draftContent" name="draftContent" required style="min-height: 300px;" v-model="ApprovalDataVO.approvalWithDrafterDto.draftContent" class="form-control" v-on:input="ApprovalDataVO.approvalWithDrafterDto.draftContent = $event.target.value"></textarea>
	    </div>

	    <div class="row">
	    	<div class="col-10"></div>
	    	<div class="col-2">
			    <button class="btn" :class="{'btn-info': isDataComplete, 'btn-secondary': !isDataComplete}" type="button" @click="sendData">등록</button>
	    	</div>
	    </div>
        <div v-if="showApprovalNoDataAlert" class="duplicate-alert-container w-20">
	      <div class="alert alert-dismissible alert-primary">
	        <span>결재정보, 제목, 내용을 입력하세요</span>
	      </div>
	    </div>
	    </div>
	    </div>
  </div>
  
<!-- 결재자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="approverModal" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered  modal-lg" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">결재 정보 - 결재자</h5>
                </div>
                <div class="modal-body">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
	   	       		<div v-if="showDuplicateAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
						  <span>중복된 대상입니다.</span>
						</div>
					</div>
	   	       		<div v-if="showApproverNoDataAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
						  <span>먼저 결재자를 추가 하세요.</span>
						</div>
					</div>
	   	       		<div v-if="showApproverAddDataAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-success">
						  <span>저장되었습니다.</span>
						</div>
					</div>
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-4" style="overflow-y: scroll; height:400px;">
          						<div class="row mb-3 d-flex justify-content-center align-items-center">
	          						<div class="col-8 p-1" >
								      <input type="search" class="form-control " placeholder="이름" v-model="searchName" @keyup.enter="search">
	          						</div>
	          						<div class="col-2 border rounded" >
								      <span @click="search" style="cursor: pointer;" title="검색" class="d-flex justify-content-center align-items-center">
								      	<i class="fa-solid fa-magnifying-glass p-2"></i>
								      </span>
	          						</div>
	          						<div class="col-2 border rounded" >
								      <span @click="searchAll" style="cursor: pointer;" title="전체 목록" class="d-flex justify-content-center align-items-center">
								      	<i class="fa-solid fa-list p-2" ></i>
								      </span>
	          						</div>
          						</div>
			                      <ul style="margin:0; padding:0;">
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToAppoverList(employee, department)">
							              <img width="25" height="25"  class="rounded-circle" :src="getAttachmentUrl(employee.attachmentNo)" >
							              {{ employee.empName }}.{{ employee.jobName }}
							            </span>
							            </li>
							          </ul>
							        </li>
							      </ul>
							      <hr>
							      <ul style="margin:0; padding:0;">
							      	<li class="custom-list-item">
							      		<span>
											<i class="fa-regular fa-square-plus"></i>	      	
									          자주쓰는 결재선
							      		</span>
							      	</li>
							      </ul>
							     </div>
       							<div class="col-8" style="overflow-y: scroll; height:400px;">
	       							<div class="row mb-1">
		       							<div class="col-6 text-center">
		       								결재 순서
		       							</div>
		       							<div class="col-4 text-center">
		       								순서 변경
		       							</div>
		       							<div class="col-2 text-center">
		       								제거
		       							</div>
		       						</div>
       								<div class="row" v-for="(approver, index) in approverList">
	       									<div class="col-6">
				       							<div class="badge bg-danger w-100">
				       								{{index+1}}.{{approver.department.deptName}} : {{approver.approverList.empName}}.{{ approver.approverList.jobName }}
				       							</div>
	       									</div>
	       									<div class="col-2 text-center" >
				       							<i class="fa-regular fa-circle-up" @click="approverMoveUp(index)"></i>
	       									</div>
	       									<div class="col-2 text-center" >
					       						<i class="fa-regular fa-circle-up fa-rotate-180" @click="approverMoveDown(index)"></i>
	       									</div>
	       									<div class="col-2 text-center" >
					       						<i class="fa-regular fa-trash-can" @click="removeApprover(index)"></i>
	       									</div>
       								</div>
       							</div>
   							</div>
						</div>
	                </div>
                <div class="modal-footer">
                	<div class="row">
                    	<button type="button" class="btn" :class="approverList.length ? 'btn-info' : 'btn-secondary'"  @click="saveApproverList">저장</button>
                    	<button type="button" class="btn btn-secondary ml-auto ms-2" data-bs-dismiss="modal" @click="hideApproverModal">닫기</button>
                    </div>
                </div>
            </div>      

        </div>

</div>
<!-- 참조자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="recipientModal" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered  modal-lg" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">결재 정보 - 참조자</h5>
                </div>
                <div class="modal-body">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
	   	       		<div v-if="showDuplicateAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
						  <span>중복된 대상입니다.</span>
						</div>
					</div>
	   	       		<div v-if="showRecipientNoDataAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
						  <span>먼저 참조자를 추가 하세요.</span>
						</div>
					</div>
	   	       		<div v-if="showRecipientAddDataAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-success">
						  <span>저장되었습니다.</span>
						</div>
					</div>
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-4" style="overflow-y: scroll; height:400px;">
          						<div class="row mb-3 d-flex justify-content-center align-items-center">
	          						<div class="col-8 p-1" >
								      <input type="search" class="form-control " placeholder="이름" v-model="searchName" @keyup.enter="search">
	          						</div>
	          						<div class="col-2 border rounded" >
								      <span @click="search" style="cursor: pointer;" title="검색" class="d-flex justify-content-center align-items-center">
								      	<i class="fa-solid fa-magnifying-glass p-2"></i>
								      </span>
	          						</div>
	          						<div class="col-2 border rounded" >
								      <span @click="searchAll" style="cursor: pointer;" title="전체 목록" class="d-flex justify-content-center align-items-center">
								      	<i class="fa-solid fa-list p-2" ></i>
								      </span>
	          						</div>
          						</div>
			                      <ul style="margin:0; padding:0;">
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToRecipientList(employee,department)">
							              <img width="25" height="25"  class="rounded-circle" :src="getAttachmentUrl(employee.attachmentNo)" >
							              {{ employee.empName }}.{{ employee.jobName }}
							            </span>
							            </li>
							          </ul>
							        </li>
							      </ul>
   							      <hr>
							      <ul style="margin:0; padding:0;">
							      	<li class="custom-list-item">
							      		<span>
											<i class="fa-regular fa-square-plus"></i>	      	
									          자주쓰는 결재선
							      		</span>
							      	</li>
							      </ul>
							      
							     </div>
       							<div class="col-8" style="overflow-y: scroll; height:400px;">
	       							<div class="row mb-1">
		       							<div class="col-6 text-center">
		       								참조자 목록
		       							</div>
		       							<div class="col-4 text-center">
		       								제거
		       							</div>
		       							<div class="col-2 text-center">
		       							</div>
		       						</div>
       								<div class="row" v-for="(recipient, index) in recipientList">
	       									<div class="col-6">
				       							<div class="badge bg-danger w-100">
				       								{{index+1}}.{{recipient.department.deptName}} : {{recipient.recipientList.empName}}.{{recipient.recipientList.jobName}}
				       							</div>
	       									</div>
	       									<div class="col-4 text-center" >
					       						<i class="fa-regular fa-trash-can" @click="removeRecipient(index)"></i>
	       									</div>
	       									<div class="col-2 text-center" >
	       									</div>
       								</div>
       							</div>
   							</div>
						</div>
	                </div>
                <div class="modal-footer">
                	<div class="row">
                    <button type="button" class="btn" :class="recipientList.length ? 'btn-info' : 'btn-secondary'"  @click="saveRecipientList">저장</button>
                    <button type="button" class="btn btn-secondary ml-auto ms-2" data-bs-dismiss="modal" @click="hideRecipientModal">닫기</button>
                    </div>
                </div>
            </div>      

        </div>

</div>

<!-- 열람자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="readerModal" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered  modal-lg" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">결재 정보 - 열람자</h5>
                </div>
                <div class="modal-body">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
	   	       		<div v-if="showDuplicateAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
						  <span>중복된 대상입니다.</span>
						</div>
					</div>
	   	       		<div v-if="showReaderNoDataAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
						  <span>먼저 열람자를 추가 하세요.</span>
						</div>
					</div>
	   	       		<div v-if="showReaderAddDataAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-success">
						  <span>저장되었습니다.</span>
						</div>
					</div>
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-4" style="overflow-y: scroll; height:400px;">
          						<div class="row mb-3 d-flex justify-content-center align-items-center">
	          						<div class="col-8 p-1" >
								      <input type="search" class="form-control " placeholder="이름" v-model="searchName" @keyup.enter="search">
	          						</div>
	          						<div class="col-2 border rounded" >
								      <span @click="search" style="cursor: pointer;" title="검색" class="d-flex justify-content-center align-items-center">
								      	<i class="fa-solid fa-magnifying-glass p-2"></i>
								      </span>
	          						</div>
	          						<div class="col-2 border rounded" >
								      <span @click="searchAll" style="cursor: pointer;" title="전체 목록" class="d-flex justify-content-center align-items-center">
								      	<i class="fa-solid fa-list p-2" ></i>
								      </span>
	          						</div>
          						</div>
			                      <ul style="margin:0; padding:0;">
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToReaderList(employee,department)">
							               <img width="25" height="25"  class="rounded-circle" :src="getAttachmentUrl(employee.attachmentNo)" >
							              {{ employee.empName }}.{{ employee.jobName }}
							            </span>
							            </li>
							          </ul>
							        </li>
							      </ul>
							      <hr>
							      <ul style="margin:0; padding:0;">
							      	<li class="custom-list-item">
							      		<span>
											<i class="fa-regular fa-square-plus"></i>	      	
									          자주쓰는 결재선
							      		</span>
							      	</li>
							      </ul>
							     </div>
       							<div class="col-8" style="overflow-y: scroll; height:400px;">
	       							<div class="row mb-1">
		       							<div class="col-6 text-center">
		       								열람자 목록
		       							</div>
		       							<div class="col-4 text-center">
		       								제거
		       							</div>
		       							<div class="col-2 text-center">
		       							</div>
		       						</div>
       								<div class="row" v-for="(reader, index) in readerList">
	       									<div class="col-6">
				       							<div class="badge bg-danger w-100">
				       								{{index+1}}.{{reader.department.deptName}} : {{reader.readerList.empName}}.{{reader.readerList.jobName}}
				       							</div>
	       									</div>
	       									<div class="col-4 text-center" >
					       						<i class="fa-regular fa-trash-can" @click="removeReader(index)"></i>
	       									</div>
	       									<div class="col-2 text-center" >
	       									</div>
       								</div>
       							</div>
   							</div>
						</div>
	                </div>
                <div class="modal-footer">
                	<div class="row">
                    <button type="button" class="btn" :class="readerList.length ? 'btn-info' : 'btn-secondary'"  @click="saveReaderList">저장</button>
                    <button type="button" class="btn btn-secondary ml-auto ms-2" data-bs-dismiss="modal" @click="hideReaderModal">닫기</button>
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
    	  
    	searchName : "",
    	  
        deptEmpList: [],
        approverList: [],  	
        agreeorList : [],
        recipientList : [],
        readerList : [],
        
        tempApproverList: [],
        tempAgreeorList: [],
        tempRecipientList: [],
        tempReaderList: [],
        
        approverModal : null,
        agreeorModal : null,
        recipientModal : null,
        readerModal : null,
        
        showDuplicateAlert: false,
        showApproverNoDataAlert : false,
        showApproverAddDataAlert : false,
        showAgreeorNoDataAlert : false,
        showAgreeorAddDataAlert : false,
        showRecipientNoDataAlert : false,
        showRecipientAddDataAlert : false,
        showReaderNoDataAlert : false,
        showReaderAddDataAlert : false,
        showApprovalNoDataAlert : false,
        
        
      }
    },
    
    computed: {
    	 isDataComplete() {
    	      return (
    	        this.ApprovalDataVO.approvalWithDrafterDto.draftTitle !== "" &&
    	        this.ApprovalDataVO.approvalWithDrafterDto.draftContent !== "" &&
    	        this.ApprovalDataVO.approverList.length > 0
    	      );
   	    },
    },
    
    methods: {
    	
      async loadEmpData() { //부서별 사원 데이터 호출(로드)
    	  const resp = await axios.get("/rest/approval/",{ 
    			  params :{
    		  		searchName : this.searchName
    			  }
    	  });
          this.deptEmpList.push(...resp.data);
      },
      
      async loadDraftData(){ // 기안서 데이터 호출
          const urlParams = new URLSearchParams(window.location.search);
          const draftNo = urlParams.get("draftNo");
          
          const resp = await axios.get("/rest/approval/detail/"+draftNo);
          this.ApprovalDataVO = resp.data; 	  
          
          this.ApprovalDataVO.approverList.forEach(approver => {	//결재자 정보 넣어주기
              const empNo = approver.empNo;
              const empName = approver.empName;
              const deptName = approver.deptName;
              const jobName = approver.jobName;
              const approverList = {empNo, empName, jobName};
              const department = {deptName};
              const approverData = {approverList: approverList, department: department };
              this.approverList.push(approverData);
            });
          this.tempApproverList = [...this.approverList];
          this.approverList = [...this.approverList];
          
          this.ApprovalDataVO.recipientList.forEach(recipient => {	//참조자 정보 넣어주기
              const empNo = recipient.empNo;
              const empName = recipient.empName;
              const deptName = recipient.deptName;
              const jobName = recipient.jobName;
              const recipientList = { empNo, empName, jobName };
              const department = { deptName};
              const recipientData = { recipientList: recipientList, department: department };
              this.recipientList.push(recipientData);
            });
          this.tempRecipientList = [...this.recipientList];
          this.recipientList = [...this.recipientList];
          
          this.ApprovalDataVO.readerList.forEach(reader => {	//열람자 정보 넣어주기
              const empNo = reader.empNo;
              const empName = reader.empName;
              const deptName = reader.deptName;
              const jobName = reader.jobName;
              const readerList = {empNo, empName, jobName };
              const department = { deptName};
              const readerData = { readerList: readerList, department: department };
              this.readerList.push(readerData);
            });
          this.tempReaderList = [...this.readerList];
          this.readerList = [...this.readerList];
          
      },
      
      searchAll() {	//이름 검색
    	  	this.searchName ="";
    	  	this.deptEmpList = [];
    	    this.loadEmpData();
    	},
      async search() {	//이름 검색
    	  	this.deptEmpList = [];
    	    await this.loadEmpData();
    	    for(let i=0; i<this.deptEmpList.length; i++){
	    	    if (this.deptEmpList[i].employeeList.length > 0) { //검색 결과가 있는 항목 펼치기
	    	        this.deptEmpList[i].showEmployeeList = true;
	    	      }
    	    }
    	    
    	},
		getAttachmentUrl(attachmentNo) { //프로필 사진 주소
   	      if (attachmentNo === null) {
   	        return "/static/img/dummydog.jpg";
   	      } else {
   	        return "/attachment/download?attachmentNo=" + attachmentNo;
   	      }
   	    },
      async sendData(){	//데이터 전송
    	  if (!this.isDataComplete) { //결재정보, 제목, 내용 누락 시 동작
    	  		this.showApprovalNoDataAlert = true;
    	  		const that = this;
    	  		setTimeout(function(){
    	  			that.showApprovalNoDataAlert = false;
    	  		}, 1000);
    	        return;
    	  }
          const urlParams = new URLSearchParams(window.location.search);
          const draftNo = urlParams.get("draftNo");
    	  const url = "/rest/approval/edit/"+draftNo;
    	  const resp = await axios.post(url, this.ApprovalDataVO);
    	  window.location.href = "/approval/detail?draftNo="+resp.data;
      },
      
      emergencyCheck(event) {	//긴급 문서 여부
    	  this.ApprovalDataVO.approvalWithDrafterDto.isemergency = event.target.checked ? 1 : 0;
      },
      
      showApproverModal(){	//결재자 모달 보이기
          this.approverModal.show();
      },
      
      showRecipientModal(){	//참조자 모달 보이기
          this.recipientModal.show();
      },
      
      showReaderModal(){	//열람자 모달 보이기
          this.readerModal.show();
      },
      
      hideApproverModal(){	//결재자 모달 숨기기
		  this.approverList.length=0;
          this.approverList = [...this.tempApproverList]; //임시 데이터로 덮기
          this.approverModal.hide();
          this.hideEmployeeList();
  	  	
          this.searchName = "";
          this.deptEmpList = [];
          this.loadEmpData();
      },
      
      hideRecipientModal(){	//참조자 모달 숨기기
		  this.recipientList.length=0;
          this.recipientList = [...this.tempRecipientList]; //임시 데이터로 덮기
          this.recipientModal.hide();
          this.hideEmployeeList();
          this.searchName = "";
          this.deptEmpList = [];
          this.loadEmpData();
      },
      
      hideReaderModal(){	//열람자 모달 숨기기
		  this.readerList.length=0;
          this.readerList = [...this.tempReaderList]; //임시 데이터로 덮기
          this.readerModal.hide();
     	  this.hideEmployeeList();
     	 this.searchName = "";
         this.deptEmpList = [];
         this.loadEmpData();
      },
      
      toggleEmployeeList(index) {	//부서별 사원 목록 접었다 펴기
          this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
      },
      
      hideEmployeeList() {	//부서별 사원 목록 모두 접기
    	  for (let i = 0; i < this.deptEmpList.length; i++) {
    		    this.deptEmpList[i].showEmployeeList = false;
    		  }
      },
      
      addToAppoverList(employee, department) { //결재자 리스트 추가
    	  const approverData = {
	    		  approverList : employee,
		    	  department : department.departmentDto,
	    	  }
      
    	  let check = false;	//결재자 중복 체크
    	  for (let i = 0; i < this.approverList.length; i++) {
	   		    if (this.approverList[i].approverList.empNo === employee.empNo) {
	   		 	   check = true;
   		    	}
   		  }
    	  
    	  if(!check){	//결재자 중복아니면 추가
	    	    this.approverList.push(approverData);
    	  }else{	//결재자 중복이면 알림메세지
    		  this.showDuplicateAlert = true;
    		  
	   	        const that = this; // 현재 컴포넌트의 this를 변수에 저장
	
	   	        setTimeout(function() {
	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
	   	        }, 1000);
    	  }
  	  },
  	  
  	  saveApproverList() { //결재자 저장
  		this.ApprovalDataVO.approverList.length=0; //이전 데이터 초기화
	        
	  	if(this.approverList.length==0){	//결재자 리스트 없으면 경고
			this.showApproverNoDataAlert = true;
			const that = this;
			setTimeout(function(){
				that.showApproverNoDataAlert = false;
			}, 1000);
			return;
  		}
  	 
  	    for (let i = 0; i < this.approverList.length; i++) { //결재자 정보 저장
  	      const approver = this.approverList[i];
  	      const approverData = {
  	        approverNo: approver.approverList.empNo,
  	      };
  	      this.ApprovalDataVO.approverList.push(approverData);
  	    }
  	      
  	    this.tempApproverList.length = 0;	//임시 데이터 초기화
  	    this.tempApproverList = [...this.approverList];	//임시 데이터 저장
  	      
		this.showApproverAddDataAlert = true;
		const that = this;
		setTimeout(function(){
			that.showApproverAddDataAlert = false;
		}, 1000);

  	    },
  	    
      addToRecipientList(employee, department) { //참조자 리스트 추가
    	  const recipientData = {
   			  recipientList : employee,
	    	  department : department.departmentDto
      		}
      
    	  let check = false;	//참조자 중복 체크
    	  for (let i = 0; i < this.recipientList.length; i++) {
	   		    if (this.recipientList[i].recipientList.empNo === employee.empNo) {
	   		    check = true;
   		    }
   		  }
    	  
    	  if(!check){	//참조자 중복아니면 추가
	    	    this.recipientList.push(recipientData);
    	  }else{	//참조자 중복이면 알림메세지
    		  this.showDuplicateAlert = true;
    		  
	   	        const that = this; // 현재 컴포넌트의 this를 변수에 저장
	
	   	        setTimeout(function() {
	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
	   	        }, 1000);
    	  }
  	  },
  	  
		saveRecipientList() { //참조자 저장
  		this.ApprovalDataVO.recipientList.length=0; //이전 데이터 초기화
	        
	  	if(this.recipientList.length==0){	//참조자 리스트 없으면 경고
			this.showRecipientNoDataAlert = true;
			const that = this;
			setTimeout(function(){
				that.showRecipientNoDataAlert = false;
			}, 1000);
			return;
  		}
  	 
  	    for (let i = 0; i < this.recipientList.length; i++) { //참조자 정보 저장
  	      const recipient = this.recipientList[i];
  	      const recipientData = {
  	    		recipientNo: recipient.recipientList.empNo,
  	      };
  	      this.ApprovalDataVO.recipientList.push(recipientData);
  	    }
  	      
  	    this.tempRecipientList.length = 0;	//임시 데이터 초기화
  	    this.tempRecipientList = [...this.recipientList];	//임시 데이터 저장
  	      
		this.showRecipientAddDataAlert = true;
		const that = this;
		setTimeout(function(){
			that.showRecipientAddDataAlert = false;
		}, 1000);

 	 },
  	  
      addToReaderList(employee, department) { //열람자 리스트 추가
    	  const readerData = {
   			  readerList : employee,
	    	  department : department.departmentDto
      		}
      
    	  let check = false;	//열람자 중복 체크
    	  for (let i = 0; i < this.readerList.length; i++) {
	   		    if (this.readerList[i].readerList.empNo === employee.empNo) {
	   		    check = true;
   		    }
   		  }
    	  
    	  if(!check){	//열람자 중복아니면 추가
	    	    this.readerList.push(readerData);
    	  }else{	//열람자 중복이면 알림메세지
    		  this.showDuplicateAlert = true;
    		  
	   	        const that = this; // 현재 컴포넌트의 this를 변수에 저장
	
	   	        setTimeout(function() {
	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
	   	        }, 1000);
    	  }
   	   },
   	   
		saveReaderList() { //열람자 저장
     		this.ApprovalDataVO.readerList.length=0; //이전 데이터 초기화
   	        
   	  	if(this.readerList.length==0){	//열람자 리스트 없으면 경고
   			this.showReaderNoDataAlert = true;
   			const that = this;
   			setTimeout(function(){
   				that.showReaderNoDataAlert = false;
   			}, 1000);
   			return;
     		}
     	 
     	    for (let i = 0; i < this.readerList.length; i++) { //열람자 정보 저장
     	      const reader = this.readerList[i];
     	      const readerData = {
     	    		 readerNo: reader.readerList.empNo,
     	      };
     	      this.ApprovalDataVO.readerList.push(readerData);
     	    }
     	      
     	    this.tempReaderList.length = 0;	//임시 데이터 초기화
     	    this.tempReaderList = [...this.readerList];	//임시 데이터 저장
     	      
   		this.showReaderAddDataAlert = true;
   		const that = this;
   		setTimeout(function(){
   			that.showReaderAddDataAlert = false;
   		}, 1000);

    	 },
  	  
	    approverMoveUp(index) { // 결재자 순서 올리기
  	      if (index > 0) {
  	         const temp = this.approverList[index];
  	         this.approverList[index] = this.approverList[index - 1];
  	         this.approverList[index - 1] = temp;
            }
  	   },
  	   
		approverMoveDown(index) { // 결재자 순서 내리기
  	      if (index < this.approverList.length - 1) {
  	         const temp = this.approverList[index];
  	         this.approverList[index] = this.approverList[index + 1];
  	         this.approverList[index + 1] = temp;
  	      }
  	   },
  	   
  	   removeApprover(index) { //결재자 제거
  	      this.approverList.splice(index, 1);
  	   },
  	   
  	   removeRecipient(index) { //참조자 제거
  	      this.recipientList.splice(index, 1);
  	   },
  	   
  	   removeReader(index) { //열람자 제거
  	      this.readerList.splice(index, 1);
  	   },
  	   
    },
    
    mounted(){
    	this.approverModal = new bootstrap.Modal(this.$refs.approverModal);
    	this.recipientModal = new bootstrap.Modal(this.$refs.recipientModal);
    	this.readerModal = new bootstrap.Modal(this.$refs.readerModal);
    },
    created() {
      this.loadEmpData();
      this.loadDraftData();
    },
  }).mount("#app");
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>