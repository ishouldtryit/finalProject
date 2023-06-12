<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

.btn {
   width: 120px;
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
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/join">사원 등록</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/list">사원 통합관리</a>
                 </li>
                 <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/waitingList">사원 퇴사관리</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/add">관리자 통합관리</a>
                 </li> 
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/log/list">사원 접근로그</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/department/list">부서 관리</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/job/list">직위 관리</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>

<div id="app">
   

   <!-- 결재자 선택 modal -->
   <div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="AdminModal">
      <div class="modal-dialog modal-dialog-centered  modal-lg" role="document">
               <form action="add" method="post" enctype="multipart/form-data">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title">관리자 정보 - 관리자</h5>
            </div>
            <div class="modal-body">
               <!-- 모달에서 표시할 실질적인 내용 구성 -->
               <div v-if="showDuplicateAlert" class="duplicate-alert-container w-20">
                  <div class="alert alert-dismissible alert-primary">
                     <span>중복된 대상입니다.</span>
                  </div>
               </div>

                     <div class="row">
                        <div class="col-4" style="overflow-y: scroll; height: 400px;">
                           <div class="row mb-3 d-flex justify-content-center align-items-center">
                              <div class="col-8 p-1">
                                 <input type="text" class="form-control" placeholder="이름" v-model="searchName">
                              </div>
                              <div class="col-2 border rounded">
                                 <span @click="search" style="cursor: pointer;" title="검색" class="d-flex justify-content-center align-items-center">
                                    <i class="fa-solid fa-magnifying-glass p-2"></i>
                                 </span>
                              </div>
                              <div class="col-2 border rounded">
                                 <span @click="searchAll" style="cursor: pointer;" title="전체 목록" class="d-flex justify-content-center align-items-center">
                                    <i class="fa-solid fa-list p-2"></i>
                                 </span>
                              </div>
                           </div>
                           <ul style="margin: 0; padding: 0;">
                              <li v-for="(department, index) in deptEmpList" class="custom-list-item">
                                 <span v-on:click="toggleEmployeeList(index)">
                                    <i class="fa-regular"
                                       :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
                                    {{ department.departmentDto.deptName }}
                                 </span>
                                 <ul v-show="department.showEmployeeList">
                                    <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
                                       <span @click="addToAdmin(employee, department)">
                                          <img width="25" height="25" class="rounded-circle" :src="getAttachmentUrl(employee.attachmentNo)">
                                          {{ employee.empName }}.{{ employee.jobName }}
                                       </span>
                                    </li>
                                 </ul>
                              </li>
                           </ul>
                           <hr>
                        </div>
                        <div class="col-8" style="overflow-y: scroll; height: 400px;">
                           <div class="row mb-1">
                              <div class="col-6 text-center">관리자 목록</div>
                              <div class="col-2 text-center">제거</div>
                           </div>
                           <div class="row" v-for="(admin, index) in adminList">
                              <div class="col-6">
                                 <div class="badge bg-danger w-100">
                                    {{index+1}}.{{admin.department.deptName}} : {{admin.adminList.empName}}
                                 </div>
                              </div>
                              <div class="col-2 text-center">
                                 <i class="fa-regular fa-trash-can" @click="removeAdmin(index)"></i>
                              </div>
                           </div>
                           <div class="container-fluid mt-4">
                              <div class="row">
                                 <div class="offset-md-2 col-md-8">
                                    <div class="row mt-4">
                                       <div class="col">
                                          <label class="form-label"></label>
                                          <div v-for="(admin, index) in adminList" :key="index">
                                             <input type="hidden" name="adminList" :key="index" :value="admin.adminList.empNo">
                                          </div>
                                       </div>
                                    </div>
                                    <!-- 나머지 입력 필드들 -->
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>

            </div>
            <div class="modal-footer">
            
               <div class="row">
                  <button ref="submitButton" type="button" class="btn btn-primary" @click="report()">추가</button>
                  <button type="button" class="btn btn-secondary ml-3" data-bs-dismiss="modal" @click="hideEmployeeList">닫기</button>
               </div>
               
            </div>
         </div>
            </form>
      </div>
   </div>
   <div class="container">
   <!-- 검색 -->
   <form class="d-flex justify-content-between mt-2" action="add" method="get">
      <div class="d-flex">
        <select name="column" class="form-input me-sm-2">
          <option value="emp_name" ${column eq 'emp_name' ? 'selected' : ''}>이름</option>
          <option value="emp_no" ${column eq 'emp_no' ? 'selected' : ''}>사원번호</option>
          <option value="dept_name" ${column eq 'dept_name' ? 'selected' : ''}>부서</option>
          <option value="job_name" ${column eq 'job_name' ? 'selected' : ''}>직위</option>
        </select>
        <input class="form-control me-sm-2 w-75" type="search" placeholder="검색어" name="keyword" value="${param.keyword}" style="width: 13%;">
        <button class="btn btn-outline-info my-2 my-sm-0" type="submit">Search</button>
      </div>
        <button type="button" class="btn btn-outline-primary" v-on:click="showAdminModal">관리자 추가</button>
        
      </form>
      
   <form action="add" method="post" enctype="multipart/form-data">
            <div>
            <!-- 사원 목록 테이블 -->
                <form id="adminListForm">
                  <c:choose>
                  <c:when test="${adminList != null}">
                  <table class="table table-hover table-sm mt-2 text-center">
                    <thead>
                      <tr>
                         <th>프로필</th>
                        <th>이름</th>
                        <th>이메일</th>
                          <th>부서</th>
                      </tr>
                    </thead>
                    <tbody>
                          <c:forEach var="adminList" items="${adminList}">
                        <tr>
                          <td class="align-middle">
                            <div class="profile-image employee-name">
                              <img width="50" height="50" src="<c:choose>
                                <c:when test="${adminList.attachmentNo > 0}">
                                  /attachment/download?attachmentNo=${adminList.attachmentNo}
                                </c:when>
                                <c:otherwise>
                                  https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
                                </c:otherwise>
                                     </c:choose>" alt="" style="border-radius: 50%;">
                            </div>
                          </td>
                          <td class="align-middle">${adminList.empName}</td>
                          <td class="align-middle">${adminList.empEmail}</td>
                           <td class="align-middle">
                              <c:forEach var="departmentDto" items="${departments}">
                              <c:if test="${departmentDto.deptNo == adminList.deptNo}">
                                ${departmentDto.deptName}
                              </c:if>
                            </c:forEach>
                           </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                  </c:when>
                  <c:otherwise>
                      <div>
                          결과가 없습니다.
                      </div>
                  </c:otherwise>
                  </c:choose>
                </form>
              </div>

      </form>
   </div>
</div>
   
         <!-- 페이징 영역 -->
      <div style="display: flex; justify-content: center;">
        <ul class="pagination" style="width: 20%;">
          <li class="page-item ${vo.isFirst() ? 'disabled' : ''}">
            <a class="page-link" href="${vo.isFirst() ? '#' : pageContext.request.contextPath}/admin/add?page=${vo.getPrevPage()}&sort=${vo.getSort()}${vo.getQueryString()}">&laquo;</a>
          </li>
          <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
            <li class="page-item">
              <a class="page-link ${vo.getPage() eq i ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/add?page=${i}&sort=${vo.getSort()}${vo.getQueryString()}">
                <span class="text-info">${i}</span>
              </a>
            </li>
          </c:forEach> 
          <li class="page-item ${vo.isLast() ? 'disabled' : ''}">
            <a class="page-link" href="${vo.isLast() ? '#' : pageContext.request.contextPath}/admin/add?page=${vo.getNextPage()}&sort=${vo.getSort()}${vo.getQueryString()}">
              <span class="text-info">&raquo;</span>
            </a>
          </li>
        </ul>
      </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  Vue.createApp({
    data() {
      return {
        searchName: "",
        deptEmpList: [],
        adminModal: null,
        adminList: [],
        showDuplicateAlert: false,
        showIsAdminAlert: false,
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
      async loadData() {
        const resp = await axios.get("/rest/approval/", {
          params: {
            searchName: this.searchName,
          },
        });
        this.deptEmpList.push(...resp.data);
      },
      
      searchAll() {
        this.searchName = "";
        this.deptEmpList = [];
        this.loadData();
      },

      async search() {
        this.deptEmpList = [];
        await this.loadData();
        for (let i = 0; i < this.deptEmpList.length; i++) {
          if (this.deptEmpList[i].employeeList.length > 0) {
            this.deptEmpList[i].showEmployeeList = true;
          }
        }
      },

      getAttachmentUrl(attachmentNo) {
        if (attachmentNo === null) {
          return "/static/img/dummydog.jpg";
        } else {
          return "/attachment/download?attachmentNo=" + attachmentNo;
        }
      },

      showAdminModal() {
        if (this.adminModal == null) return;
        this.adminModal.show();
      },

      hideAdminModal() {
        if (this.adminModal == null) return;
        this.adminModal.hide();
      },

      removeAdmin(index) {
        this.adminList.splice(index, 1);
      },
      
      toggleEmployeeList(index) {
        this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
      },
      
      hideEmployeeList() {
        for (let i = 0; i < this.deptEmpList.length; i++) {
          this.deptEmpList[i].showEmployeeList = false;
        }
      },
      
      addToAdmin(employee, department) {
        var adminData = {
          adminList: employee,
          department: department.departmentDto,
        };

        var check = false;
        for (var i = 0; i < this.adminList.length; i++) {
          if (this.adminList[i].adminList.empNo === employee.empNo) {
            check = true;
            break;
          }
        }

        if (!check) {
          this.adminList.push(adminData);
        } else {
          this.showDuplicateAlert = true;

          setTimeout(() => {
            this.showDuplicateAlert = false;
          }, 1000);
        }
      },
      report() {
         if (this.adminList === null || this.adminList.length === 0) {
           alert("추가할 관리자를 선택해 주세요.");
         } else {
           this.$refs.submitButton.type = "submit";
         }
       },
    },
    
    mounted() {
      this.adminModal = new bootstrap.Modal(this.$refs.AdminModal);
    },
    
    created() {
      this.loadData();
    },
  }).mount("#app");
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>