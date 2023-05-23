<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div id="app">
  <h1>결재를 해보자~</h1>
  <form action="/approval/write" method="post">
    <div>
      <span>제목</span>
      <input type="text" name="draftTitle" placeholder="제목">
    </div>
    <div>
      <span>내용</span>
      <textarea name="draftContent" required class="form-input w-100" style="min-height: 300px;"></textarea>
    </div>
    <div>
      <span>1차결재</span>
      <input type="text" name="firstApprover" placeholder="1차결재">
    </div>

      <ul>
        <li v-for="(department, index) in deptEmpList">
          {{ department.departmentDto.deptName }}
          <ul>
            <li v-for="(employee, index) in department.employeeList">
              {{ employee.empName }}
            </li>
          </ul>
        </li>
      </ul>
    <button type="submit">등록</button>
    
    
  </form>
</div>


<script>
  Vue.createApp({
    data() {
      return {
        deptEmpList: [],
      };
    },
    computed: {},
    methods: {
      async loadData() {
    	  const Resp = await axios.get("/rest/approval/");
          this.deptEmpList.push(...Resp.data);
      },
    },
    created() {
      this.loadData();
    },
  }).mount("#app");
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>