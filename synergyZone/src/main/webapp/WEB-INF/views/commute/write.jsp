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
