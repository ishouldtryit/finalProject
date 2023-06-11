<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(function() {
		// 정보변경
		$("#vacationName").change(function() {
			var selectedValue = $(this).val();
			var applicationType = "";

			switch (selectedValue) {
			case "연차":
				applicationType = "연차 신청";
				break;
			case "병가":
				applicationType = "병가 신청";
				break;
			default:
				applicationType = "신청유형을 선택해주세요";
				break;
			}

			$("#vacation").text(applicationType);
		});

		// 날짜선택
		const currentDate = new Date();
		const currentYear = currentDate.getFullYear();
		$("#currentYear").text(currentYear);
		var startDate = currentYear + "-01-01";
		var endDate = currentYear + "-12-31";
		var yearRange = startDate + " ~ " + endDate;
		$("#yearRange").text(yearRange);

		$("#startDate").attr({
			"min" : currentYear + "-01-01",
			"max" : currentYear + "-12-31"
		});

		$("#endDate").attr({
			"min" : currentYear + "-01-01",
			"max" : currentYear + "-12-31"
		});

		// startDate와 endDate의 차이를 구하여 useCount에 전달하고 결과를 result에 표시하는 함수
		function updateUseCount() {
			var startDate = new Date($('#startDate').val());
			var endDate = new Date($('#endDate').val());

			// 이전 날짜 선택못함
			if (endDate < startDate) {
				$('#endDate').val($('#startDate').val());
				endDate = new Date($('#endDate').val());
			}

			var diffDays = 0;
			var currentDate = new Date(startDate);

			while (currentDate <= endDate) {
				var weekDay = currentDate.getDay();
				if (weekDay !== 0 && weekDay !== 6) {
					diffDays++;
				}
				currentDate.setDate(currentDate.getDate() + 1);
			}

			// 계산 전송
			$('#useCount').val(diffDays);
			$('#result').text(diffDays);
		}

		// startDate와 endDate의 값이 변경될 때마다 useCount 업데이트
		$('#startDate, #endDate').change(function() {
			updateUseCount();
		});

		// startDate와 endDate가 동일한 경우 반차 여부 행을 보여주고, 그렇지 않은 경우 숨김
		function toggleLeaveRow() {
			var startDate = $('#startDate').val();
			var endDate = $('#endDate').val();
			if (startDate === endDate) {
				$('#morningLeave, #afternoonLeave').prop('disabled', false);
				$('tr.leave-row').show();
			} else {
				$('#morningLeave, #afternoonLeave').prop('disabled', true)
						.prop('checked', false);
				$('tr.leave-row').hide();
			}
			updateUseCountByCheckbox();
		}

		// startDate와 endDate 값이 변경될 때마다 반차 여부 행 업데이트
		$('#startDate, #endDate').change(function() {
			toggleLeaveRow();
		});

		$('#morningLeave, #afternoonLeave').change(function() {
			var morningLeaveChecked = $('#morningLeave').is(':checked');
			var afternoonLeaveChecked = $('#afternoonLeave').is(':checked');

			if (morningLeaveChecked && afternoonLeaveChecked) { // 두 개 모두 체크되어 있는 경우
				$('#useCount').val(1);
				$('#result').text(1);
			} else if (morningLeaveChecked || afternoonLeaveChecked) {
				$('#useCount').val(0.5);
				$('#result').text(0.5);
			} else {
				$('#useCount').val(1);
				$('#result').text(1);
			}

			if (morningLeaveChecked && afternoonLeaveChecked) { // 두 개 모두 체크되어 있는 경우
				$('#leave').val(0); //종일
			} else if (morningLeaveChecked) {
				$('#leave').val(1); //오전
			} else if (afternoonLeaveChecked) {
				$('#leave').val(2); //오후
			} else {
				$('#leave').val(0); //모두 체크풀림
			}
		});

		$('#useCount').val(0);
		$('#result').text(0);

		$("form").submit(function(event) {
			var useCount = parseInt($("#useCount").val());
			var totalValue = parseInt($("#value").text());
			var vacationName = $("#vacationName").val();
			var startDate = $("#startDate").val();
			var endDate = $("#endDate").val();

			if (vacationName === "") {
				event.preventDefault(); // 폼 전송을 막습니다.
				alert("휴가 종류를 선택해주세요."); // 경고 메시지를 표시합니다.
			}else if (startDate === "" || endDate === "") {
				alert("신청일시를 입력해주세요.");
				event.preventDefault(); // 폼 제출 막기
			} else 	if (vacationName === "공가") {
				return true; // "공가"인 경우 폼을 전송합니다.
			}else	if (useCount > totalValue) {
				alert("잔여 연차일보다 연차 사용량이 더 많습니다. 다시 등록해주세요");
				event.preventDefault(); // 잔여 연차일보다 사용량이 더 많은 경우 폼 전송을 막습니다.
			}
		});

		$('.data-work-status').find('tr').each(function() {
			var itemStatus = $(this).find('.work-status').text();

			switch (itemStatus) {
			case '0':
				var statusText = "요청";
				$(this).find('.work-status').text(statusText);
				$(this).find('.work-status').addClass('badge bg-success');
				break;

			case '2':
				var statusText = "반려";
				$(this).find('.work-status').text(statusText);
				$(this).find('.work-status').addClass('badge bg-primary');
				break;

			default:
				break;
			}
		});

	});
