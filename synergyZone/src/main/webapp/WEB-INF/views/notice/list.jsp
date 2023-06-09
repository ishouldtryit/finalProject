<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:if test="${sessionScope.jobNo == 80}">
<script type="text/javascript">
	function checkAll(){
		var allCheckbox = document.querySelector(".check-all");
		var checkboxes = document.querySelectorAll("input[type=checkbox][name=noticeNo]");
		for(var i=0; i < checkboxes.length; i++) {
			checkboxes[i].checked = allCheckbox.checked;
		}
	}
	function checkUnit(){
		var allCheckbox = document.querySelector(".check-all");
		var checkboxes = document.querySelectorAll("input[type=checkbox][name=noticeNo]");
		var count = 0;
		for(var i=0; i < checkboxes.length; i++) {
			if(checkboxes[i].checked) {
				count++;
			}
		}
		allCheckbox.checked = (checkboxes.length == count);
	}
	
	function formCheck() {
		var checkboxes = document.querySelectorAll(
							"input[type=checkbox][name=noticeNo]:checked");	
		if(checkboxes.length == 0) return false;
		
		return confirm("정말 삭제하시겠습니까?");
	}
</script>
</c:if>
<style>

	th {
		font-size:13px;
		}
	
	td {
		font-size:14px;
		}
</style>

<div class="container">
    <div class="row mb-3 d-flex">
 <form class="d-flex" action="list" method="get">
    <c:choose>
      <c:when test="${vo.column == 'notice_content'}">
        <select name="column" class="form-input me-sm-2">
          <option value="notice_title">제목</option>
          <option value="notice_content" selected>내용</option>
          <option value="emp_name">작성자</option>
        </select>
      </c:when>
      <c:when test="${vo.column == 'notice_writer'}">
        <select name="column" class="form-input me-sm-2">
          <option value="notice_title">제목</option>
          <option value="notice_content">내용</option>
          <option value="emp_name" selected>작성자</option>
        </select>
      </c:when>
      <c:when test="${vo.column == 'notice_head'}">
        <select name="column" class="form-input me-sm-2">
          <option value="notice_title">제목</option>
          <option value="notice_content">내용</option>
          <option value="emp_name">작성자</option>
        </select>
      </c:when>
      <c:otherwise>
      	<select name="column" class="form-input me-sm-2">
		  <option value="notice_title" ${(Empty == vo.column || 'notice_title' == vo.column) ? 'selected' : ''}>제목</option>
		  <option value="notice_content" ${'notice_content' == vo.column ? 'selected' : ''}>내용</option>
		  <option value="emp_name" ${'emp_name' == vo.column ? 'selected' : ''}>작성자</option>
		</select>
      </c:otherwise>
    </c:choose>
<input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${vo.keyword}" style="width: 13%;">
		  <button class="btn btn-info my-2 my-sm-0" type="submit">Search</button>
       <div class="col-md-6 d-flex">
    <a href="/notice/write" class="btn btn-info">글쓰기</a>
    </form>
  	</div>
</div>
<div class="row mt-4">
<table class="table table-hover">
  <thead>
    <tr>
      <th class="col-1">글 번호</th>
      <th class="col-5">제목</th>
      <th class="col-2">작성자</th>
      <th class="col-2">작성일</th>
      <th class="col-1">조회수</th>
      <th class="col-1">좋아요</th>
    </tr>
  </thead>
    <tbody>
    
	    <c:forEach items="${posts}" var="notice">
  <tr>
    <td>${notice.noticeNo}</td>
    <td>
      <a style="color: inherit;" href="detail?noticeNo=${notice.noticeNo}">
        <!-- noticeDepth가 1 이상일 경우만 답글 표식을 추가 -->
        <c:if test="${notice.noticeDepth > 0}">
          <i class="fa-solid fa-reply fa-flip-both"></i>
        </c:if>
        ${notice.noticeTitle}
      </a>
    </td>
    <td>
	      <div class="d-flex align-items-center">
			  <div class="profile-image employee-name">
			    <img width="25" height="25" src="<c:choose>
			      <c:when test="${notice.attachmentNo > 0}">
			        /attachment/download?attachmentNo=${notice.attachmentNo}
			      </c:when>
			      <c:otherwise>
		        https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
			      </c:otherwise>
			    </c:choose>" alt="" style="border-radius: 50%;">
			  </div>
			  <div style="margin-left: 10px;">${notice.empName}</div>
			</div>
    </td>
    <td>${notice.noticeTime}</td>
    <td>${notice.noticeRead}</td>
    <td>${notice.noticeLike}</td>
	
  </tr>
</c:forEach>


    </tbody>
</table> 
</div>

<br>
    
    	<!-- 페이징 영역 -->
		<div class="mt-4" style="display: flex; justify-content: center;">
		  <ul class="pagination" style="width: 20%;">
		    <li class="page-item ${vo.isFirst() ? 'disabled' : ''}">
		      <a class="page-link" href="${vo.isFirst() ? '#' : pageContext.request.contextPath}/notice/list?page=${vo.getPrevPage()}"><i class="fa-solid fa-angles-left"></i></a>
		    </li>
		    <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
		      <li class="page-item">
		        <a class="page-link ${vo.getPage() eq i ? 'active' : ''}" href="${pageContext.request.contextPath}/notice/list?page=${i}&sort=${vo.getSort()}">
		          <span class="text-info">${i}</span>
		        </a>
		      </li>
		    </c:forEach> 
		    <li class="page-item ${vo.isLast() ? 'disabled' : ''}">
		      <a class="page-link" href="${vo.isLast() ? '#' : pageContext.request.contextPath}/notice/list?page=${vo.getNextPage()}">
		        <span class="text-info"><i class="fa-solid fa-angles-right"></i></span>
		      </a>
		    </li>
		  </ul>
		</div>
	</div>
</div>

  
