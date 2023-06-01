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
	        $('#attachments').val('');
	        $('#fileList').empty();
	    }

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
	    }

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
	            removeButton.className = 'remove_button';
	            removeButton.dataset.fileName = file.name;
	            removeButton.innerText = 'X';
	            removeButton.addEventListener('click', () => deleteFile(file.name));

	            listItem.appendChild(removeButton);
	            listItem.appendChild(fileName);
	            fileListContainer.appendChild(listItem);
	        }
	    }

	    // FileListWrapper class definition
	    function FileListWrapper(files) {
	        const dataTransfer = new DataTransfer();
	        for (let i = 0; i < files.length; i++) {
	            dataTransfer.items.add(files[i]);
	        }
	        return dataTransfer.files;
	    }

	    // New code for managing file uploads
	    const dataTransfer = new DataTransfer();

	    $("#attachments").change(function() {
	        let fileArr = document.getElementById("attachments").files;

	        if (fileArr != null && fileArr.length > 0) {
	            // =====DataTransfer 파일 관리========
	            for (var i = 0; i < fileArr.length; i++) {
	                dataTransfer.items.add(fileArr[i]);
	            }
	            document.getElementById("attachments").files = dataTransfer.files;
	            console.log("dataTransfer =>", dataTransfer.files);
	            console.log("input FIles =>", document.getElementById("attachments").files);
	            // ==========================================
	        }
	    });

	    $("#fileList").click(function(event) {
	        let fileArr = document.getElementById("attachments").files;
	        if (event.target.className == 'remove_button') {
	            targetFile = event.target.dataset.fileName;

	            // ============DataTransfer================
	            for (var i = 0; i < dataTransfer.files.length; i++) {
	                if (dataTransfer.files[i].name == targetFile) {
	                    // 총용량에서 삭제
	                    total_file_size -= dataTransfer.files[i].size;

	                    dataTransfer.items.remove(i);
	                    break;
	                }
	            }
	            document.getElementById("attachments").files = dataTransfer.files;

	            const removeTarget = document.getElementById(targetFile);
	            removeTarget.remove();

	            console.log("dataTransfer 삭제후=>", dataTransfer.files);
	            console.log('input FIles 삭제후=>', document.getElementById("attachments").files);
	        }
	        
	        
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
                            <label class="form-label">참조자</label>
                           	<button>추가</button>
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