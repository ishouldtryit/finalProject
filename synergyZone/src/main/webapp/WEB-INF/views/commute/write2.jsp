<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
    $(function(){
    	$(".add-btn").click(function() {
    	    $("#hide").removeAttr("style");
    	});
    	$(".del-btn").click(function() {
    		$("#hide").closest("tr").css("display", "none");
    		$("#stopover").val("");
    	});
    	function updateUseCount() {
			var startDate = new Date($('#startDate').val());
			var endDate = new Date($('#endDate').val());

			// 이전 날짜 선택못함
			if (endDate < startDate) {
				$('#endDate').val($('#startDate').val());
				endDate = new Date($('#endDate').val());
			}
		}

		// startDate와 endDate의 값이 변경될 때마다 useCount 업데이트
		$('#startDate, #endDate').change(function() {
			updateUseCount();
		});
		

});
    
    
</script>

</head>
<body>
	<div class="container" id="app">
		<form action="/commute/trip" method="post" v-on:submit="submitForm">
			<table class="table">
				<tr>
					<th>유형/구분</th>
					<td><div class="row ml-1">
							<div class="col-2">
								<select id="name" name="name">
									<option value="">선택</option>
									<option value="출장">출장</option>
									<option value="외근">외근</option>
								</select>
							</div>
						</div></td>
				</tr>
				<tr>
					<th>대상자</th>
					<td>
						<div class="d-flex justify-content-end">
							<button type="button" class="btn btn-primary mb-2"
								v-on:click="showSupModal">대상자 추가</button>
						</div>
						<table class="table" id="supListTable">
							<thead class="table-success">
								<tr>
									<td></td>
									<td>부서</td>
									<td>직급</td>
									<td>이름</td>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(sup, index) in supList" :key="index">
									<td></td>
									<td>{{ sup.department.deptName }}</td>
									<td>{{ sup.supList.jobName }}</td>
									<td>{{ sup.supList.empName }}</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th>신청일시</th>
					<td>
						<div class="d-flex align-items-center">
							<div class="flex-grow-1 col-2">
								<input type="date" v-model="startDate" class="form-control"
									min="YYYY-01-01" max="YYYY-12-31" @change="updateUseCount">
							</div>
							<div class="mx-2">~</div>
							<div class="d-flex align-items-center">
								<div>
									<input type="date" v-model="endDate" class="form-control"
										min="YYYY-01-01" max="YYYY-12-31" @change="updateUseCount">
								</div>
								<div class="ml-5">
									<input type="checkbox" class="form-check-input"
										v-model="includeHolidays" @change="calculateDateDifference">
									<label class="form-check-label">휴일포함</label>
								</div>
							</div>
						</div>
					</td>

				</tr>
				<tr>
					<th>기간</th>
					<td><span class="ml-2">기간 <label>{{ weekdays
								}}일(총 {{ diffInDays * 8 }}시간 0분)</label></span></td>
				</tr>
				<tr>
					<th>출발지</th>
					<td>
						<div class="d-flex align-items-center">
							<div class="col-6">
								<input type="text" name="startPlace" class="form-control"
									placeholder="출발지를 입력해주세요">
							</div>
							<button class="add-btn btn btn-sm btn-primary ml-1" type="button">경유지
								추가</button>
						</div>
					</td>

				</tr>

				<tr id="hide" style="display: none;">
					<th>경유지</th>
					<td>
						<div class="d-flex align-items-center">
							<div class="col-6">
								<input type="text" name="middlePlace" class="form-control"
									placeholder="경유지를 입력해주세요">
							</div>
							<button class="del-btn btn btn-sm btn-primary ml-1" type="button">삭제</button>
						</div>
					</td>
				</tr>

				<tr>
					<th>목적지</th>
					<td><div class="col-6">
							<input type="text" name="endPlace" class="form-control"
								placeholder="목적지를 입력해주세요">
						</div></td>
				</tr>
				<tr>
					<th>장소</th>
					<td><div class="col-6">
							<input type="text" name="place" class="form-control"
								placeholder="출장장소를 입력해주세요">
						</div></td>
				</tr>
				<tr>
					<th>이동수단</th>
					<td>
						<div class="row ml-1">
							<div class="col-2">
								<select class="form-select" id="work" name="work">
									<option value="">선택</option>
									<option value="관용차랑">관용차량</option>
									<option value="버스">버스</option>
									<option value="택시">택시</option>
									<option value="기차">기차</option>
									<option value="비행기">비행기</option>
									<option value="자가">자가</option>
									<option value="지하철">지하철</option>
								</select>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>목적</th>
					<td><div class="col-6">
							<input type="text" class="form-control" name="purpose"
								placeholder="목적을 입력해주세요">
						</div></td>
				</tr>
				<tr>
					<th>비고</th>
					<td><div class="col-6">
							<input type="text" class="form-control" name="notes"
								placeholder="비고를 입력해주세요">
						</div></td>
				</tr>
			</table>
			<input type="hidden" name="">
			<div class="d-flex justify-content-end">
				<button class="btn btn-primary" type="submit">등록</button>
			</div>
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
			<!-- 결재자 선택 modal -->
			<div class="modal" tabindex="-1" role="dialog"
				data-bs-backdrop="static" ref="SupModal">
				<div class="modal-dialog modal-dialog-centered  modal-lg"
					role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">결재 정보 - 결재자</h5>
						</div>
						<div class="modal-body">
							<!-- 모달에서 표시할 실질적인 내용 구성 -->
							<div v-if="showDuplicateAlert"
								class="duplicate-alert-container w-20">
								<div class="alert alert-dismissible alert-primary">
									<span>중복된 대상입니다.</span>
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
													{{sup.supList.empName}} <input type="hidden" name="supList"
														:key="index" :value="sup.supList.empNo">
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
								<button type="button" class="btn btn-secondary ml-auto"
									data-bs-dismiss="modal" @click="hideEmployeeList">닫기</button>
							</div>
						</div>
					</div>

				</div>

			</div>


		</form>
	</div>




