<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://unpkg.com/vue@3.2.26"></script>
  <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>

<script>
    $(function(){
    	$(".add-btn").click(function() {
    	    $("#hide").removeAttr("style");
    	});
    	$(".del-btn").click(function() {
    		$("#hide").closest("tr").css("display", "none");
    		$("#stopover").val("");
    	});
    	
    	
});
    
    
</script>

</head>
<body>
	<div class="container" id="app">
		<form action="/commute/trip" method="post">
			<table class="table table-hover">
				<tr>
					<th>유형/구분</th>
					<td><select id="name" name="name">
							<option value="">선택</option>
							<option value="출장">출장</option>
							<option value="외근">외근</option>
					</select></td>
				</tr>
				<tr>
					<th>대상자</th>
					<td>
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#myModal">대상자추가</button>
						<button type="button">선택 삭제</button> <br>
						<table class="table">
							<thead>
								<tr>
									<td></td>
									<td>부서</td>
									<td>직급</td>
									<td>이름</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox"></td>
									<td>영업팀</td>
									<td>사원</td>
									<td>테스트사원</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th>신청일시</th>
					<td><input type="date" id="startDate" name="startDate"
						min="YYYY-01-01" max="YYYY-12-31"> ~ <input type="date"
						id="endDate" name="endDate" min="YYYY-01-01" max="YYYY-12-31">
						<input type="checkbox">휴일포함</td>
				</tr>
				<tr>
					<th>기간</th>
					<td>기간 <label>1일(총 8시간 0분)</label></td>
				</tr>
				<tr>
					<th>출발지</th>
					<td><input type="text" name="startPlace"
						placeholder="출발지를 입력해주세요">
						<button class="add-btn" type="button">경유지 추가</button></td>
				</tr>

				<tr id="hide" style="display: none;">
					<th>경유지</th>
					<td><input type="text" name="middlePlace"
						placeholder="경유지를 입력해주세요">
					<button class="del-btn" type="button">삭제</button></td>
				</tr>
				<tr>
					<th>목적지</th>
					<td><input type="text" name="endPlace"
						placeholder="목적지를 입력해주세요"></td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="place" placeholder="출장장소를 입력해주세요"></td>
				</tr>
				<tr>
					<th>이동수단</th>
					<td><select id="work" name="work">
							<option value="">선택</option>
							<option value="관용차랑">관용차량</option>
							<option value="버스">버스</option>
							<option value="택시">택시</option>
							<option value="기차">기차</option>
							<option value="비행기">비행기</option>
							<option value="자가">자가</option>
							<option value="지하철">지하철</option>
					</select></td>
				</tr>
				<tr>
					<th>목적</th>
					<td><input type="text" name="purpose" placeholder="목적을 입력해주세요"></td>
				</tr>
				<tr>
					<th>비고</th>
					<td><input type="text" name="notes" placeholder="비고를 입력해주세요"></td>
				</tr>
			</table>
			<input type="hidden" name="">
			<button>등록</button>
			<br>
			<hr>
			<br>
			<h4>*신청내역</h4>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>이름</th>
						<th>부서명</th>
						<th>연차사용날짜</th>
						<th>휴가종류</th>
						<th>사유</th>
						<th>사용연차</th>
						<th>승인 상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 모달 창 -->
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


</body>
<script>
    // 회원목록
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
</html>
