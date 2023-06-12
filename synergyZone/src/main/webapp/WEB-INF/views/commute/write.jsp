<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
  $(function() {
    $('[name=workContent]').summernote({
      placeholder: '내용 작성',
      tabsize: 4,
      height: 250,
      toolbar: [
        ['style', ['style']],
        ['font', ['bold', 'underline', 'clear']],
        ['color', ['color']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['table', ['table']],
      ]
    });

    // 파일 선택 시 파일 목록 표시
    $(document).on('change', '#attachments', function() {
      const fileListContainer = document.getElementById('fileList');
      const existingFiles = Array.from(document.querySelectorAll('#fileList li'));
      const newFiles = Array.from(this.files);

      const mergedFiles = existingFiles.map(fileItem => {
        const fileName = fileItem.querySelector('span').innerText;
        return {
          name: fileName,
          file: null
        };
      });

      newFiles.forEach(file => {
        mergedFiles.push({
          name: file.name,
          file: file
        });
      });

      displayFileList(mergedFiles);
    });

    // Delete all files
    const deleteAll = () => {
      $('#fileList').empty();
    };

    // Delete a specific file
    const deleteFile = (fileName) => {
      const fileListContainer = document.getElementById('fileList');
      const listItem = Array.from(fileListContainer.querySelectorAll('li')).find(item => {
        const span = item.querySelector('span');
        return span.innerText === fileName;
      });
      if (listItem) {
        fileListContainer.removeChild(listItem);
      }
    };

    // Display file list
    function displayFileList(files) {
      const fileListContainer = document.getElementById('fileList');
      fileListContainer.innerHTML = '';

      for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const fileId = `file-${i}`;
        const listItem = document.createElement('li');
        listItem.id = fileId;

        const fileName = document.createElement('span');
        fileName.innerText = file.name;

        const removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.className = 'remove_button btn btn btn-sm';
        removeButton.dataset.fileName = file.name;
        removeButton.innerHTML = '<i class="fa-solid fa-xmark"></i>';
        removeButton.addEventListener('click', () => deleteFile(file.name));

        listItem.appendChild(fileName);
        listItem.appendChild(removeButton);
        fileListContainer.appendChild(listItem);
      }
    }

    // Date validation
    $("#workStart").change(function() {
      var workStart = new Date($(this).val());
      var workDeadline = new Date($("#workDeadline").val());

      // Check if the selected start date is after the deadline date
      if (workStart > workDeadline) {
        $("#workDeadline").val($(this).val());
      }
    });

    $("#workDeadline").change(function() {
      var workStart = new Date($("#workStart").val());
      var workDeadline = new Date($(this).val());

      // Check if the selected deadline date is before the start date
      if (workDeadline < workStart) {
        $("#workStart").val($(this).val());
      }
    });

    // Form validation
    function validateForm() {
      // 비밀글
      if ($('#workSecretCheck').is(':checked')) {
        $("#workSecret").val("Y");
      } else {
        $("#workSecret").val("N");
      }

      // 제목 입력 확인
      var workTitle = $('[name=workTitle]').val();
      if (workTitle.trim() === '') {
        alert('제목을 입력해 주세요.');
        return false;
      }

      // 종류 선택 확인
      var workType = $('#workType').val();
      if (workType.trim() === '') {
        alert('종류를 선택해 주세요.');
        return false;
      }

      // 업무 선택 확인
      var workStatus = $('#workStatus').val();
      if (workStatus.trim() === '') {
        alert('상태를 선택해 주세요.');
        return false;
      }

      // 업무일 입력 확인
      var workStart = $('[name=workStart]').val();
      var workDeadline = $('[name=workDeadline]').val();
      if (workStart.trim() === '' || workDeadline.trim() === '') {
        alert('업무일을 입력해 주세요.');
        return false;
      }

      // 내용 입력 확인
      var workContent = $('[name=workContent]').val();
      if (workContent.trim() === '') {
        alert('내용을 입력해 주세요.');
        return false;
      }

      return true;
    }
  });
</script>

<form action="write" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
  <div class="container-fluid mt-4">
    <div class="row">
      <div class="offset-md-2 col-md-8">
        <div class="row mt-4">
          <div class="col">
            <label class="form-label">제목</label>
            <input class="form-control rounded" type="text" name="workTitle" placeholder="제목">
          </div>
        </div>
        <div class="row mt-4">
          <div class="col">
            <label class="form-label">종류</label>
            <select id="workType" name="workType" class="form-select rounded">
              <option value="">선택하세요</option>
              <option>일일업무</option>
              <option>주간업무</option>
              <option>월간업무</option>
            </select>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col">
            <label class="form-label">상태</label>
            <select id="workStatus" name="workStatus" class="form-select rounded">
              <option value="">선택하세요</option>
              <option value="0">요청</option>
              <option value="1">진행</option>
              <option value="2">완료</option>
              <option value="3">보류</option>
            </select>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col">
            <label class="form-label">업무일</label>
            <div class="d-flex">
              <input class="form-control rounded me-2" type="date" id="workStart" name="workStart" placeholder="YYYY-MM-DD">
              <input class="form-control rounded" type="date" id="workDeadline" name="workDeadline" placeholder="YYYY-MM-DD">
            </div>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col">
            <textarea name="workContent"></textarea>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col">
            <label class="form-label">파일첨부</label>
            <input class="form-control rounded" type="file" id="attachments" name="attachments" multiple="multiple">
          </div>
        </div>
        <div class="row mt-4">
          <div class="col">
            <label class="form-label">첨부된 파일 목록</label>
            <div id="preview"></div>
            <div id="fileList"></div>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col">
            <label class="form-label">공개여부</label>
            <input type="checkbox" id="workSecretCheck">
            <input type="hidden" id="workSecret" name="workSecret">
            <button type="submit" class="btn btn-primary">등록</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
=======
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
					<h4>* 신청정보</h4>
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
				<h4>* 신청내역</h4>
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
>>>>>>> refs/remotes/origin/main
