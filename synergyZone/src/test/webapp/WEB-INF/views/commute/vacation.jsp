<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
  <select name="year" id="year-select"></select>

  <script>
    $(function() {
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
        var startYear = 2020; // 시작 년도
        var endYear = currentYear; // 현재 년도

        var yearRange = generateYearRange(startYear, endYear);

        for (var i = yearRange.length - 1; i >= 0; i--) {
          var option = $("<option>").val(yearRange[i]).text(yearRange[i] + "-01 ~ " + yearRange[i] + "-12");
          selectElement.append(option);
        }
      }

      // 선택된 값을 서버로 전송하는 함수
      function sendSelectedValue() {
        var selectElement = $("#year-select");
        var selectedValue = selectElement.val();

        // AJAX 요청
        $.ajax({
        	  url: "http://localhost:8080/rest/vacation/",
        	  type: "GET",
        	  success: function(data) {
        	    console.log("선택한 값이 성공적으로 전송되었습니다.");
        	    console.log(data); // 받은 데이터를 콘솔에 출력

        	    // 받은 데이터를 활용하여 필요한 작업 수행
        	    // 예: 받은 데이터를 DOM 요소에 추가하거나 처리하는 등의 작업
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
