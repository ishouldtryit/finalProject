<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- summernote cdn -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=noticeContent]').summernote({
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
					//console.log(files);
					if(files.length != 1) return;
					
					//console.log("비동기 파일 업로드 시작");
					//[1] FormData [2] processData [3] contentType
					var fd = new FormData();
					fd.append("attach", files[0]);
					
					$.ajax({
						url:contextPath+"/rest/attachment/upload",
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
							
							//에디터에 추가할 이미지 생성
							var imgNode = $("<img>").attr("src", contextPath+"/rest/attachment/download/"+response.attachmentNo);
							//var imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo="+response.attachmentNo);
							$("[name=noticeContent]").summernote('insertNode', imgNode.get(0));
						},
						error:function(){}
					});
					
				}
			}
        });
    });
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid">

         <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
             <i class="fa fa-bars"></i>
         </button>
         
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
             <ul class="nav navbar-nav ml-auto">
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/">홈</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/notice/write">글쓰기</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link active" href="${pageContext.request.contextPath}/notice/list">공지게시판</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>

<form action="write" method="post" autocomplete="off">
<%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>

<%-- 답글일 때는 정보가 한 개 더 전송되어야 한다(noticeParent) --%>
<c:if test="${noticeParent != null}">
<input type="hidden" name="noticeParent" value="${noticeParent}">
</c:if>

<div class="container">

	<!-- 제목 -->
	<div class="row center">
		<c:choose>
			<c:when test="${noticeParent == null}">
				<h2>새글 작성</h2>
			</c:when>
			<c:otherwise>
				<h2>답글 작성</h2>
			</c:otherwise>
		</c:choose>
	</div>
	
	 <div class="row p-3" >
	      <label for="draftTitle" class="form-label">제목</label>
	      <input type="text" id="draftTitle" name="noticeTitle" v-model="noticelVO.noticeDto.noticeTitle" class="form-control" v-on:input="noticeVO.noticeDto.noticeTitle = $event.target.value">
	    </div>
	    
	    <div class="row p-3">
	      <label for="draftContent" class="form-label">내용</label>
	      <textarea id="draftContent" name="noticeContent" required style="min-height: 300px;" v-model="noticeVO.noticeDto.noticeContent" class="form-control" v-on:input="noticeVO.noticeDto.noticeContent = $event.target.value"></textarea>
	    </div>
	<div class="row">
		<button type="submit" class="btn btn-info w-80 mt-3 noticeReply-insert-btn">등록</button>
	</div>
</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>