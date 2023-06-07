<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://unpkg.com/vue@3.2.26"></script>
  <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
  <title>ä�� UI</title>
</head>
  <body>
  <div class="container d-flex" id="app">
    <div class="w-20">
      <!-- Add a button to open the modal -->
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">
        대상자추가
      </button>

      <!-- The Modal -->
      <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">Modal Title</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <!-- Modal content goes here -->
              <ul>
                <li v-for="(department, index) in deptEmpList" class="custom-list-item">
                  <span v-on:click="toggleEmployeeList(index)">
                    <i class="fa-regular" :class="{'fa-square-plus': !department.showEmployeeList, 'fa-square-minus': department.showEmployeeList}"></i>
                    {{ department.departmentDto.deptName }}
                  </span>
                  <ul v-show="department.showEmployeeList">
                    <li v-for="(employee, index) in department.employeeList" class="custom-list-item">
                      <i class="fa-regular fa-circle-user"></i>
                      {{ employee.empName }}
                    </li>
                  </ul>
                </li>
              </ul>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // ȸ�����
    Vue.createApp({
      data() {
        return {
          deptEmpList: [],
          message: ''
        };
      },
      computed: {},
      methods: {
        async loadData() {
          const response = await axios.get("/rest/approval/");
          this.deptEmpList.push(...response.data);
        },
        toggleEmployeeList(index) {
          this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
        },
        sendMessage() {
          console.log(this.message);
          this.message = '';
        }
      },
      mounted() {
        this.loadData();
      },
    }).mount("#app");
  </script>
</body>
</html>