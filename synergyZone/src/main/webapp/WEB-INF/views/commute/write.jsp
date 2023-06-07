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
			case "공가":
				applicationType = "공가 신청";
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
		});

		$('#useCount').val(0);
		$('#result').text(0);

	});
</script>
</head>
<body>
	<div class="container">
		<form action="/commute/write" method="post">
			<h4>*신청정보</h4>
			<table class="table table-hover">
				<tr>
					<th>대상자</th>
					<td>${one.empName}<br>
						<table>
							<thead>
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
									<td>${one.residual}</td>
									<td id="result"></td>
								</tr>
							</tbody>
						</table>

					</td>
				</tr>
				<tr>
					<th>신청유형</th>
					<td><select id="vacationName" name="vacationName">
							<option value="">선택</option>
							<option value="연차">연차</option>
							<option value="병가">병가</option>
							<option value="공가">공가</option>
					</select></td>
				</tr>
				<tr>
					<th>신청일시</th>
					<td><input type="date" id="startDate" name="startDate"
						min="YYYY-01-01" max="YYYY-12-31"> ~ <input type="date"
						id="endDate" name="endDate" min="YYYY-01-01" max="YYYY-12-31">
					</td>
				</tr>
				<tr>
					<th>반차여부</th>
					<td><input type="checkbox" id="morningLeave"
						onchange="updateUseCountByCheckbox()" disabled>오전 반차 <input
						type="checkbox" id="afternoonLeave"
						onchange="updateUseCountByCheckbox()" disabled>오후 반차</td>
				</tr>
				<tr>
					<th>근무계획정보</th>
					<td><label>[근무일] 09:30 ~ 18:30</label><br> <label>(휴게:12:30
							~ 13:30)</label></td>
				</tr>
				<tr>
					<th>신청정보</th>
					<td id="vacation">신청유형을 선택해주세요</td>
				</tr>
				<tr>
					<th>사유</th>
					<td><input type="text" name="reason"></td>
				</tr>
			</table>
			<input type="hidden" name="useCount" id="useCount" value="0">
			<button>등록</button>
		</form>
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
				<c:forEach items="${list}" var="item">
					<tr>
						<td>${item.empName}</td>
						<td>${item.deptName}</td>
						<td>${item.startDate}~${item.endDate}</td>
						<td>${item.vacationName}</td>
						<td>${item.reason}</td>
						<td>${item.useCount}</td>
						<td><c:choose>
								<c:when test="${item.status == 0}">
				                   대기중
				            </c:when>
								<c:otherwise>
				                  	반려
				            </c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>