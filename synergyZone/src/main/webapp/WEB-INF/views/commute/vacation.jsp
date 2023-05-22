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
      // ���� �⵵�� �������� �Լ�
      function getCurrentYear() {
        return new Date().getFullYear();
      }

      // �Ի��Ϸκ����� �⵵ ������ �����ϴ� �Լ�
      function generateYearRange(startYear, endYear) {
        var yearRange = [];

        for (var year = startYear; year <= endYear; year++) {
          yearRange.push(year);
        }

        return yearRange;
      }

      // select ��Ҹ� �����ϴ� �Լ�
      function generateSelectElement() {
        var selectElement = $("#year-select");
        var currentYear = getCurrentYear();
        var startYear = 2020; // ���� �⵵
        var endYear = currentYear; // ���� �⵵

        var yearRange = generateYearRange(startYear, endYear);

        for (var i = yearRange.length - 1; i >= 0; i--) {
          var option = $("<option>").val(yearRange[i]).text(yearRange[i] + "-01 ~ " + yearRange[i] + "-12");
          selectElement.append(option);
        }
      }

      // ���õ� ���� ������ �����ϴ� �Լ�
      function sendSelectedValue() {
        var selectElement = $("#year-select");
        var selectedValue = selectElement.val();

        // AJAX ��û
        $.ajax({
          url: "http://localhost:8080/rest/vacation/",
          type: "POST",
          data: JSON.stringify({ selectedValue: selectedValue }),
          contentType: "application/json;charset=UTF-8",
          success: function(data) {
            console.log("������ ���� ���������� ���۵Ǿ����ϴ�.");
            // ���⿡�� �ʿ��� �۾��� �����ϼ���
          }
        });
      }

      // �̺�Ʈ ������ ���
      $("#year-select").on("change", sendSelectedValue);

      // �Լ� ȣ��
      generateSelectElement();
    });
  </script>
</body>
</html>
