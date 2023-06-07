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

.btn {
	width: 120px;
}
</style>


<div id="app">
	<div class="container-fluid">
		<div class="row mb-3">
			<h3>신규 결재</h3>
		</div>
		<div class="row mb-2">
			<div class="col-5">
				<button type="button" class="btn ms-3 mb-2"
					:class="approvalVO.approverList.length ? 'btn-info' : 'btn-secondary'"
					@click="showApproverModal">{{
					approvalVO.approverList.length ? '결재자 정보' : '결재자 추가' }}</button>
				<button type="button" class="btn ms-3 mb-2"
					:class="approvalVO.agreeorList.length ? 'btn-info' : 'btn-secondary'"
					@click="showAgreeorModal">{{ approvalVO.agreeorList.length
					? '합의자 정보' : '합의자 추가' }}</button>
				<button type="button" class="btn ms-3 mb-2"
					:class="approvalVO.recipientList.length ? 'btn-info' : 'btn-secondary'"
					@click="showRecipientModal">{{
					approvalVO.recipientList.length ? '참조자 정보' : '참조자 추가' }}</button>
				<button type="button" class="btn ms-3 mb-2"
					:class="approvalVO.readerList.length ? 'btn-info' : 'btn-secondary'"
					@click="showReaderModal">{{ approvalVO.readerList.length ?
					'열람자 정보' : '열람자 추가' }}</button>
			</div>
			<div class="col-2 d-flex align-items-center justify-content-center">
				<div class="form-check form-switch d-flex">
					<input class="form-check-input" type="checkbox" role="switch"
						id="flexSwitchCheckDefault"
						:checked="approvalVO.approvalDto.isemergency === 1"
						@change="emergencyCheck"> <label class="form-check-label"
						for="flexSwitchCheckDefault">긴급 문서</label>
				</div>
			</div>
			<div class="col-4"></div>
		</div>

		<div class="row p-3">
			<label for="draftTitle" class="form-label">제목</label> <input
				type="text" id="draftTitle" name="draftTitle"
				v-model="approvalVO.approvalDto.draftTitle" class="form-control"
				v-on:input="approvalVO.approvalDto.draftTitle = $event.target.value">
		</div>

		<div class="row p-3">
			<label for="draftContent" class="form-label">내용</label>
			<textarea id="draftContent" name="draftContent" required
				style="min-height: 300px;"
				v-model="approvalVO.approvalDto.draftContent" class="form-control"
				v-on:input="approvalVO.approvalDto.draftContent = $event.target.value"></textarea>
		</div>

		<div class="row">
			<div class="col-10"></div>
			<div class="col-2">
				<button class="btn"
					:class="{'btn-info': isDataComplete, 'btn-secondary': !isDataComplete}"
					type="button" @click="sendData">등록</button>
			</div>
		</div>
		<div v-if="showApprovalNoDataAlert"
			class="duplicate-alert-container w-20">
			<div class="alert alert-dismissible alert-primary">
				<span>결재정보, 제목, 내용을 입력하세요</span>
			</div>
		</div>
	</div>

	<!-- 결재자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog"
		data-bs-backdrop="static" ref="approverModal">
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
					<div v-if="showApproverNoDataAlert"
						class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
							<span>먼저 결재자를 추가 하세요.</span>
						</div>
					</div>
					<div v-if="showApproverAddDataAlert"
						class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-success">
							<span>저장되었습니다.</span>
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
												@click="addToAppoverList(employee, department)"> <img
													width="25" height="25" class="rounded-circle"
													:src="getAttachmentUrl(employee.attachmentNo)"> {{
													employee.empName }}.{{ employee.jobName }}
											</span></li>
										</ul></li>
								</ul>
								<hr>
								<ul style="margin: 0; padding: 0;">
									<li class="custom-list-item"><span> <i
											class="fa-regular fa-square-plus"></i> 자주쓰는 결재선
									</span></li>
								</ul>
							</div>
							<div class="col-8" style="overflow-y: scroll; height: 400px;">
								<div class="row mb-1">
									<div class="col-6 text-center">결재 순서</div>
									<div class="col-4 text-center">순서 변경</div>
									<div class="col-2 text-center">제거</div>
								</div>
								<div class="row" v-for="(approver, index) in approverList">
									<div class="col-6">
										<div class="badge bg-danger w-100">
											{{index+1}}.{{approver.department.deptName}} :
											{{approver.approverList.empName}}.{{
											approver.approverList.jobName }}</div>
									</div>
									<div class="col-2 text-center">
										<i class="fa-regular fa-circle-up"
											@click="approverMoveUp(index)"></i>
									</div>
									<div class="col-2 text-center">
										<i class="fa-regular fa-circle-up fa-rotate-180"
											@click="approverMoveDown(index)"></i>
									</div>
									<div class="col-2 text-center">
										<i class="fa-regular fa-trash-can"
											@click="removeApprover(index)"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="row">
						<button type="button" class="btn"
							:class="approverList.length ? 'btn-info' : 'btn-secondary'"
							@click="saveApproverList">저장</button>
						<button type="button" class="btn btn-secondary ml-auto ms-2"
							data-bs-dismiss="modal" @click="hideApproverModal">닫기</button>
					</div>
				</div>
			</div>

		</div>

	</div>

	<!-- 합의자 선택 modal -->
	<div class="modal" tabindex="-1" role="dialog"
		data-bs-backdrop="static" ref="agreeorModal">
		<div class="modal-dialog modal-dialog-centered  modal-lg"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">결재 정보 - 합의자</h5>
				</div>
				<div class="modal-body">
					<!-- 모달에서 표시할 실질적인 내용 구성 -->
					<div v-if="showDuplicateAlert"
						class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
							<span>중복된 대상입니다.</span>
						</div>
					</div>
					<div v-if="showAgreeorNoDataAlert"
						class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-primary">
							<span>먼저 합의자를 추가 하세요.</span>
						</div>
					</div>
					<div v-if="showAgreeorAddDataAlert"
						class="duplicate-alert-container w-20">
						<div class="alert alert-dismissible alert-success">
							<span>저장되었습니다.</span>
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
												@click="addToAgreeorList(employee,department)"> <img
													width="25" height="25" class="rounded-circle"
													:src="getAttachmentUrl(employee.attachmentNo)"> {{
													employee.empName }}.{{ employee.jobName }}
											</span></li>
										</ul></li>
								</ul>
								<hr>
								<ul style="margin: 0; padding: 0;">
									<li class="custom-list-item"><span> <i
											class="fa-regular fa-square-plus"></i> 자주쓰는 결재선
									</span></li>
								</ul>

							</div>
							<div class="col-8" style="overflow-y: scroll; height: 400px;">
								<div class="row mb-1">
									<div class="col-6 text-center">합의자 목록</div>
									<div class="col-4 text-center">제거</div>
									<div class="col-2 text-center"></div>
								</div>
								<div class="row" v-for="(agreeor, index) in agreeorList">
									<div class="col-6">
										<div class="badge bg-danger w-100">
											{{index+1}}.{{agreeor.department.deptName}} :
											{{agreeor.agreeorList.empName}}.{{agreeor.agreeorList.jobName}}
										</div>
									</div>
									<div class="col-4 text-center">
										<i class="fa-regular fa-trash-can"
											@click="removeAgreeor(index)"></i>
									</div>
									<div class="col-2 text-center"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="row">
						<button type="button" class="btn"
							:class="agreeorList.length ? 'btn-info' : 'btn-secondary'"
							@click="saveAgreeorList">저장</button>
						<button type="button" class="btn btn-secondary ml-auto ms-2"
							data-bs-dismiss="modal" @click="hideAgreeorModal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>


</div>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>