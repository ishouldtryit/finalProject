<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
  .custom-list-item {
    list-style-type: none; /* 리스트 스타일 제거 */
    /* 추가적인 스타일링을 적용할 수 있습니다 */
  }
</style>


<div id="app">
  <h1>결재를 해보자~</h1>
  <div>
   	<button type="button" class="btn btn-info" v-on:click="showModal">결재자 추가</button>
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
      
    <button type="submit">등록</button>
    
  </form>
  
<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="modal" >
        <div class="modal-dialog modal-dialog-centered  modal-lg" role="document" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">결재 정보 - 결재자</h5>
                </div>
                <div class="modal-body">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
                    <div class="container-fluid">
      						<div class="row">
          						<div class="col-6" style="overflow-y: scroll; height:400px;">
			                      <ul>
							        <li v-for="(department, index) in deptEmpList" class="custom-list-item"> 
							        	<span v-on:click="toggleEmployeeList(index)">
								           <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
								          {{ department.departmentDto.deptName }}
							        	</span>
							          <ul  v-show="department.showEmployeeList">
							            <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
							             <span @click="addToAppoverList(employee)">
							              <i class="fa-regular fa-circle-user"></i>
							              {{ employee.empName }}
							            </span>
							            </li>
							          </ul>
							        </li>
							      </ul>
							      <hr>
							      <ul>
							      	<li class="custom-list-item">
							      		<span>
											<i class="fa-regular fa-square-plus"></i>	      	
									          자주쓰는 결재선
							      		</span>
							      	</li>
							      </ul>
							     </div>
       							<div class="col-6" style="overflow-y: scroll; height:400px;">
       								<div class="row" v-for="(approver, index) in approverList">
		       							<span>{{index+1}}차 결재자</span>
		       							<span class="badge bg-danger w-50">{{approver.empName}}</span>
       								</div>
       							</div>
   							</div>
						</div>
	                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">닫기</button>
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
      };
    },
    computed: {},
    methods: {
      async loadData() {
    	  const Resp = await axios.get("/rest/approval/");
          this.deptEmpList.push(...Resp.data);
      },
      showModal(){
          if(this.modal == null) return;
          this.modal.show();
      },
      hideModal(){
          if(this.modal == null) return;
          this.modal.hide();
      },
      toggleEmployeeList(index) {
          this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
      },
      addToAppoverList(employee) {
    	  
    	  let check = false;
    	  for (let i = 0; i < this.approverList.length; i++) {
	   		    if (this.approverList[i].empNo === employee.empNo) {
	   		    check = true;
   		    }
   		  }
    	  
    	  if(!check){
	    	    this.approverList.push(employee);
    	  }else{
    		  console.log("중복입니다");
    	  }
    	  
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