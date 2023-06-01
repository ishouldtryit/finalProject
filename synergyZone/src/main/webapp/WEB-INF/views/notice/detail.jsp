<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

<c:if test="${sessionScope.empNo != null}">

<script src="/static/js/notice-like.js"></script>
</c:if>

<script>
	var empNo = "${sessionScope.empNo}";
	var noticeWriter = "${noticeDto.noticeWriter}";
</script>
<script src="/static/js/notice-reply.js"></script>
<script type="text/template" id="notice-reply-template">
	<div class="notice-reply-item">
		<div class="noticeReplyWriter">?</div>
		<div class="noticeReplyContent">?</div>
		<div class="noticeReplyTime">?</div>
	</div>
</script>

<div class="container-800">
	<div class="row center">
		<h2>${noticeDto.noticeNo}번 게시글</h2>
	</div>
	
	<div class="row">
		<h3>${noticeDto.noticeTitle}</h3>
	</div>
	<hr>
	<div class="row">
		${noticeDto.noticeWriter}
	</div>
	<hr>
	<div class="row">
		<fmt:formatDate value="${noticeDto.noticeTime}" 
										pattern="y년 M월 d일 H시 m분 s초"/>
				조회 ${noticeDto.noticeRead}
	</div>
	<hr>
	<div class="row" style="min-height:200px;">
		${noticeDto.noticeContent}
	</div>
	<hr>
	<div class="row">
		좋아요 
		<span class="heart-count">${noticeDto.noticeLike}</span>
		
		<c:if test="${sessionScope.empNo != null}">
			<!-- 하트자리 -->
			<i class="fa-solid fa-heart"></i>
		</c:if>
		
		댓글 
		<span class="notice-reply-count">${noticeDto.noticeReply}</span>
	</div>
	<hr>
	<div class="row notice-reply-list">
		댓글목록 위치
	</div>
	<hr>
	
	<!-- 댓글 작성란 -->
	<div class="row">
		
		<div class="row">
			<c:choose>
				<c:when test="${sessionScope.empNo != null}">
					<textarea name="noticeReplyContent" class="form-input w-100"
							placeholder="댓글 내용을 작성하세요"></textarea>	
				</c:when>
				<c:otherwise>
					<textarea name="noticeReplyContent" class="form-input w-100"
							placeholder="로그인 후에 댓글 작성이 가능합니다" disabled></textarea>	
				</c:otherwise>
			</c:choose>
			
		</div>
		<c:if test="${sessionScope.empNo != null}">		
		<div class="row right">
			<button type="button" class="form-btn positive notice-reply-insert-btn">댓글 작성</button>
		</div>
		</c:if>

	</div>
	
	<hr>
	
	<div class="row right">
		<a class="form-btn positive" href="/notice/write">글쓰기</a>
		<a class="form-btn positive" href="/notice/write?noticeParent=${noticeDto.noticeNo}">답글쓰기</a>
		
		<c:if test="${owner}">
		<!-- 내가 작성한 글이라면 수정과 삭제 메뉴를 출력 -->
		<a class="form-btn negative" href="/notice/edit?noticeNo=${noticeDto.noticeNo}">수정</a>
		</c:if>
		
		<c:if test="${owner || admin}">
		<!-- 파라미터 방식일 경우의 링크 -->
		<a class="form-btn negative" href="/notice/delete?noticeNo=${noticeDto.noticeNo}">삭제</a>
		<!-- 경로 변수 방식일 경우의 링크 -->
	<%-- 				<a href="/notice/delete/${noticeDto.noticeNo}">삭제</a> --%>
		</c:if>
		<a class="form-btn neutral" href="/notice/list">목록보기</a>
	</div>
	
</div>

<%-- (+추가) 오늘 읽은 글(memory) 목록을 출력 --%>
<%-- <c:forEach var="number" items="${sessionScope.memory}"> --%>
<%-- 	${number}<br> --%>
<%-- </c:forEach> --%>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>






