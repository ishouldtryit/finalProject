<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
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
     
       $(document).ready(function(e){
    	   var formObj = $("form[role='form']");
    		$("button[type='submit']").on("click", function(e){
    			e.preventDefault();
    			console.log("submit clicked");
    			
    			var str = "";
    			
    			$(".uploadResult ul li").each(function(i, obj){
    				var jobj = $(obj);
    				console.dir(jobj);
    				
    				str += "<input type = 'hidden' name = 'attachList["+i+"].fileName' value = '" + jobj.data("filename")+"'>";
    				str += "<input type = 'hidden' name = 'attachList["+i+"].uuid' value = '" + jobj.data("uuid") + "'>";
    				str += "<input type = 'hidden' name = 'attachList["+i+"].uploadPath' value = '" + jobj.data("path") + "'>";
    				str += "<input type = 'hidden' name = 'attachList["+i+"].fileType' value = '" + jobj.data("type") + "'>";
    		
    			});
    			formObj.append(str).submit();
    		});
    	  
    	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    	  var maxSize = 10000000;
    	  
    	  function checkExtension(fileName, fileSize){
    		  if(fileSize >= maxSize){
    			  alert("파일 사이즈 초과");
    			  return false;
    		  }
    		  
    		  if(regex.test(fileName)){
    			  alert("해당 종류의 파일은 업로드할 수 없습니다");
    			  return false;
    		  }
    		  return true;
    		  
    	  }
    	  
    	  $("input[type = 'file']").change(function(e){
    		  var formData = new FormData();
    		  var inputFile = $("input[name='uploadFile']");
    		  var files = inputFile[0].files;

    		  for(var i=0; i<files.length; i++){
    		      if(!checkExtension(files[i].name, files[i].size)){
    		          return false;
    		      }
    		      formData.append("uploadFile", files[i]);
    		  }


              $.ajax({
                url : '/rest/attachment/upload',
                processData : false,
                contentType : false,
                data : formData,
                type : 'POST',
                dataType : 'json',
                success:function(result){
                    console.log(result);
                    showUploadResult(result);
                }
              });
    		  
    	  });

          function showUploadResult(uploadResultArr){
		  if(!uploadResultArr || uploadResultArr.length == 0){return ;}
		  var uploadUL = $(".uploadResult ul");
		  var str = "";
		  
		  $(uploadResultArr).each(function(i, obj){
			  
			   //image type
		        if(obj.image){
		          var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
// 		          str += "<li><a href='/download?fileName=" + fileCallPath +"'>"
// 		        		  + "<img src = '/resources/img/attach.png'>" + obj.fileName + "</a></li>";
		          str += "<li data-path = '" + obj.uploadPath + "'";
		          str += "data-uuid = '" + obj.uuid + "'data-filename='" + obj.fileName + "'data-type = '" + obj.image + "'";
		          str += "<span> "+ obj.fileName+"</span>";
		          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		          str += "<img src='/display?fileName="+fileCallPath+"'>";
		          str += "</div>";
		          str +"</li>";
		        }else{
		          var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
		          var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		          
		          str += "<li";
		          str += "data-path ='" + obj.uploadPath + "' data-uuid ='" + obj.uuid + "'data-filename'" + obj.fileName
		          + "'data-type ='" + obj.image + "'><div>";
		          str += "<li><div>";
		          str += "<span> "+ obj.fileName+"</span>";
		          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		          str += "</div>";
		          str +"</li>";
		        } 
		  });
			uploadUL.append(str);
	     }
          
          $(".uploadResult").on("click", "button", function(e){
    		  console.log("delete file");
    		  
    		  var targetFile = $(this).data("file");
    		  var type = $(this).data("type");
    		  
    		  var targetLi = $(this).closest("li");
    		  
    		  $.ajax({
    		  	url : '/rest/attachment/delete',
    		  	data : {fileName : targetFile, type : type},
    		  	dataType : 'text',
    		  	type : 'POST',
    		  		success : function(result) {
    		  			alert(result);
    		  			targetLi.remove();
    		  		}
    		  });
    	  });
          
          
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
			        <div class="col-lg-12">
			            <div class="card shadow mb-4">
			                <div class="card-header py-3">
			                    <h4 class="m-0 font-weight-bold text-primary">File Attach</h4>
			                </div>
			                <div class="card-body">
			                    <div class="form-group uploadDiv">
			                        <input type="file" name="uploadFile" multiple>
			                    </div>
			                    <div class="uploadResult">
			                        <ul></ul>
			                    </div>
			                </div>
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