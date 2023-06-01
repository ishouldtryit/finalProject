<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(function() {
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
		
		var variable = 0;

		// 체크박스가 체크되면 변수에 0.5를 추가하는 함수
		function addHalfDay() {
		  if ($('#morningLeave').is(':checked')) {
		    variable += 0.5;
		  }else{
			  variable -= 0.5;
		  }

		  if ($('#afternoonLeave').is(':checked')) {
		    variable += 0.5;
		  }else{
			  variable -= 0.5;
		  }
		}

		// startDate와 endDate의 차이를 계산하여 주말을 제외한 숫자를 변수에 추가하는 함수
		function calculateBusinessDays(startDate, endDate) {
		  var start = new Date(startDate);
		  var end = new Date(endDate);

		  // 시작일과 종료일 사이의 모든 날짜를 반복하면서 주말을 제외한 날짜 수를 계산
		  while (start <= end) {
		    var dayOfWeek = start.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
		    if (dayOfWeek !== 0 && dayOfWeek !== 6) {
		      variable++;
		    }
		    start.setDate(start.getDate() + 1);
		  }

		  // 변수 값을 <td class="result"></td>에 할당하는 로직 추가
		  $('#result').text(variable); // 변수 값을 결과 요소에 할당
		}

	});

	
</script>
<script>

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
				<td><input type="date" id="startDate" name="startDate" min="YYYY-01-01"
					max="YYYY-12-31"> ~ <input type="date" id="endDate" name="endDate" 
					min="YYYY-01-01" max="YYYY-12-31"></td>
			</tr>
			<tr>
				<th>반차여부</th>
				<td><input type="checkbox" id="morningLeave">오전 반차 <input
					type="checkbox" id="afternoonLeave">오후 반차</td>
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
		<input type="hidden" name="useCount">
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
					<td>${item.startDate} ~ ${item.endDate}</td>
					<td>${item.vacationName}</td>
					<td>${item.reason}</td>
					<td>${item.useCount}</td>
					<td>${item.stauts}</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
	</div>
</body>
</html>