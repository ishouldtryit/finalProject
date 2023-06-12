<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:if test="${sessionScope.jobNo == 80}">
  <script type="text/javascript">
    function checkAll() {
      var allCheckbox = document.querySelector(".check-all");
      var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
      for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = allCheckbox.checked;
      }
    }

    function checkUnit() {
      var allCheckbox = document.querySelector(".check-all");
      var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]");
      var count = 0;
      for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
          count++;
        }
      }
      allCheckbox.checked = (checkboxes.length == count);
    }

    function formCheck() {
      var checkboxes = document.querySelectorAll("input[type=checkbox][name=boardNo]:checked");
      if (checkboxes.length == 0) return false;

      return confirm("정말 삭제하시겠습니까?");
    }
  </script>
</c:if>
<style>
  th {
    font-size: 13px;
  }

  td {
    font-size: 14px;
  }
</style>

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
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/join">사원 등록</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/list">사원 통합관리</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/waitingList">사원 퇴사관리</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/add">관리자 통합관리</a>
                 </li> 
                 <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/log/list">사원 접근로그</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/department/list">부서 관리</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/job/list">직위 관리</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>

<div class="container">

	<h3>사원 접근로그</h3>
	<br>
  <div class="row">
    <div class="col">
      <div class="d-flex justify-content-between mb-3">
        <form class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/log/list">
          <div class="row">
            <div class="col-4">
              <label class="form-label">사원명</label>
              <input type="text" name="empName" value="${vo.empName}" class="form-control w-75">
            </div>
            <div class="col-6">
              <label class="form-label">기간</label>
              <select name="searchLoginDays" class="form-select">
                <option value="0" ${vo.searchLoginDays == 0 ? 'selected' : ''}>선택하세요</option>
                <option value="7" ${vo.searchLoginDays == 7 ? 'selected' : ''}>최근 7일</option>
                <option value="30" ${vo.searchLoginDays == 30 ? 'selected' : ''}>최근 1개월</option>
                <option value="365" ${vo.searchLoginDays == 365 ? 'selected' : ''}>최근 1년</option>
              </select>
            </div>
          </div>
          <button type="submit" class="btn btn-primary mt-3">검색</button>
        </form>
      </div>

      <table class="table table-hover table-responsive">
        <thead>
          <tr>
            <th class="col-1">시간</th>
            <th class="col-5">이름</th>
            <th class="col-2">IP</th>
            <th class="col-2">브라우저</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${list}" var="loginRecordDto">
            <tr>
              <td class="align-middle">${loginRecordDto.logLogin}</td>
              <td class="align-middle">${loginRecordDto.empName}</td>
              <td class="align-middle">${loginRecordDto.logIp}</td>
              <td class="align-middle">${loginRecordDto.logBrowser}</td>
            </tr>
          </c:forEach>
        </tbody>
        <!-- 데이터 없음 알림 -->
				<c:if test="${empty list}">
				    <td colspan="15" class="text-center">검색 결과가 없습니다.</td>
				</c:if>
      </table>

      <div class="mt-4" style="display: flex; justify-content: center;">
        <ul class="pagination" style="width: 20%;">
          <li class="page-item ${vo.isFirst() ? 'disabled' : ''}">
            <a class="page-link" href="${pageContext.request.contextPath}/admin/log/list?${vo.logParameter}&page=${vo.getPrevPage()}">
              <i class="fa-solid fa-angles-left"></i>
            </a>
          </li>
          <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
            <li class="page-item">
            
              <a class="page-link ${vo.getPage() eq i ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/log/list?${vo.logParameter}&page=${i}">
                <span class="text-info">${i}</span>
              </a>
              
            </li>
          </c:forEach>
          <li class="page-item ${vo.isLast() ? 'disabled' : ''}">
            <a class="page-link" href="${pageContext.request.contextPath}/admin/log/list?${vo.logParameter}&page=${vo.getNextPage()}">
              <span class="text-info"><i class="fa-solid fa-angles-right"></i></span>
            </a>
          </li>
        </ul>
      </div>
      
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
