<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
<style>
.outer-border {
	border: 2px solid #eaeaea;
	padding: 20px;
	margin-bottom: 30px;
}

.my-card { 
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 10px;
	border-right: 1px solid #eaeaea;
	padding-right: 10px;
	width: calc(25% - 15px);
	box-sizing: border-box;
}

.my-card-img { 
	display: inline-block;
	vertical-align: middle;
}

.my-card-body { 
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
		<h4>내 출장신청 내역</h4>
		<div class="row justify-content-center">
			<div class="col-auto d-flex">
				<h4 id="currentDate"></h4>
				<button class="btn ml-2" type="button" id="today-btn">오늘</button>
			</div>
		</div>
		
							<input class="empDate" type="hidden" value="${one.empHireDate}">
		<hr>
		<div class="row">
			<div class="col-2">
				<select name="year" id="year-select" class="form-select form-select-sm mb-3"></select>
			</div>
		</div>
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

			var formattedDate = year + '-' + ('0' + month).slice(-2) + '-'
					+ ('0' + day).slice(-2);
			$('#currentDate').text(formattedDate);
		});
	</script>
	<script>
		$(function() {
			//페이지 로딩시 가져옴
			$.ajax({
				url : "http://localhost:8080/rest/vacation/trip",
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
				  headerRow.append($("<th>").text("출장종류"));
				  headerRow.append($("<th>").text("출장신청날짜"));
				  headerRow.append($("<th>").text("기간"));
				  headerRow.append($("<th>").text("출발지"));
				  headerRow.append($("<th>").text("경유지"));
				  headerRow.append($("<th>").text("목적지"));
				  headerRow.append($("<th>").text("장소"));
				  headerRow.append($("<th>").text("이동수단"));
				  headerRow.append($("<th>").text("목적"));
				  headerRow.append($("<th>").text("비고"));
				  tableElement.append(headerRow);

				  if (data.length === 0) {
				    var emptyRow = $("<tr>").append($("<td colspan='11'>").text("목록이 없습니다."));
				    tableElement.append(emptyRow);
				    var emptyRowContainer = $("<div class='empty-row-container'>").append(tableElement);
				    return emptyRowContainer;
				  } else {
				    for (var i = 0; i < data.length; i++) {
				      var rowData = data[i];
				      var row = $("<tr>");
				      row.append($("<td>").text(rowData.name));
				      row.append($("<td>").text(rowData.startDate + " ~ " + rowData.endDate));
				      row.append($("<td>").text(rowData.period));
				      row.append($("<td>").text(rowData.startPlace));
				      row.append($("<td>").text(rowData.middlePlace));
				      row.append($("<td>").text(rowData.endPlace));
				      row.append($("<td>").text(rowData.place));
				      row.append($("<td>").text(rowData.work));
				      row.append($("<td>").text(rowData.purpose));
				      row.append($("<td>").text(rowData.notes));

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
				var startYear = new Date($('.empDate').val()).getFullYear();
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
					url : "http://localhost:8080/rest/vacation/trip",
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
			$("#today-btn").click(function() {
			      $("#year-select option:first").prop("selected", true);
			      $.ajax({
						url : "http://localhost:8080/rest/vacation/trip",
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
			    });
			
				

			// 이벤트 리스너 등록
			$("#year-select").on("change", sendSelectedValue);

			// 함수 호출
			generateSelectElement();

		});
	</script>
</body>
</html>
