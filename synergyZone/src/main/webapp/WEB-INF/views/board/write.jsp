<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=boardContent]').summernote({
            placeholder: '내용 작성',
            tabsize: 4,//탭키를 누르면 띄어쓰기 몇 번 할지
            height: 250,//최초 표시될 높이(px)
            toolbar: [//메뉴 설정
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
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
//             $('#attachments').val('');
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
    
            // Remove the file from the dataTransfer object
            for (let i = 0; i < dataTransfer.files.length; i++) {
                if (dataTransfer.files[i].name === fileName) {
                    dataTransfer.items.remove(i);
                    break;
                }
            }
            document.getElementById("attachments").files = dataTransfer.files;
            console.log("dataTransfer after deletion =>", dataTransfer.files);
            console.log("input Files after deletion =>", document.getElementById("attachments").files);
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
               deleteAll();
               
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

//                 const removeTarget = document.getElementById(targetFile);
//                 removeTarget.remove();

                console.log("dataTransfer 삭제후=>", dataTransfer.files);
                console.log('input FIles 삭제후=>', document.getElementById("attachments").files);
            }
            
            
        });

    });
</script>

<form action="write" method="post" autocomplete="off">
<%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>

<%-- 답글일 때는 정보가 한 개 더 전송되어야 한다(boardParent) --%>
<c:if test="${boardParent != null}">
<input type="hidden" name="boardParent" value="${boardParent}">
</c:if>

<div class="container">

   <!-- 제목 -->
   <div class="row center">
      <c:choose>
         <c:when test="${boardParent == null}">
            <h2>새글 작성</h2>
         </c:when>
         <c:otherwise>
            <h2>답글 작성</h2>
         </c:otherwise>
      </c:choose>
   </div>
   
    <div class="row p-3" >
         <label for="draftTitle" class="form-label">제목</label>
         <input type="text" id="draftTitle" name="boardTitle" v-model="boardlVO.boardDto.boardTitle" class="form-control" v-on:input="boardVO.boardDto.boardTitle = $event.target.value">
       </div>
       
       <div class="row p-3">
         <label for="draftContent" class="form-label">내용</label>
         <textarea id="draftContent" name="boardContent" required style="min-height: 300px;" v-model="boardVO.boardDto.boardContent" class="form-control" v-on:input="boardVO.boardDto.boardContent = $event.target.value"></textarea>
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
            
   <div class="row">
      <button type="submit" class="btn btn-info w-80 mt-3 reply-insert-btn">등록</button>
   </div>
</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>