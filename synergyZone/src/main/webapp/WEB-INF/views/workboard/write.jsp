<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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

    $("[name=attachments]").change(function() {
      const attachmentElement = $("#attachments")[0];
      const fileListElement = $("#fileList");

      const getData = async () => {
        const formData = new FormData();

        for (let i = 0; i < attachmentElement.files.length; i++) {
          formData.append("attachments", attachmentElement.files[i]);
        }

        const url = "/rest/attachment/upload";

        try {
          const response = await axios.post(url, formData);
          console.log(response);

          fileListElement.empty();

          response.data.forEach(file => {
            const attachmentDiv = $("<div>").attr("id", "attachment-" + file.attachmentNo);
            const fileNameElement = $("<p>").text(file.attachmentName);
            const deleteButton = $("<i>")
              .addClass("btn btn-danger delete-attachment fas fa-times")
              .attr("data-attachment-no", file.attachmentNo);

            attachmentDiv.append(fileNameElement, deleteButton);
            fileListElement.append(attachmentDiv);
          });
        } catch (error) {
          console.error(error);
        }
      };

      getData();
    });

//     function getList() {
//     	  const fileListElement = $("#fileList");
//     	  const url = "/rest/attachment/list/" + attachmentNo;

//     	  axios
//     	    .get(url)
//     	    .then((response) => {
//     	      console.log(response.data);
//     	      updateFileList(response.data);
//     	    })
//     	    .catch((error) => {
//     	      console.error(error);
//     	    });
//     	}

    function updateFileList(files) {
    	  const fileListElement = $("#fileList");
    	  fileListElement.empty();

    	  files.forEach((file) => {
    	    const attachmentDiv = $("<div>").attr("id", "attachment-" + file.attachmentNo);
    	    const fileNameElement = $("<p>").text(file.attachmentName);
    	    const deleteButton = $("<i>")
    	      .addClass("btn btn-danger delete-attachment fas fa-times")
    	      .attr("data-attachment-no", file.attachmentNo);

    	    attachmentDiv.append(fileNameElement, deleteButton);
    	    fileListElement.append(attachmentDiv);
    	  });
    	}

    function deleteAttachment(attachmentNo) {
    	  const url = "/rest/attachment/delete/" + attachmentNo;

    	  axios
    	    .delete(url)
    	    .then((response) => {
    	      if (response.status === 200) {
    	        console.log("Attachment deleted successfully.");
    	        // 첨부 파일을 삭제한 후 해당 첨부 파일 div 요소를 삭제
    	        $("#attachment-" + attachmentNo).remove();
    	      } else {
    	        console.log("Failed to delete attachment.");
    	      }
    	    })
    	    .catch((error) => {
    	      console.error(error);
    	    });
    	}

    	$(document).on("click", ".delete-attachment", function() {
    	  const attachmentNo = $(this).data("attachment-no");
    	  deleteAttachment(attachmentNo);
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
                            <label class="form-label">업무</label>
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
                            <input class="form-control rounded" type="date" name="workStart">
                            ~
                            <input class="form-control rounded" type="date" name="workDeadline">
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
				        <div id="fileList">
				        </div>
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