<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

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


  });
  
  

  function validateForm() {
    if ($('#workSecretCheck').is(':checked')) {
      $("#workSecret").val("Y");
    } else {
      $("#workSecret").val("N");
    }
    
    return true;
  }
  
  var attachmentList = [];

  function addToAttachmentList(attachmentNo) {
      attachmentList.push(attachmentNo);
      console.log(attachmentList);
      updateAttachmentListInput();
  }

  function updateAttachmentListInput() {
      var attachmentListInput = document.getElementById('attachmentList');
      attachmentListInput.value = attachmentList.join(',');
  }
</script>

<form action="edit" method="post" enctype="multipart/form-data">

	<input type="hidden" name="workNo" value="${workBoardDto.workNo}">
	<div class="container-fluid mt-4">

		<div class="row">
			<div class="offset-md-2 col-md-8">

				<div class="row mt-4">
					<div class="col">
						<label class="form-label">제목</label> <input
							class="form-control rounded" type="text" name="workTitle"
							placeholder="제목" value="${workBoardDto.workTitle}">
					</div>
				</div>

				<div class="row mt-4">
					<div class="col">
						<label class="form-label">종류</label> <select id="workType"
							name="workType" class="form-select rounded">
							<option value="">선택하세요</option>
							<option value="일일업무"
								${workBoardDto.workType == '일일업무' ? 'selected' : ''}>일일업무</option>
							<option value="주간업무"
								${workBoardDto.workType == '주간업무' ? 'selected' : ''}>주간업무</option>
							<option value="월간업무"
								${workBoardDto.workType == '월간업무' ? 'selected' : ''}>월간업무</option>
						</select>
					</div>
				</div>

				<div class="row mt-4">
					<div class="col">
						<label class="form-label">업무</label> <select id="workStatus"
							name="workStatus" class="form-select rounded">
							<option value="">선택하세요</option>
							<option value="0"
								${workBoardDto.workStatus == 0 ? 'selected' : ''}>요청</option>
							<option value="1"
								${workBoardDto.workStatus == 1 ? 'selected' : ''}>진행</option>
							<option value="2"
								${workBoardDto.workStatus == 2 ? 'selected' : ''}>완료</option>
							<option value="3"
								${workBoardDto.workStatus == 3 ? 'selected' : ''}>보류</option>
						</select>
					</div>
				</div>

				<div class="row mt-4">
					<div class="col">
						<label class="form-label">업무일</label> <input
							class="form-control rounded" type="date" name="workStart"
							value="${workBoardDto.workStart}"> ~ <input
							class="form-control rounded" type="date" name="workDeadline"
							value="${workBoardDto.workDeadline}">
					</div>
				</div>

				<div class="row mt-4">
					<div class="col">
						<textarea name="workContent" id="workContent">${workBoardDto.workContent}</textarea>
					</div>
				</div>

				<div class="col">
					<label class="form-label">파일첨부</label> <input
						class="form-control rounded" type="file" name="attachments"
						multiple="multiple">

					<!-- 
		                  수정사항 
		                  
		                  아이콘추가 버튼추가 
		                  버튼 클릭시 list에 ${file.attachmentNo} 해당 값을 저장 
		                  form으로 전송시 해당 list 값과 select한 값을 비교하여 있는것만 삭제 없으면 버림
		                  (controller if문 참고)
		                  추가된값은 그대로 진행
		
		               -->
					첨부파일목록
					<c:forEach var="file" items="${files}">
						<div class="attachment">
							<li><span
								href="/attachment/download?attachmentNo=${file.attachmentNo}">
									${file.attachmentNo} </span>
								<button class="btn btn-sm" type="button"
									onclick="addToAttachmentList(${file.attachmentNo})">
									<i class="fa-solid fa-xmark"></i>
								</button></li>
						</div>
					</c:forEach>

				</div>


				<div class="row mt-4">
					<div class="col">
						<label class="form-label">공개여부</label> <input type="checkbox"
							id="workSecretCheck" value="${workBoardDto.workSecret}">
						<input type="hidden" id="workSecret" name="workSecret" value="Y">
						<input type="hidden" id="attachmentList" name="attachmentList">
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
				</div>



				<div class="row mt-4">
					<div class="col">
						<button class="btn btn-primary w-100">수정</button>
					</div>
				</div>




			</div>
		</div>


	</div>
</form>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>