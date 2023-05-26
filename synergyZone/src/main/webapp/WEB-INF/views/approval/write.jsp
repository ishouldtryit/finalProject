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
</style>


<div id="app">
	<div class="container-fluid">
		<div class="row mb-3"> 
		  <h3>신규 결재</h3>
		</div>
	  <div class="row mb-2">
	  	<div class="col-6">
		   	<button type="button" class="btn ms-3 mb-2" :class="approverList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showApproverModal">
		  		{{ approverList.length ? '결재자 정보' : '결재자 추가' }}
			</button>
		   	<button type="button" class="btn ms-3 mb-2" :class="agreeorList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showAgreeorModal">
		  		{{ agreeorList.length ? '합의자 정보' : '합의자 추가' }}
			</button>
		   	<button type="button" class="btn ms-3 mb-2" :class="recipientList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showRecipientModal">
		  		{{ recipientList.length ? '참조자 정보' : '참조자 추가' }}
			</button>
		   	<button type="button" class="btn ms-3 mb-2" :class="readerList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showReaderModal">
		  		{{ readerList.length ? '열람자 정보' : '열람자 추가' }}
			</button>
	  	</div>
	  	<div class="col-4">
		</div>
	  	<div class="col-2 d-flex align-items-center justify-content-center">
	  		<div class="form-check form-switch d-flex, align-items-center">
			  <input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" :checked="approvalDto.isemergency === 1" @change="emergencyCheck">
			  <label class="form-check-label" for="flexSwitchCheckDefault">긴급 문서</label>
			</div>
	  	</div>
	  </div>
	  
	    <div class="row p-3" >
	      <span class="mb-1">제목</span>
	      <input type="text" name="draftTitle" v-model="approvalDto.draftTitle">
	    </div>
	    
	    <div class="row p-3">
	      <span class="mb-1">내용</span>
	      <textarea name="draftContent" required class="form-input w-100" style="min-height: 300px;" v-model="approvalDto.draftContent"></textarea>
	    </div>

<!-- 		<input v-for="(approver, i) in approverList" :name="'approver['+i+'].approverNo'" type="hidden" :value="approver.approverList.empNo"  :key="i" >	 -->
	      
<!-- 	    <input v-for="(approver, i) in approverList" name="approverNo" type="hidden" :value="approver.approverList.empNo"  :key="i" > -->
<!-- 	    <input v-for="(agreeor, i) in agreeorList" name="agreeorNo" type="hidden" :value="agreeor.agreeorList.empNo"  :key="i" > -->
<!-- 	    <input v-for="(recipient, i) in recipientList" name="recipientNo" type="hidden" :value="recipient.recipientList.empNo"  :key="i" > -->
<!-- 	    <input v-for="(reader, i) in readerList" name="readerNo" type="hidden" :value="reader.readerList.empNo"  :key="i" > -->
	    <div class="row">
	    	<div class="col-10"></div>
	    	<div class="col-2">
			    <button class="btn btn-info" type="button">등록</button>
	    	</div>
	    </div>
	    
  
  </div>
  
<!-- 결재자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="approverModal" >
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
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-4" style="overflow-y: scroll; height:400px;">
			                      <ul style="margin:0; padding:0;">
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToAppoverList(employee,department)">
							              <i class="fa-regular fa-circle-user"></i>
							              {{ employee.empName }}
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
				       								{{index+1}}.{{approver.department.deptName}} : {{approver.approverList.empName}}
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
                    	<button type="button" class="btn btn-secondary  ml-auto" data-bs-dismiss="modal" @click="hideEmployeeList">닫기</button>
                    </div>
                </div>
            </div>      

        </div>

</div>

<!-- 합의자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="agreeorModal" >
        <div class="modal-dialog modal-dialog-centered  modal-lg" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">결재 정보 - 합의자</h5>
                </div>
                <div class="modal-body">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
	   	       		<div v-if="showDuplicateAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
						  <span>중복된 대상입니다.</span>
						</div>
					</div>
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-4" style="overflow-y: scroll; height:400px;">
			                      <ul style="margin:0; padding:0;">
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToAgreeorList(employee,department)">
							              <i class="fa-regular fa-circle-user"></i>
							              {{ employee.empName }}
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
			       								합의자 목록
			       							</div>
			       							<div class="col-4 text-center">
			       								제거
			       							</div>
			       							<div class="col-2 text-center">
			       							</div>
		       							</div>
       								<div class="row" v-for="(agreeor, index) in agreeorList">
	       									<div class="col-6">
				       							<div class="badge bg-danger w-100">
				       								{{index+1}}.{{agreeor.department.deptName}} : {{agreeor.agreeorList.empName}}
				       							</div>
	       									</div>
	       									<div class="col-4 text-center" >
					       						<i class="fa-regular fa-trash-can" @click="removeAgreeor(index)"></i>
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
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"  @click="hideEmployeeList">닫기</button>
                    </div>
                </div>
            </div>      

        </div>

</div>
<!-- 참조자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="recipientModal" >
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
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-4" style="overflow-y: scroll; height:400px;">
			                      <ul style="margin:0; padding:0;">
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToRecipientList(employee,department)">
							              <i class="fa-regular fa-circle-user"></i>
							              {{ employee.empName }}
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
				       								{{index+1}}.{{recipient.department.deptName}} : {{recipient.recipientList.empName}}
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
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"  @click="hideEmployeeList">닫기</button>
                    </div>
                </div>
            </div>      

        </div>

