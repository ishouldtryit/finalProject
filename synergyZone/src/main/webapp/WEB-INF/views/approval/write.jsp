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
</style>


<div id="app">
	<div class="container-fluid">
		<div class="row"> 
		  <h2>신규 결재</h2>
		</div>
	  <div class="row w-20">
		   	<button type="button" class="btn" :class="approverList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showModal">
		  		{{ approverList.length ? '결재자 정보' : '결재자 추가' }}
			</button>
		   	<button type="button" class="btn" :class="approverList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showModal">
		  		{{ approverList.length ? '합의자 정보' : '합의자 추가' }}
			</button>
		   	<button type="button" class="btn" :class="approverList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showModal">
		  		{{ approverList.length ? '참조자 정보' : '참조자 추가' }}
			</button>
		   	<button type="button" class="btn" :class="approverList.length ? 'btn-info' : 'btn-secondary'" v-on:click="showModal">
		  		{{ approverList.length ? '열람자 정보' : '열람자 추가' }}
			</button>
	  </div>
	  
	  <form action="/approval/write" method="post">
	    
	    <div>
	      <span>제목</span>
	      <input type="text" name="draftTitle" placeholder="제목">
	    </div>
	    
	    <div>
	      <span>내용</span>
	      <textarea name="draftContent" required class="form-input w-100" style="min-height: 300px;"></textarea>
	    </div>
	      
	    <input v-for="(approver, i) in approverList" name="empNo" type="hidden" :value="approver.approverList.empNo"  :key="i" >
	    <button type="submit">등록</button>
	    
	  </form>
  
  </div>
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="modal" >
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
					       						<i class="fa-solid fa-xmark" @click="removeApprover(index)"></i>
	       									</div>
       								</div>
       							</div>
   							</div>
						</div>
	                </div>
                <div class="modal-footer">
                	<div class="row">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
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
        modal : null,
        showDuplicateAlert: false,
      };
    },
    computed: {},
    methods: {
      async loadData() {
    	  const Resp = await axios.get("/rest/approval/");
          this.deptEmpList.push(...Resp.data);
      },
      showModal(){	//모달 보이기
          if(this.modal == null) return;
          this.modal.show();
      },
      hideModal(){	//모달 숨기기
          if(this.modal == null) return;
          this.modal.hide();
      },
      toggleEmployeeList(index) {	//부서별 사원 목록 접었다 펴기
          this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
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
		approverMoveUp(index) { // 결재자 순서 바꾸기
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
    },
    mounted(){
    	this.modal = new bootstrap.Modal(this.$refs.modal);
    },
    created() {
      this.loadData();
    },
  }).mount("#app");
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>