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

<div class="container">
  <div class="row">
    <div class="col">
      <div class="d-flex justify-content-between mb-2">
        <form class="d-flex" method="get" action="list">
          <div class="row">
            <div class="col col-6">
              <label class="form-label">사원명</label>
              <input type="text" name="empName" value="${vo.empName}" class="form-control">
            </div>
            <div class="col col-6">
              <label class="form-label">기간</label>
              <select name="searchLoginDays" class="form-select">
                <option value="0" ${vo.searchLoginDays == 0 ? 'selected' : ''}>선택하세요</option>
                <option value="7" ${vo.searchLoginDays == 7 ? 'selected' : ''}>최근 7일</option>
                <option value="30" ${vo.searchLoginDays == 30 ? 'selected' : ''}>최근 1개월</option>
                <option value="365" ${vo.searchLoginDays == 365 ? 'selected' : ''}>최근 1년</option>
              </select>
            </div>
          </div>
          <div class="col d-flex align-items-end justift-content-end mr-3">
          	<button type="submit" class="btn btn-outline-info mt-3">검색</button>
          </div>
        </form>
      </div>

      <table class="table table-sm table-responsive">
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
