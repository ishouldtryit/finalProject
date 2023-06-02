<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <style>
    .custom-list-item {
      list-style-type: none;
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
      <button type="button" class="btn btn-primary" id="showSupModal">참조자 추가</button>
    </div>

    <div class="container"></div>

    <!-- 결재자 선택 modal -->
    <div class="modal" tabindex="-1" role="dialog" data-bs-backdrop="static" id="SupModal">
      <div class="modal-dialog modal-dialog-centered  modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">관리자 정보 - 관리자</h5>
          </div>
          <div class="modal-body">
            <!-- 모달에서 표시할 실질적인 내용 구성 -->
            <div class="duplicate-alert-container w-20" id="duplicateAlertContainer" style="display: none;">
              <div class="alert alert-dismissible alert-primary">
                <span>중복된 대상입니다.</span>
              </div>
            </div>
            <div class="container-fluid">
              <div class="row">
                <div class="col-4" style="overflow-y: scroll; height:400px;">
                  <ul style="margin:0; padding:0;"></ul>
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
                  <div class="row" id="supList"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <div class="row">
              <button type="button" class="btn btn-secondary ml-auto" data-bs-dismiss="modal" id="closeModal">닫기</button>
            </div>
            <div class="row">
              <button type="button" class="btn btn-secondary ml-auto" data-bs-dismiss="modal" id="addSup">추가</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/axios@0.23.0/dist/axios.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  $(document).ready(function() {
    const deptEmpList = [];
    let supList = [];
    let showDuplicateAlert = false;

    function loadData() {
      axios.get("/rest/approval/").then(function(response) {
        deptEmpList.push(...response.data);
        renderDepartmentList();
      });
    }

    function toggleEmployeeList(index) {
      const $employeeList = $('.employee-list[data-index="' + index + '"]');
      $employeeList.slideToggle();
    }

    function removeSup(index) {
      supList.splice(index, 1);
      renderSupList();
    }

    function hideEmployeeList() {
      $('.employee-list').hide();
    }

    function addToSup(employee, department) {
      const supData = {
        supList: [],
        department: department,
      };

      let check = false;
      for (let i = 0; i < supList.length; i++) {
        if (supList[i].supList.empName === employee) {
          check = true;
          break;
        }
      }

      if (!check) {
        supData.supList.empName = employee;
        supList.push(supData);
        renderSupList();
      } else {
        showDuplicateAlert = true;

        setTimeout(function() {
          showDuplicateAlert = false;
          $('#duplicateAlertContainer').hide();
        }, 1000);
      }
    }

    function addSup() {
      // 추가 버튼을 클릭했을 때 실행되는 로직
    }

    function renderDepartmentList() {
      const $departmentList = $('.col-4 ul');
      $departmentList.empty();
      for (let i = 0; i < deptEmpList.length; i++) {
        const department = deptEmpList[i];
        const $departmentItem = $('<li class="custom-list-item">' +
          '<span class="department-toggle" data-index="' + i + '">' +
          '<i class="fa-regular fa-square-plus"></i>' +
          department.departmentDto.deptName +
          '</span>' +
          '<ul class="employee-list" data-index="' + i + '" style="display: none;"></ul>' +
          '</li>');
        $departmentList.append($departmentItem);
        renderEmployeeList($departmentItem.find('.employee-list'), department.employeeList);
      }
    }

    function renderEmployeeList($list, employees) {
      $list.empty();
      for (let i = 0; i < employees.length; i++) {
        const employee = employees[i];
        const $employeeItem = $('<li class="custom-list-item">' +
          '<span class="employee-select" data-employee="' + employee.empName + '" data-department="' + employee.department + '">' +
          '<i class="fa-regular fa-circle-user"></i>' +
          employee.empName +
          '</span>' +
          '</li>');
        $list.append($employeeItem);
      }
    }

    function renderSupList() {
      const $supList = $('#supList');
      $supList.empty();
      for (let i = 0; i < supList.length; i++) {
        const sup = supList[i];
        const $supItem = $('<div class="col-6">' +
          '<div class="badge bg-danger w-100">' +
          (i+1) + '.' + sup.department.deptName + ' : ' + sup.supList.empName +
          '</div>' +
          '</div>' +
          '<div class="col-2 text-center">' +
          '<i class="fa-regular fa-trash-can" data-index="' + i + '"></i>' +
          '</div>');
        $supItem.find('.fa-trash-can').click(function() {
          const index = $(this).data('index');
          removeSup(index);
        });
        $supList.append($supItem);
      }
    }

    function initializeModal() {
      const $modal = $('#SupModal');
      $modal.modal({
        backdrop: 'static'
      });
      $modal.on('hide.bs.modal', function() {
        hideEmployeeList();
      });
      $('#showSupModal').click(function() {
        $modal.modal('show');
      });
      $('#closeModal').click(function() {
        $modal.modal('hide');
      });
      $('#addSup').click(function() {
        addSup();
      });
      $(document).on('click', '.department-toggle', function() {
        const index = $(this).data('index');
        toggleEmployeeList(index);
      });
      $(document).on('click', '.employee-select', function() {
        const employee = $(this).data('employee');
        const department = $(this).data('department');
        addToSup(employee, department);
      });
    }

    loadData();
    renderSupList();
    initializeModal();
  });
</script>
