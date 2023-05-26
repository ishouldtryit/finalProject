<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    
    <script type="text/javascript">
    $(function(){
        $('[name=workContent]').summernote({
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
            ],
            callbacks: {
                onImageUpload: function(files) {
                	console.log(files);
                	if(files.length != 1) return;
                	
                  //console.log("비동기 파일 업로드 시작");
                  //[1] FormData [2] processData [3] contentType
                  var fd = new FormData();
                  fd.append("attach", files[0]);
                  
                  $.ajax({
                	  url:"/rest/attachment/upload",
                	  method:"post",
                	  data:fd,
                	  processData:false,
                	  contentType:false,
                	  success:function(response){
                		  //console.log(response);
                		  
                		  //서버로 전송할 이미지 번호 정보 생성
                		  var input = $("<input>").attr("type", "hidden")
                		  							.attr("name", "attachmentNo")
                		  							.val(response.attachmentNo);
                		  
                		  $("form").prepend(input);
                		  
                		  var imgNode = $("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo); //PathVariable
                		  $("[name=workContent]").summernote('insertNode', imgNode.get(0)); //Jquery->JavaScript
                	  },
                	  error:function(){
                		  
                	  }
                  });
                  
                  // upload image to server and create imgNode...
                }
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
                        <textarea name="workContent"></textarea>
                      </div>
                  </div>
                  
				<div class="offset-md-2 col-md-8">
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
    
            
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>