<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<div id="app">
  <div>
    <button type="button" class="btn btn-primary" v-on:click="showAdminModal">관리자 추가</button>
  </div>

  <div class="container">
    <table>
      <thead>
        <tr>
          <th>번호</th>
          <th>이름</th>
          <th>이메일</th>
          <th>전화번호</th>
          <th>부서</th>
          <th>직위</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(employee, index) in adminList" :key="employee.empNo">
          <td>{{employee.empNo}}</td>
          <td>{{employee.empName}}</td>
          <td>{{employee.empEmail}}</td>
          <td>{{employee.empPhone}}</td>
          <td>{{employee.empDeptNo}}</td>
          <td>{{employee.empJobNo}}</td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- 결재자 선택 modal -->
  <div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" ref="AdminModal">
    <div class="modal-dialog modal-dialog-centered  modal-lg" role="document">
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
          <div class="container-fluid">
            <div class="row">
              <div class="col-4" style="overflow-y: scroll; height:400px;">
                <ul style="margin:0; padding:0;">
                  <li v-for="(department, index) in deptEmpList" class="custom-list-item">
                    <span v-on:click="toggleEmployeeList(index)">
                      <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
                      {{ department.departmentDto.deptName }}
                    </span>
                    <ul v-show="department.showEmployeeList">
                      <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
                        <span @click="addToManager(employee, department)">
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
                    관리자 순서
                  </div>
                  <div class="col-2 text-center">
                    제거
                  </div>
                </div>
                <div class="row" v-for="(manager, index) in managerList">
                  <div class="col-6">
                    <div class="badge bg-danger w-100">
                      {{index+1}}.{{manager.department.deptName}} : {{manager.managerList.empName}}
                    </div>
                  </div>
                  <div class="col-2 text-center">
                    <i class="fa-regular fa-circle-up" @click="managerMoveUp(index)"></i>
                  </div>
                  <div class="col-2 text-center">
                    <i class="fa-regular fa-trash-can" @click="removeManager(index)"></i>
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
          <div class="row">
            <button type="button" class="btn btn-secondary ml-auto" data-bs-dismiss="modal" @click="addAdmin">추가</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/vue@3.2.0/dist/vue.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios@0.23.0/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  Vue.createApp({
    data() {
      return {
        deptEmpList: [],
        adminModal: null,
        adminList: [],
        managerList: [],
        showDuplicateAlert: false,
      };
    },
    methods: {
      async loadData() {
        const resp = await axios.get("/rest/approval/");
        this.deptEmpList.push(...resp.data);
      },
      //관리자 목록
      async loadList() {
        const resp = await axios.get("/rest/employee/");
        this.adminList.push(...resp.data);
      },
      showAdminModal() {
        if (this.adminModal == null) return;
        this.adminModal.show();
      },
      hideAdminModal() {
        if (this.adminModal == null) return;
        this.adminModal.hide();
      },
      toggleEmployeeList(index) {
        this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
      },
      addToManager(employee, department) {
        const managerData = {
          managerList: employee,
          department: department.departmentDto,
        };

        let check = false;
        for(let i = 0; i < this.managerList.length; i++){
        	if(this.managerList[i].managerList.empNo === employee.empNo){
        		check = true;
        	}
        }
        
        if(!check){
        	this.managerList.push(managerData);
        }else{
        	this.showDuplicateAlert = true;
        	
        	const that = this;
        	
        	   setTimeout(function() {
 	   	          that.showDuplicateAlert = false; // 1초 후에 showDuplicateAlert 값을 false로 설정하여 알림이 사라지도록 함
 	   	        }, 1000);
        }
      },
      removeManager(index) {
        this.managerList.splice(index, 1);
      },
      managerMoveUp(index) {
        if (index > 0) {
          const temp = this.managerList[index];
          this.managerList.splice(index, 1);
          this.managerList.splice(index - 1, 0, temp);
        }
      },
      hideEmployeeList() {
        this.deptEmpList.forEach((department) => {
          department.showEmployeeList = false;
        });
      },
    },
    mounted() {
      this.loadData();
      this.loadList();
      this.adminModal = new bootstrap.Modal(this.$refs.AdminModal);
    },
  }).mount("#app");
</script>
