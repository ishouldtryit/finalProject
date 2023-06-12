<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<c:if test="${sessionScope.empNo != null}"></c:if>
<script src="/static/js/board-like.js"></script>

<script>
   var empNo = "${sessionScope.empNo}";
   var boardWriter = "${boardDto.boardWriter}";
</script>
<script src="/static/js/reply.js"></script>
<script type="text/template" id="reply-template">
   <div class="reply-item">
      <div class="row mt-1">
         <div class="col-md-10">
            <div class="d-flex align-items-center">
               <div class="profile-image employee-name">
                  <!-- 프로필 사진이 들어갈 위치 -->
               </div>
               <h6 class="replyWriter text-dark">?</h6>
               &nbsp;
               <h6 class="replyTime text-secondary">
               ?분 전
            </h6>
            </div>
            
            <pre class="replyContent mt-3" style="min-height:30px;">테스트 댓글 영역</pre>
         </div>
      </div>
   </div>
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
                     <a class="nav-link" href="${pageContext.request.contextPath}/board/write">글쓰기</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link active" href="${pageContext.request.contextPath}/board/list">자유게시판</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>

   <!-- 버튼 영역 -->
   <div class="row" style="box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.15);">
      <div class="col-md-10 mb-4 offset-md-1 text-start">
         
         <!-- 글쓰기와 다르게 답글쓰기는 계산을 위해 원본글의 번호를 전달해야함 -->
         <a href="/board/write" class="btn btn-light"><i class="fa-solid fa-pen" style="color: #8f8f8f;"></i>&nbsp;글쓰기</a>
         <a href="/board/write?boardParent=${boardDto.boardNo}" class="btn btn-light"><i class="fa-solid fa-reply fa-rotate-180" style="color: #8f8f8f;"></i>&nbsp;답글쓰기</a>
         
         <!-- 
            수정과 삭제가 password 페이지를 거쳐서 갈 수 있도록 링크 수정
            - 주소는 /password/edit 또는 delete/번호 형태로 경로 변수 처리 
         -->
         
         <c:if test="${owner}">
         <a href="/board/edit?boardNo=${boardDto.boardNo}" class="btn btn-light"><i class="fa-regular fa-pen-to-square" style="color: #8f8f8f;"></i>&nbsp;수정</a>
         </c:if>
         <c:if test="${owner || admin}">
		  <a href="/board/delete?boardNo=${boardDto.boardNo}" class="btn btn-light" onclick="return confirm('정말 삭제하시겠습니까?')">
		    <i class="fa-solid fa-trash-can" style="color: #8f8f8f;"></i>&nbsp;삭제
		  </a>
		 </c:if>
         
         <a href="/board/list" class="btn btn-light"><i class="fa-solid fa-bars" style="color: #8f8f8f;"></i>&nbsp;목록</a>
      </div>
   </div>

<div class="border container-fluid">

   <!-- 제목 -->
   <div class="row">
   <div class="row mt-4">
      <div class="col-md-10 offset-md-1">
         <h3>${boardDto.boardTitle} [${boardDto.boardReply}]
                  <!-- 하트자리 -->
                  <i class="fa-solid fa-heart fa-xl float-right mt-3 ml-3" style="color: #f70808;"></i>
               <span class="heart-count float-right">${boardDto.boardLike}</span>
         </h3>
         
         <div class="d-flex align-items-center">
           <div class="profile-image employee-name">
             <img width="24" height="24" src="<c:choose>
               <c:when test="${boardDto.attachmentNo > 0}">
                 /attachment/download?attachmentNo=${boardDto.attachmentNo}
               </c:when>
               <c:otherwise>
                 https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
               </c:otherwise>
             </c:choose>" alt="" style="border-radius: 50%;">
           </div>
           <h6 class="text" style="margin-left: 10px; margin-top:10px; font-weight: nomal"> ${boardDto.empName} ${boardDto.jobName}
           <span class="ms-2 text-secondary" style="font-weight:lighter; font-size:14px;"><fmt:formatDate value="${boardDto.boardTime}" 
                  pattern="y년 M월 d일 H시 m분 "/></span></h6>
         </div>
      </div>
   </div>
</div>
   
   
   
   <!-- 게시글 내용 -->
   <div class="row mt-4" style="min-height:350px;">
      <div class="col-md-10 offset-md-1" value="${boardDto.boardContent}">
         ${boardDto.boardContent}
      </div>
   </div>
      <!-- 게시글 정보표시자리 -->
   <div class="row mt-4 mb-3">
      <div class="col-md-10 offset-md-1">
         <div class="row">
            <div class="col-1 text-start">
               <i class="fa-regular fa-comment"></i> <span class="me-2">${boardDto.boardReply}</span>
               <i class="fa-solid fa-eye"></i> <span>${boardDto.boardRead}</span>
            </div>
         </div>   
      </div>
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
            <button type="submit" class="btn btn-info w-100 mt-3 reply-insert-btn">등록</button>
         </form>
      </div>
   </div>
</c:if>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>