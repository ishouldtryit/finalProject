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
							var imgNode = $("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo);
							//var imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo="+response.attachmentNo);
							$("[name=boardContent]").summernote('insertNode', imgNode.get(0));
						},
						error:function(){}
					});
					
				}
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

<div class="container-800">

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
	
	<div class="row">
		<label>제목<i class="fa-solid fa-asterisk"></i></label>
		<c:choose>
			<c:when test="${boardParent == null}">
				<input type="text" name="boardTitle" required class="form-input w-100">
			</c:when>
			<c:otherwise>
				<input type="text" name="boardTitle" required value="RE: " class="form-input w-100">
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="row">
		<label>내용<i class="fa-solid fa-asterisk"></i></label>
		<textarea name="boardContent" required class="form-input w-100" style="min-height: 300px;"></textarea>
	</div>
	
	<div class="row">
		<button type="submit" class="form-btn positive w-100">등록</button>
	</div>
</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>