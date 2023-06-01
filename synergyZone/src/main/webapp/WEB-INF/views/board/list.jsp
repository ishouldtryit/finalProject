<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<h1>자유게시판 목록</h1>
<hr>
<c:if test="${sessionScope.jobNo == 80}">
<script type="text/javascript">
	function checkAll(){
		var allCheckbox = document.querySelector(".check-all");
		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
		for(var i=0; i < checkboxes.length; i++) {
			checkboxes[i].checked = allCheckbox.checked;
		}
	}
	function checkUnit(){
		var allCheckbox = document.querySelector(".check-all");
		var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
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
							"input[type=checkbox][name=boardNo]:checked");	
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








<table class="table table-hover">
  <thead>
    <tr>
      <th class="col-1">글 번호</th>
      <th class="col-6">제목</th>
      <th class="col-2">작성자</th>
      <th class="col-2">작성일</th>
      <th class="col-1">조회수</th>
    </tr>
  </thead>
    <tbody>
    
	    <c:forEach items="${posts}" var="board">
  <tr>
    <td>${board.boardNo}</td>
    <td>
      <a href="detail?boardNo=${board.boardNo}">
        <!-- boardDepth가 1 이상일 경우만 답글 표식을 추가 -->
        <c:if test="${board.boardDepth > 0}">
          →
        </c:if>
        ${board.boardTitle}
      </a>
    </td>
    <td>
	      <div class="d-flex align-items-center">
			  <div class="profile-image employee-name">
			    <img width="35" height="35" src="<c:choose>
			      <c:when test="${board.attachmentNo > 0}">
			        /attachment/download?attachmentNo=${board.attachmentNo}
			      </c:when>
			      <c:otherwise>
		        https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
			      </c:otherwise>
			    </c:choose>" alt="" style="border-radius: 50%;">
			  </div>
			  <div style="margin-left: 10px;">${board.empName}</div>
			</div>
    </td>
    <td>${board.boardTime}</td>
    <td>${board.boardRead}</td>
  </tr>
</c:forEach>


    </tbody>
</table>

<br>
<div align="center">
    <a href="write" style="padding: 10px 20px; border: 1px solid #ccc;">새 글 쓰기</a>
</div>
<!-- 검색창 -->
    <div class="row center">
		<form action="list" method="get">
		
			<c:choose>
				<c:when test="${vo.column == 'board_content'}">
					<select name="column" class="form-input">
						<option value="board_title">제목</option>
						<option value="board_content" selected>내용</option>
						<option value="board_writer">작성자</option>
						<option value="board_head">말머리</option>
					</select>
				</c:when>
				<c:when test="${vo.column == 'board_writer'}">
					<select name="column" class="form-input">
						<option value="board_title">제목</option>
						<option value="board_content">내용</option>
						<option value="board_writer" selected>작성자</option>
						<option value="board_head">말머리</option>
					</select>
				</c:when>
				<c:when test="${vo.column == 'board_head'}">
					<select name="column" class="form-input">
						<option value="board_title">제목</option>
						<option value="board_content">내용</option>
						<option value="board_writer">작성자</option>
						<option value="board_head" selected>말머리</option>
					</select>
				</c:when>
				<c:otherwise>
					<select name="column" class="form-input">
						<option value="board_title" selected>제목</option>
						<option value="board_content">내용</option>
						<option value="board_writer">작성자</option>
						<option value="board_head">말머리</option>
					</select>
				</c:otherwise>
			</c:choose>
			
			
			<input class="form-input" type="search" name="keyword" placeholder="검색어" required value="${vo.keyword}">
			
			<button type="submit" class="form-btn neutral">검색</button>
		</form>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>