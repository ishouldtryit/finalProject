<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:if test="${sessionScope.empNo != null}"></c:if>
<script src="/static/js/board-like.js"></script>

<script>
	var empNo = "${sessionScope.empNo}";
	var boardWriter = "${boardDto.boardWriter}";
</script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
	<div class="reply-item">
		<div class="row mt-4">
			<div class="col-md-10 offset-md-1">
				<hr>
				<div class="d-flex align-items-center">
					<div class="profile-image employee-name">
						<!-- 프로필 사진이 들어갈 위치 -->
					</div>
					<h5 class="replyWriter text-dark">?</h5>
				</div>
				<h6 class="replyTime text-secondary">
					?분 전
				</h6>
				<pre class="replyContent mt-3" style="min-height:30px;">테스트 댓글 영역</pre>
			</div>
		</div>
	</div>
</script>

<div class="container-fluid">

	<!-- 제목 -->
	<div class="row mt-4">
		<div class="col-md-10 offset-md-1">
			<h1>${boardDto.boardTitle}[${boardDto.boardReply}]</h1>
			
			<div class="d-flex align-items-center">
			  <div class="profile-image employee-name">
			    <img width="50" height="50" src="<c:choose>
			      <c:when test="${boardDto.attachmentNo > 0}">
			        /attachment/download?attachmentNo=${boardDto.attachmentNo}
			      </c:when>
			      <c:otherwise>
			        https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
			      </c:otherwise>
			    </c:choose>" alt="" style="border-radius: 50%;">
			  </div>
			  <h2 class="text" style="margin-left: 10px;">작성자 : ${boardDto.empName}</h2>
			</div>
		</div>
	</div>
	
	<!-- 게시글 정보표시자리 -->
	<div class="row mt-4">
		<div class="col-md-10 offset-md-1">
			<div class="row">
				<div class="col-6 text-start">
					<i class="fa-solid fa-eye"></i> <span class="ms-1">${boardDto.boardRead}</span>
					<span class="ms-4 text-secondary"><fmt:formatDate value="${boardDto.boardTime}" 
						pattern="y년 M월 d일 H시 m분 s초"/></span>
				</div>
				<div class="col-6 text-end">
					<i class="ms-2 fa-regular fa-bookmark"></i>
					<i class="ms-2 fa-solid fa-share-nodes"></i>
					<i class="ms-2 fa-regular fa-share-from-square"></i>
				</div>
			</div>
			
			<hr>
		</div>
	</div>
</div>
	
	
	
	<!-- 게시글 내용 -->
	<div class="row mt-4" style="min-height:350px;">
		<div class="col-md-10 offset-md-1" value="${boardDto.boardContent}">
			${boardDto.boardContent}
		</div>
	</div>
	
	<!-- 버튼 영역 -->
	<div class="row mt-4">
		<div class="col-md-10 offset-md-1 text-end">
			<hr>
			
			<!-- 글쓰기와 다르게 답글쓰기는 계산을 위해 원본글의 번호를 전달해야함 -->
			<a href="/board/write" class="btn btn-primary">글쓰기</a>
			<a href="/board/write?boardParent=${boardDto.boardNo}" class="btn btn-success">답글쓰기</a>
			
			<!-- 
				수정과 삭제가 password 페이지를 거쳐서 갈 수 있도록 링크 수정
				- 주소는 /password/edit 또는 delete/번호 형태로 경로 변수 처리 
			-->
			<c:if test="${owner}">
			<a href="/board/edit?boardNo=${boardDto.boardNo}" class="btn btn-warning">수정</a>
			</c:if>
			<c:if test="${owner || admin}">
			<a href="/board/delete?boardNo=${boardDto.boardNo}" class="btn btn-danger">삭제</a>
			</c:if>
			<a href="/board/list" class="btn btn-dark">목록</a>
		</div>
	</div>
	
	<!-- 댓글 표시 영역 -->
	<div class="row mt-4">
		<div class="reply-list col-md-10 offset-md-1">
		</div>
	</div>
	<c:if test="${sessionScope.empNo != null}">	
	<div class="row mt-4">
		<div class="col-md-10 offset-md-1">
				<textarea name="replyContent" class="form-control" rows="4" style="resize: none;"></textarea>
				<button type="submit" class="btn btn-primary w-100 mt-3 reply-insert-btn">등록</button>
			</form>
		</div>
	</div>
</c:if>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>