<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h1>내 연차내역</h1>
	<h1 id="currentDate"></h1>
	<hr>
	<!-- 해당 페이지도 view로 다시 묶어서 해야함 -->
	<div>
		<table>
		  <thead>
		    <tr>
		      <th></th>
		      <th>총 연차</th>
		      <th>사용연차</th>
		      <th>잔여 연차</th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td>사원써야함</td>
		      <td>${one.total}</td>
		      <td>${one.uesd}</td>
		      <td>${one.residual}</td>
		    </tr>
		  </tbody>
		</table>
	</div>
	<hr>
  <select name="year" id="year-select"></select>
  <div>
  	<div id="table-container"></div>
  </div>
	<p class="mt-50 mb-50">
     		<h2>empNo=${sessionScope.empNo}</h2>
     		<h2>jobNo=${sessionScope.jobNo}</h2>
     		<span>
     		Copyright ©2023 SYNERGYZONE. All Rights Reserved.
     		</span>
     	</p>
     	

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
  var currentDate = new Date();
  var year = currentDate.getFullYear();
  var month = currentDate.getMonth() + 1;
  var day = currentDate.getDate();

  var formattedDate = year + '-' + ('0' + month).slice(-2) + '-' + ('0' + day).slice(-2);
  $('#currentDate').text(formattedDate);
});
</script>
  <script>
    $(function() {
    	function createTable(data) {
    		  var tableElement = $("<table class='table table-hover'>");

    		  
    		  var headerRow = $("<tr>");
    		  headerRow.append($("<th>").text("연차사용날짜"));
    		  headerRow.append($("<th>").text("휴가 종류"));
    		  headerRow.append($("<th>").text("사유"));
    		  headerRow.append($("<th>").text("사용 연차"));
    		  tableElement.append(headerRow);

    		  
    		  for (var i = 0; i < data.length; i++) {
    		    var rowData = data[i];
    		    var row = $("<tr>");

    		  
    		    row.append($("<td>").text(rowData.startDate + ' ~ ' + rowData.endDate));
    		    row.append($("<td>").text(rowData.vacationName));
    		    row.append($("<td>").text(rowData.reason));
    		    row.append($("<td>").text(rowData.useCount));

    		    tableElement.append(row);
    		  }

    		  return tableElement;
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
		    var option = $("<option>").val(yearRange[i]).text(yearRange[i] + "-01 ~ " + yearRange[i] + "-12");
		    selectElement.append(option);
		  }
		
		  selectElement.val(yearRange[yearRange.length]); // 첫 번째 값을 기본값으로 설정
		
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
        	  url: "http://localhost:8080/rest/vacation/",
        	  type: "GET",
        	  data: { selectedValue: selectedValue },
        	  success: function(data) {
        		  var table = createTable(data);
        		  // 테이블을 원하는 위치에 추가
        		  $("#table-container").empty().append(table);
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
