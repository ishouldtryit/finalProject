<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

<c:if test="${sessionScope.memberId != null}">
<link rel="stylesheet" type="text/css" href="/static/css/board-like.css">
<script src="/static/js/board-like.js"></script>
</c:if>

<link rel="stylesheet" type="text/css" href="/static/css/reply.css">
<script>
	var memberId = "${sessionScope.memberId}";
	var boardWriter = "${boardDto.boardWriter}";
</script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
	<div class="reply-item">
		<div class="replyWriter">?</div>
		<div class="replyContent">?</div>
		<div class="replyTime">?</div>
	</div>
</script>

<div class="container-800">
	<div class="row center">
		<h2>${boardDto.boardNo}번 게시글</h2>
	</div>
	
	<div class="row">
		<h3 style="color:gray;">${boardDto.boardHead}</h3>
	</div>
	
	<div class="row">
		<h3>${boardDto.boardTitle}</h3>
	</div>
	<hr>
	<div class="row">
		${boardDto.boardWriter}
	</div>
	<hr>
	<div class="row">
		<fmt:formatDate value="${boardDto.boardTime}" 
										pattern="y년 M월 d일 H시 m분 s초"/>
				조회 ${boardDto.boardRead}
	</div>
	<hr>
	<div class="row" style="min-height:200px;">
		${boardDto.boardContent}
	</div>
	<hr>
	<div class="row">
		좋아요 
		<span class="heart-count">${boardDto.boardLike}</span>
		
		<c:if test="${sessionScope.memberId != null}">
		<!-- 하트자리 -->
		<i class="fa-heart"></i>
		</c:if>
		
		댓글 
		<span class="reply-count">${boardDto.boardReply}</span>
	</div>
	<hr>
	<div class="row reply-list">
		댓글목록 위치
	</div>
	<hr>
	
	<!-- 댓글 작성란 -->
	<div class="row">
		
		<div class="row">
			<c:choose>
				<c:when test="${sessionScope.memberId != null}">
					<textarea name="replyContent" class="form-input w-100"
							placeholder="댓글 내용을 작성하세요"></textarea>	
				</c:when>
				<c:otherwise>
					<textarea name="replyContent" class="form-input w-100"
							placeholder="로그인 후에 댓글 작성이 가능합니다" disabled></textarea>	
				</c:otherwise>
			</c:choose>
			
		</div>
		<c:if test="${sessionScope.memberId != null}">		
		<div class="row right">
			<button type="button" class="form-btn positive reply-insert-btn">댓글 작성</button>
		</div>
		</c:if>

	</div>
	
	<hr>
	
	<div class="row right">
		<a class="form-btn positive" href="/board/write">글쓰기</a>
		<a class="form-btn positive" href="/board/write?boardParent=${boardDto.boardNo}">답글쓰기</a>
		
		<c:if test="${owner}">
		<!-- 내가 작성한 글이라면 수정과 삭제 메뉴를 출력 -->
		<a class="form-btn negative" href="/board/edit?boardNo=${boardDto.boardNo}">수정</a>
		</c:if>
		
		<c:if test="${owner || admin}">
		<!-- 파라미터 방식일 경우의 링크 -->
		<a class="form-btn negative" href="/board/delete?boardNo=${boardDto.boardNo}">삭제</a>
		<!-- 경로 변수 방식일 경우의 링크 -->
	<%-- 				<a href="/board/delete/${boardDto.boardNo}">삭제</a> --%>
		</c:if>
		<a class="form-btn neutral" href="/board/list">목록보기</a>
	</div>
	
</div>

<%-- (+추가) 오늘 읽은 글(memory) 목록을 출력 --%>
<%-- <c:forEach var="number" items="${sessionScope.memory}"> --%>
<%-- 	${number}<br> --%>
<%-- </c:forEach> --%>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






