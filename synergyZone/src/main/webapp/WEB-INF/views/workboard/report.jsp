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
	 
        <div>
            <button type="button" class="btn btn-primary" v-on:click="showSupModal">참조자 추가</button>
        </div>
        
        <div class="container">
           
        </div>
  </div>
  
<!-- 결재자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="SupModal" >
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
          						<div class="row mb-3 d-flex justify-content-center align-items-center">
	          						<div class="col-8 p-1" >
								      <input type="text" class="form-control " placeholder="이름" v-model="searchName">
	          						</div>
	          						<div class="col-2 border rounded">
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
							             <span @click="addToSup(employee, department)">
							              <img width="25" height="25"  class="rounded-circle" :src="getAttachmentUrl(employee.attachmentNo)" >
							              {{ employee.empName }}.{{ employee.jobName }}
							            </span>
							            </li>
							          </ul>
							        </li>
							      </ul>
							      <hr>
							     </div>
       							<div class="col-8" style="overflow-y: scroll; height:400px;">
	       							<div class="row mb-1">
		       							<div class="col-6 text-center">
		       								참조자 목록
		       							</div>
		       							<div class="col-2 text-center">
		       								제거
		       							</div>
		       						</div>
                                       <div class="row" v-for="(sup, index) in supList">
                                        <div class="col-6">
                                          <div class="badge bg-danger w-100">
                                            {{index+1}}.{{sup.department.deptName}} : {{sup.supList.empName}}
                                          </div>
                                        </div>
                                        <div class="col-2 text-center">
                                          <i class="fa-regular fa-trash-can" @click="removeSup(index)"></i>
                                        </div>
                                      </div>
       							</div>
   							</div>
						</div>
	                </div>
                <div class="modal-footer">
                    <div class="row">
                        <button type="button" class="btn btn-secondary ml-auto" data-bs-dismiss="modal" @click="hideEmployeeList">닫기</button>
                    </div>
                </div>
            </div>      

        </div>

</div>

<form action="report" method="post" enctype="multipart/form-data">
    <div class="container-fluid mt-4">
 
         <div class="row">
             <div class="offset-md-2 col-md-8">

                 <div class="row mt-4">
                     <div class="col">
                         <label class="form-label">제목</label>
                         ${workBoardDto.workTitle}
                     </div>
                 </div>

                 <div class="row mt-4">
                     <div class="col">
                         <label class="form-label">작성자</label>
                          <c:forEach var="employeeDto" items="${employees}">
                            <c:if test="${employeeDto.empNo == workBoardDto.empNo}">
                               ${employeeDto.empName}
                            </c:if>
                         </c:forEach>
                     </div>
                 </div>
                 
                 <div class="row mt-4">
                     <div class="col">
                         <label class="form-label">첨부파일</label>
                         <c:forEach var="file" items="${files}">
                           <a href="/attachment/download?attachmentNo=${file.attachmentNo}">${file.attachmentNo}</a>                
                         </c:forEach>
                     </div>
                 </div>
             
               <div class="row mt-4">
                     <div class="col">
                         ${workBoardDto.workReportDate}
                     </div>
               </div>
               
               <div class="row mt-4">
                   <div class="col">
                     ${workBoardDto.workContent}
                   </div>
               </div>
               
               <div class="row mt-4">
			    <div class="col">
			      <label class="form-label">참조자 목록</label>
			      <div v-for="(sup, index) in supList" :key="index">
			        {{ index + 1 }}. {{ sup.department.deptName }} : {{ sup.supList.empName }}
			        <input type="hidden" name="supList" :key="index" :value="sup.supList.empNo">
			      </div>
			    </div>
			  </div>
              

               
             <div class="row mt-4">
                 <div class="col">
                     <input type="hidden" name="workNo" id="workNo" value="${workBoardDto.workNo}">
                <!-- 나머지 입력 필드들 -->
                <button type="submit" class="btn btn-primary">보고</button>
                 </div>
             </div>
                

             </div>
         </div>
 
         
     </div>
    </form>
   </div>
   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  Vue.createApp({
    data() {
      return {
    	  
    	searchName : "",
    	  
        deptEmpList: [],
        supModal: null,
        supList: [],
        showDuplicateAlert: false,
        
      }
    },
    
    computed: {
    	 isDataComplete() {
    	      return (
    	        this.approvalVO.approvalDto.draftTitle !== "" &&
    	        this.approvalVO.approvalDto.draftContent !== "" &&
    	        this.approvalVO.approverList.length > 0
    	      );
   	    },
    },
    
    methods: {
    	
      async loadData() { //데이터 호출(로드)
    	  const resp = await axios.get("/rest/approval/",{ 
    			  params :{
    		  		searchName : this.searchName
    			  }
    	  });
          this.deptEmpList.push(...resp.data);
      },
      
      searchAll() {	//이름 검색
    	  	this.searchName ="";
    	  	this.deptEmpList = [];
    	    this.loadData();
      },

      async search() {	//이름 검색
    	  	this.deptEmpList = [];
    	    await this.loadData();
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

     showSupModal() {
        if (this.supModal == null) return;
        this.supModal.show();
      },

      hideSupModal() {
        if (this.supModal == null) return;
        this.supModal.hide();
      },

      removeSup(index) {
        this.supList.splice(index, 1);
      },
      
      toggleEmployeeList(index) {	//부서별 사원 목록 접었다 펴기
          this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
      },
      
      hideEmployeeList() {	//부서별 사원 목록 모두 접기
    	  for (let i = 0; i < this.deptEmpList.length; i++) {
    		    this.deptEmpList[i].showEmployeeList = false;
    		  }
      },
      
      addToSup(employee, department) {
        var supData = {
          supList: employee,
          department: department.departmentDto,
        };

        var check = false;
        for (var i = 0; i < this.supList.length; i++) {
          if (this.supList[i].supList.empNo === employee.empNo) {
            check = true;
            break;
          }
        }

        if (!check) {
          this.supList.push(supData);
        } else {
          this.showDuplicateAlert = true;

          setTimeout(() => {
            this.showDuplicateAlert = false;
          }, 1000);
        }
      },
     
  	   
    },
    
    mounted(){
    	this.supModal = new bootstrap.Modal(this.$refs.SupModal);
    },
    created() {
      this.loadData();
    },
  }).mount("#app");
</script>