</div>
<!-- 열람자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="readerModal" >
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
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-4" style="overflow-y: scroll; height:400px;">
			                      <ul style="margin:0; padding:0;">
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToReaderList(employee,department)">
							              <i class="fa-regular fa-circle-user"></i>
							              {{ employee.empName }}
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
				       								{{index+1}}.{{reader.department.deptName}} : {{reader.readerList.empName}}
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
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"  @click="hideEmployeeList">닫기</button>
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
        deptEmpList: [],
        approverList: [],  	
        agreeorList : [],
        recipientList : [],
        readerList : [],
        approverModal : null,
        agreeorModal : null,
        recipientModal : null,
        readerModal : null,
        showDuplicateAlert: false,
        approvalDto : {
        	draftTitle : '',
        	draftContent : '',
        	isemergency : 0,
        },
      };
    },
    computed: {
    	
    },
    methods: {
      async loadData() {
    	  const Resp = await axios.get("/rest/approval/");
          this.deptEmpList.push(...Resp.data);
      },
      emergencyCheck(event) {
    	  this.approvalDto.isemergency = event.target.checked ? 1 : 0;
      },
      showApproverModal(){	//결재자 모달 보이기
          if(this.approverModal == null) return;
          this.approverModal.show();
      },
      showAgreeorModal(){	//합의자 모달 보이기
          if(this.agreeorModal == null) return;
          this.agreeorModal.show();
      },
      showRecipientModal(){	//참조자 모달 보이기
          if(this.recipientModal == null) return;
          this.recipientModal.show();
      },
      showReaderModal(){	//열람자 모달 보이기
          if(this.readerModal == null) return;
          this.readerModal.show();
      },
      hideApproverModal(){	//결재자 모달 숨기기
          if(this.approverModal == null) return;
          this.approverModal.hide();
      },
      hideAgreeorModal(){	//합의자 모달 숨기기
          if(this.agreeorModal == null) return;
          this.agreeorModal.hide();
      },
      hideRecipientModal(){	//참조자 모달 숨기기
          if(this.recipientModal == null) return;
          this.recipientModal.hide();
      },
      hideReaderModal(){	//열람자 모달 숨기기
          if(this.readerModal == null) return;
          this.readerModal.hide();
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
	    	  department : department.departmentDto
      		}
    	  let check = false;
    	  for (let i = 0; i < this.approverList.length; i++) {
	   		    if (this.approverList[i].approverList.empNo === employee.empNo) {
	   		    check = true;
   		    }
   		  }
    	  
    	  if(!check){
	    	    this.approverList.push(approverData);
    	  }else{
    		  this.showDuplicateAlert = true;
    		  
	   	        const that = this; // 현재 컴포넌트의 this를 변수에 저장
	
	   	        setTimeout(function() {
	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
	   	        }, 1000);
    	  }
  	  },
      addToAgreeorList(employee, department) { //합의자 리스트 추가
    	  const agreeorData = {
   			  agreeorList : employee,
	    	  department : department.departmentDto
      		}
    	  let check = false;
    	  for (let i = 0; i < this.agreeorList.length; i++) {
	   		    if (this.agreeorList[i].agreeorList.empNo === employee.empNo) {
	   		    check = true;
   		    }
   		  }
    	  
    	  if(!check){
	    	    this.agreeorList.push(agreeorData);
    	  }else{
    		  this.showDuplicateAlert = true;
    		  
	   	        const that = this; // 현재 컴포넌트의 this를 변수에 저장
	
	   	        setTimeout(function() {
	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
	   	        }, 1000);
    	  }
  	  },
      addToRecipientList(employee, department) { //참조자 리스트 추가
    	  const recipientData = {
   			  recipientList : employee,
	    	  department : department.departmentDto
      		}
    	  let check = false;
    	  for (let i = 0; i < this.recipientList.length; i++) {
	   		    if (this.recipientList[i].recipientList.empNo === employee.empNo) {
	   		    check = true;
   		    }
   		  }
    	  
    	  if(!check){
	    	    this.recipientList.push(recipientData);
    	  }else{
    		  this.showDuplicateAlert = true;
    		  
	   	        const that = this; // 현재 컴포넌트의 this를 변수에 저장
	
	   	        setTimeout(function() {
	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
	   	        }, 1000);
    	  }
  	  },
      addToReaderList(employee, department) { //열람자 리스트 추가
    	  const readerData = {
   			  readerList : employee,
	    	  department : department.departmentDto
      		}
    	  let check = false;
    	  for (let i = 0; i < this.readerList.length; i++) {
	   		    if (this.readerList[i].readerList.empNo === employee.empNo) {
	   		    check = true;
   		    }
   		  }
    	  
    	  if(!check){
	    	    this.readerList.push(readerData);
    	  }else{
    		  this.showDuplicateAlert = true;
    		  
	   	        const that = this; // 현재 컴포넌트의 this를 변수에 저장
	
	   	        setTimeout(function() {
	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
	   	        }, 1000);
    	  }
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
  	   removeAgreeor(index) { //합의자 제거
  	      this.agreeorList.splice(index, 1);
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
    	this.agreeorModal = new bootstrap.Modal(this.$refs.agreeorModal);
    	this.recipientModal = new bootstrap.Modal(this.$refs.recipientModal);
    	this.readerModal = new bootstrap.Modal(this.$refs.readerModal);
    },
    created() {
      this.loadData();
    },
  }).mount("#app");
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>