</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  Vue.createApp({
    data() {
      return {
         
       searchName : "",
         
        deptEmpList: [],
        supModal: null,
        supList: [],
        showDuplicateAlert: false,
        startDate: '',
        endDate: '',
        includeHolidays: false,
        diffInDays: 0,
        weekdays: 0,
        weekendsIncludedDiffInDays: 0,
        weekendsIncludedWeekdays: 0,
        
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
      
      searchAll() {   //이름 검색
            this.searchName ="";
            this.deptEmpList = [];
           this.loadData();
      },

      async search() {   //이름 검색
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
      
      toggleEmployeeList(index) {   //부서별 사원 목록 접었다 펴기
          this.deptEmpList[index].showEmployeeList = !this.deptEmpList[index].showEmployeeList;
      },
      
      hideEmployeeList() {   //부서별 사원 목록 모두 접기
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
      addSupToList() {
     		// 선택한 대상자 정보를 supList에 추가
     		const selectedSup = {
     			supList: this.selectedEmployee,
     			department: this.selectedDepartment.departmentDto,
     		};
     		this.supList.push(selectedSup);

     		// 모달 창 닫기
     		this.hideSupModal();
      },
      
      submitForm() {
          // 서버로 전송할 데이터 준비
          const formData = {
            supList: this.supList
          };

          // 서버로 POST 요청 전송
          axios.post('/commute/trip', formData)
            .then(response => {
              // 요청 성공 처리
              console.log(response.data);
            })
            .catch(error => {
              // 요청 실패 처리
              console.error(error);
            });
        },
        calculateDateDifference() {
            const start = new Date(this.startDate);
            const end = new Date(this.endDate);

            // 날짜 차이를 계산합니다.
            const diffInMilliseconds = end - start;
            this.diffInDays = Math.floor(diffInMilliseconds / (1000 * 60 * 60 * 24));
            this.diffInDays=this.diffInDays+1;
            // 주말을 제외한 날짜 수를 계산합니다.
            this.weekdays = this.diffInDays;
            if (!this.includeHolidays) {
              const dayMilliseconds = 1000 * 60 * 60 * 24;

              for (let i = start.getTime(); i <= end.getTime(); i += dayMilliseconds) {
                const currentDate = new Date(i);
                const dayOfWeek = currentDate.getDay();
                if (dayOfWeek === 0 || dayOfWeek === 6) {
                  this.weekdays--;
                  this.diffInDays--;
                }
              }
            }
            this.weekendsIncludedDiffInDays = this.diffInDays;
            if (this.includeHolidays) {
              const dayMilliseconds = 1000 * 60 * 60 * 24;

              for (let i = start.getTime(); i <= end.getTime(); i += dayMilliseconds) {
                const currentDate = new Date(i);
                const dayOfWeek = currentDate.getDay();
                if (dayOfWeek === 0 || dayOfWeek === 6) {
                  this.weekendsIncludedDiffInDays++;
                }
              }
            }

            // 주말을 포함한 결과를 표시합니다.
            this.weekendsIncludedWeekdays = this.weekendsIncludedDiffInDays;
            if (!this.includeHolidays) {
              const dayMilliseconds = 1000 * 60 * 60 * 24;

              for (let i = start.getTime(); i <= end.getTime(); i += dayMilliseconds) {
                const currentDate = new Date(i);
                const dayOfWeek = currentDate.getDay();
                if (dayOfWeek === 0 || dayOfWeek === 6) {
                  this.weekendsIncludedWeekdays--;
                }
              }
            }
          },
          updateUseCount() {
              const startDate = new Date(this.startDate);
              const endDate = new Date(this.endDate);

              // 이전 날짜 선택 못함
              if (endDate < startDate) {
                this.endDate = this.startDate;
              }

              // useCount 업데이트
              this.calculateDateDifference();
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
</html>