</script>
</head>
<body>
	<div class="container">
		<form action="/commute/write" method="post">
			<div class="row mb-3">
				<div class="col">
					<h4>*신청정보</h4>
				</div>
			</div>
			<table class="table table-bordered">
				<tr>
					<th class="table-secondary ">대상자</th>
					<td><label class="font-weight-bold">${one.empName}</label><br>
						<br>
						<table class="table table-bordered">
							<thead class="table-secondary">
								<tr>
									<td>연차기준년도</td>
									<td>연차기간</td>
									<td>총 연차일</td>
									<td>사용 연차</td>
									<td>잔여 연차일</td>
									<td>결재 대기 연차일수</td>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td id="currentYear"></td>
									<td id="yearRange"></td>
									<td>${one.total}</td>
									<td>${one.used}</td>
									<td id="value">${one.residual}</td>
									<td id="result"></td>
								</tr>
							</tbody>
						</table></td>
				</tr>
				<tr>
					<th class="table-secondary ">신청유형</th>
					<td><div class="row">
							<div class="col-2">
								<select id="vacationName" name="vacationName"
									class="form-select">
									<option value="">선택</option>
									<option value="연차">연차</option>
									<option value="병가">병가</option>
								</select>
							</div>
						</div></td>
				</tr>
				<tr>
					<th class="table-secondary ">신청일시</th>
					<td>
						<div class="row">
							<div class="col-2">
								<input type="date" id="startDate" name="startDate"
									class="form-control" min="YYYY-01-01" max="YYYY-12-31">
							</div>
							~
							<div class="col-2">
								<input type="date" id="endDate" name="endDate"
									class="form-control" min="YYYY-01-01" max="YYYY-12-31">
							</div>
						</div>
					</td>
				</tr>

				<tr>
					<th class="table-secondary ">반차여부</th>
					<td>
						<div class="d-flex">
							<div class="form-check">
								<input type="checkbox" id="morningLeave"
									class="form-check-input" onchange="updateUseCountByCheckbox()"
									disabled><label class="form-check-label">오전 반차
								</label>
							</div>
							<div class="form-check ml-3">
								<input type="checkbox" class="form-check-input"
									id="afternoonLeave" onchange="updateUseCountByCheckbox()"
									disabled><label class="form-check-label">오후 반차
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th class="table-secondary ">근무계획정보</th>
					<td><label class="form-label">[근무일] 09:30 ~ 18:30</label><br>
						<label class="form-label">(휴게:12:30 ~ 13:30)</label></td>
				</tr>
				<tr>
					<th class="table-secondary ">신청정보</th>
					<td id="vacation">신청유형을 선택해주세요</td>
				</tr>
				<tr>
					<th class="table-secondary ">사유</th>
					<td>
						<div class="col-6">
							<input type="text" class="form-control" name="reason"
								required="required">
						</div>
					</td>
				</tr>
			</table>
			<input type="hidden" name="leave" id="leave" value="0"> <input
				type="hidden" name="useCount" id="useCount" value="0">
			<div class="d-flex justify-content-end">
				<button class="btn btn-info">등록</button>
			</div>
		</form>
		<br>
		<hr>
		<br>
		<div class="row mb-3">
			<div class="col">
				<h4>*신청내역</h4>
			</div>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="table-secondary">이름</th>
					<th class="table-secondary">부서명</th>
					<th class="table-secondary">연차사용날짜</th>
					<th class="table-secondary">휴가종류</th>
					<th class="table-secondary">사유</th>
					<th class="table-secondary">사용연차</th>
					<th class="table-secondary">승인 상태</th>
				</tr>
			</thead>
			<tbody class="data-work-status">
				<c:forEach items="${list}" var="item">
					<tr>
						<td class="">${item.empName}</td>
						<td class="">${item.deptName}</td>
						<td class="">${item.startDate}~${item.endDate}</td>
						<td class="">${item.vacationName}</td>
						<td class="">${item.reason}</td>
						<td class="">${item.useCount}</td>
						<td class="work-status mt-1 ml-3">${item.status}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>