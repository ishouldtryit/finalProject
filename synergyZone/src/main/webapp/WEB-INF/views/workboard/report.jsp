<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	.badge {
    display: inline-block; /* 또는 display: inline-flex; */
    margin-right: 5px; /* 원하는 간격으로 수정 */
}
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid">

         <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
             <i class="fa fa-bars"></i>
         </button>
         
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
             <ul class="nav navbar-nav ml-auto">
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/">홈</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/write">일지 작성</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/list">부서 업무일지</a>
                 </li>
                 <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/myWorkList">내 업무일지</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/supList">공유받은 업무일지</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>

    <script>
    	const empNo = "${sessionScope.empNo}";
    </script>


<div id="app">
	<div class="container-fluid">
		
		<c:if test="${workSups == null}">
			<div>
				<button type="button" class="btn btn-primary"
					v-on:click="showSupModal">참조자 추가</button>
			</div>		
		</c:if>

		<div class="container"></div>
	</div>

	<!-- 참조자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog"
		data-bs-backdrop="static" ref="SupModal">
		<div class="modal-dialog modal-dialog-centered  modal-lg"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">참조자 정보 - 참조자</h5>
				</div>
				<div class="modal-body">
					<!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div v-if="showDuplicateAlert"
						class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
							<span>중복된 대상입니다.</span>
						</div>
					</div>
					<div v-if="showMeAlert" class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
							<span>자신은 선택할 수 없습니다.</span>
						</div>
					</div>
					<div class="container-fluid">
						<div class="row">
							<div class="col-4" style="overflow-y: scroll; height: 400px;">
								<div
									class="row mb-3 d-flex justify-content-center align-items-center">
									<div class="col-8 p-1">
										<input type="text" class="form-control " placeholder="이름"
											v-model="searchName">
									</div>
									<div class="col-2 border rounded">
										<span @click="search" style="cursor: pointer;" title="검색"
											class="d-flex justify-content-center align-items-center">
											<i class="fa-solid fa-magnifying-glass p-2"></i>
										</span>
									</div>
									<div class="col-2 border rounded">
										<span @click="searchAll" style="cursor: pointer;"
											title="전체 목록"
											class="d-flex justify-content-center align-items-center">
											<i class="fa-solid fa-list p-2"></i>
										</span>
									</div>
								</div>
								<ul style="margin: 0; padding: 0;">
									<li v-for="(department, index) in deptEmpList"
										class="custom-list-item"><span
										v-on:click="toggleEmployeeList(index)"> <i
											class="fa-regular"
											:class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
											{{ department.departmentDto.deptName }}
									</span>
										<ul v-show="department.showEmployeeList">
											<li v-for="(employee, index) in department.employeeList"
												class="custom-list-item"><span
												@click="addToSup(employee, department)"> <img
													width="25" height="25" class="rounded-circle"
													:src="getAttachmentUrl(employee.attachmentNo)"> {{
													employee.empName }}.{{ employee.jobName }}
											</span></li>
										</ul></li>
								</ul>
								<hr>
							</div>
							<div class="col-8" style="overflow-y: scroll; height: 400px;">
								<div class="row mb-1">
									<div class="col-6 text-center">참조자 목록</div>
									<div class="col-2 text-center">제거</div>
								</div>
								<div class="row" v-for="(sup, index) in supList">
									<div class="col-6">
										<div class="badge bg-danger w-100">
											{{index+1}}.{{sup.department.deptName}} :
											{{sup.supList.empName}}</div>
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
						<button type="button" class="btn btn-secondary ml-auto"
							data-bs-dismiss="modal" @click="hideEmployeeList">닫기</button>
					</div>
				</div>
			</div>

		</div>

	</div>

	<form action="report" method="post" enctype="multipart/form-data">
		
		
		<div class="container-fluid mt-4">
		
		<h3>업무일지 보고</h3>
		
		    <div class="d-flex justify-content-end col-md-10 offset-md-1">
		        <c:if test="${owner}">
		            <a href="/workboard/edit?workNo=${workBoardDto.workNo}" class="btn btn-light btn-sm ms-2">
		                <i class="fa-regular fa-pen-to-square" style="color: #8f8f8f;"></i>&nbsp;수정
		            </a>
		        </c:if>
		        <c:if test="${owner || admin}">
		            <a href="/workboard/delete?workNo=${workBoardDto.workNo}" class="btn btn-light delete-button btn-sm ms-2">
		                <i class="fa-solid fa-trash-can" style="color: #8f8f8f;"></i>&nbsp;삭제
		            </a>
		        </c:if>
		        <a href="/workboard/list" class="btn btn-light btn-sm ms-2">
		            <i class="fa-solid fa-bars" style="color: #8f8f8f;"></i>&nbsp;목록
		        </a>
		    </div>
		    
		<div class="row mt-4">
				<div class="col-md-10 offset-md-1">
					<div class="d-flex align-items-center">
						<div class="col">
							<c:if test="${workSups != null}">
								<c:forEach var="employeeDto" items="${workSups}">
								<div class="badge badge-pill badge-light text-dark">
							          ${employeeDto.empName}								
								</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="row mt-4">
				<div class="col-md-10 offset-md-1">
					<div class="d-flex align-items-center">
						<div class="col">
							<label class="form-label"></label>
							<div v-for="(sup, index) in supList" :key="index"
								class="badge badge-pill badge-light text-dark">
								{{ sup.department.deptName }} : {{sup.supList.empName }} <input
									type="hidden" name="supList" :key="index"
									:value="sup.supList.empNo"> </br>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 제목 -->
			<div class="row">
				<div class="row mt-4">
					<div class="col-md-10 offset-md-1">
						<div class="d-flex align-items-center">
							<h3 class="me-2">${workBoardDto.workTitle}</h3>
							<span class="badge badge-pill secretBadge"
								data-work-secret="${workBoardDto.workSecret}"></span>
						</div>

						<div class="d-flex align-items-center">
							<div class="profile-image employee-name">
								<img width="24" height="24"
									src="<c:choose>
                                <c:when test="${profile.empNo == workBoardDto.empNo}">
                                    /attachment/download?attachmentNo=${profile.attachmentNo}
                                </c:when>
                                <c:otherwise>
                                    https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
                                </c:otherwise>
                            </c:choose>"
									alt="" style="border-radius: 50%;">
							</div>
							<h6 class="text"
								style="margin-left: 10px; margin-top: 10px; font-weight: nomal">
								<c:forEach var="employeeDto" items="${employees}">
									<c:if test="${employeeDto.empNo == workBoardDto.empNo}">
		                                ${employeeDto.empName}
		                            </c:if>
								</c:forEach>
								<span class="ms-2 text-secondary"
									style="font-weight: lighter; font-size: 14px;"> <fmt:formatDate
										value="${workBoardDto.workReportDate}"
										pattern="y년 M월 d일 H시 m분 " />
								</span>
							</h6>
						</div>
					</div>
				</div>
			</div>
			<!-- 게시글 내용 -->
			<div class="row mt-4" style="min-height: 350px;">
				<div class="col-md-10 offset-md-1"
					value="${workBoardDto.workContent}">
					${workBoardDto.workContent}</div>

				<c:if test="${files != null}">

					<div class="col-md-10 offset-md-1">
						<div class="row mt-4">
							<div class="col-lg-12">
								<div class="card shadow mb-4">
									<div class="card-header py-3">
										<h4 class="m-0 font-weight-bold text-info">File Attach</h4>
									</div>
									<div class="card-body">
										<div class="text-info">
											<c:forEach var="file" items="${files}">
												<a
													href="/attachment/download?attachmentNo=${file.attachmentNo}"
													data-file-size="${file.attachmentSize}">
													${file.attachmentName} </a>
												<br />
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</c:if>
			</div>
			<br>
		</div>
	<div class="row mt-4">
		<div class="col">
			<input type="hidden" name="workNo" id="workNo"
				value="${workBoardDto.workNo}">
			<!-- 나머지 입력 필드들 -->
		</div>
	</div>
	</form>
			<c:if test="${workSups == null}">
			<button type="submit" class="btn btn-primary" @click="report()">보고</button>
			</c:if>
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
        showMeAlert : false,
        
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
    	  if (employee.empNo === empNo) {
//     		    alert("자기 자신을 선택할 수 없습니다.");
	 			this.showMeAlert = true;
	
	    	    setTimeout(() => {
	    	      this.showMeAlert = false;
	    	    }, 1000);
    		    return;
    		  }
    	  
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

      
    	report() {
    		  if (this.supList === null || this.supList.length === 0) {
    		    alert("참조자를 선택해 주세요."); // 선택하지 않은 경우 알림 창을 띄웁니다.
    		    return; // form이 넘어가지 않도록 return 문을 추가합니다.
    		  }

    		  // Submit the form
    		  document.querySelector("form").submit();
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>