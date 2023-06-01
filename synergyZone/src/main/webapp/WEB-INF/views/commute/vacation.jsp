<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<style>
.outer-border {
	border: 1px solid #eaeaea;
	padding: 10px;
	margin-bottom: 20px;
}

.my-card { /* 변경된 클래스 이름 */
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 10px;
	border-right: 1px solid #eaeaea;
	padding-right: 10px;
	width: calc(25% - 15px);
	box-sizing: border-box;
}

.my-card-img { /* 변경된 클래스 이름 */
	display: inline-block;
	vertical-align: middle;
}

.my-card-body { /* 변경된 클래스 이름 */
	display: inline-block;
	vertical-align: middle;
	text-align: center;
}
</style>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="d-flex">
			<h1>내 연차내역</h1>
			<h1 id="currentDate"></h1>
		</div>
		<hr>
		<!-- 해당 페이지도 view로 다시 묶어서 해야함 -->
		<div>
			<div>
				<div class="outer-border">
					<div class="row justify-content-start mt-5">
						<div class="my-card text-center">
							<!-- 변경된 클래스 이름 -->
							<img width="50" height="50"
								src="<c:choose>
                       <c:when test="${employeeDto.attachmentNo > 0}">
                         /attachment/download?attachmentNo=${employeeDto.attachmentNo}
                       </c:when>
                       <c:otherwise>
                         https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
                       </c:otherwise>
                            </c:choose>"
								style="border-radius: 50%;" class="my-card-img">
							<div class="my-card-body">
								<!-- 변경된 클래스 이름 -->
								<h5 class="card-title">${one.empName}${one.jobName}</h5>
							</div>
						</div>
						<div class="my-card text-center">
							<!-- 변경된 클래스 이름 -->
							<div class="my-card-body">
								<!-- 변경된 클래스 이름 -->
								<h5 class="card-title">총 연차</h5>
								<p class="card-text">${one.total}</p>
							</div>
						</div>
						<div class="my-card text-center">
							<!-- 변경된 클래스 이름 -->
							<div class="my-card-body">
								<!-- 변경된 클래스 이름 -->
								<h5 class="card-title">사용 연차</h5>
								<p class="card-text">${one.used}</p>
							</div>
						</div>
						<div class="my-card text-center">
							<!-- 변경된 클래스 이름 -->
							<div class="my-card-body">
								<!-- 변경된 클래스 이름 -->
								<h5 class="card-title">잔여 연차</h5>
								<p class="card-text">${one.residual}</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<select name="year" id="year-select"></select>
		<div>
			<div id="table-container"></div>
		</div>
		
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(function() {
					var currentDate = new Date();
					var year = currentDate.getFullYear();
					var month = currentDate.getMonth() + 1;
					var day = currentDate.getDate();

					var formattedDate = year + '-' + ('0' + month).slice(-2)
							+ '-' + ('0' + day).slice(-2);
					$('#currentDate').text(formattedDate);
				});
	</script>
	<script>
		$(function() {
			//페이지 로딩시 가져옴
			$.ajax({
				url : "http://localhost:8080/rest/vacation/",
				type : "GET",
				data : {
					selectedValue : getCurrentYear()
				},
				success : function(data) {
					console.log(data);
					var table = createTable(data);
					$("#table-container").empty().append(table);
				}
			});

			function createTable(data) {
				  var tableElement = $("<table class='table table-hover'>");

				  var headerRow = $("<tr>");
				  headerRow.append($("<th>").text("이름"));
				  headerRow.append($("<th>").text("부서명"));
				  headerRow.append($("<th>").text("연차사용날짜"));
				  headerRow.append($("<th>").text("휴가 종류"));
				  headerRow.append($("<th>").text("사유"));
				  headerRow.append($("<th>").text("사용 연차"));
				  tableElement.append(headerRow);

				  if (data.length === 0) {
				    var emptyRow = $("<tr>").append($("<td colspan=''>").text("목록이 없습니다."));
				    tableElement.append(emptyRow);
				    var emptyRowContainer = $("<div class='empty-row-container'>").append(tableElement);
				    return emptyRowContainer;
				  } else {
				    for (var i = 0; i < data.length; i++) {
				      var rowData = data[i];
				      var row = $("<tr>");

				      row.append($("<td>").text(rowData.empName));
				      row.append($("<td>").text(rowData.deptName));
				      row.append($("<td>").text(rowData.startDate + ' ~ ' + rowData.endDate));
				      row.append($("<td>").text(rowData.vacationName));
				      row.append($("<td>").text(rowData.reason));
				      row.append($("<td>").text(rowData.useCount));

				      tableElement.append(row);
				    }
				    return tableElement;
				  }
				}

			// 현재 년도를 가져오는 함수
			function getCurrentYear() {
				return new Date().getFullYear();
			}

			// 입사일로부터의 년도 범위를 생성하는 함수
			function generateYearRange(startYear, endYear) {
				var yearRange = [];

				for (var year = startYear; year <= endYear; year++) {
					yearRange.push(year);
				}

				return yearRange;
			}

			// select 요소를 생성하는 함수
			function generateSelectElement() {
				var selectElement = $("#year-select");
				var currentYear = getCurrentYear();
				var startYear = 2020; // 시작 년도 ******************* 입사일로 변경
				var endYear = currentYear; // 현재 년도

				var yearRange = generateYearRange(startYear, endYear);

				for (var i = yearRange.length - 1; i >= 0; i--) {
					var option = $("<option>").val(yearRange[i]).text(
							yearRange[i] + "-01 ~ " + yearRange[i] + "-12");
					selectElement.append(option);
				}
				selectElement.on("change", function() {
					// 선택된 값이 변경될 때의 동작을 정의
					var selectedValue = $(this).val();
					// 선택된 값에 따라 동작 수행
				});
			}

			// 선택된 값을 서버로 전송하는 함수

			function sendSelectedValue() {
				var selectElement = $("#year-select");
				var selectedValue = selectElement.val();
				// AJAX 요청
				$.ajax({
					url : "http://localhost:8080/rest/vacation/",
					type : "GET",
					data : {
						selectedValue : selectedValue
					},
					success : function(data) {
						
							var table = createTable(data);
							$("#table-container").empty().append(table);
						
					},
					error : function() {
						$("#table-container").text("데이터를 가져오는 데 실패했습니다.");
					}
				});
			}

			// 이벤트 리스너 등록
			$("#year-select").on("change", sendSelectedValue);

			// 함수 호출
			generateSelectElement();

		});
	</script>
</body>
</html>
