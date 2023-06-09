<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .employee-name {
    color: dodgerblue;
  }
  
  
</style>

<div class="container-800" style="margin-left: 5%;">

    <form method="get" class="mb-3">
        <div class="row">
            <div class="col-4">
                <label class="form-label">사원명</label>
                <input type="text" name="empName" value="${vo.empName}" class="form-control w-75">
            </div>
            <div class="col-6">
                <label class="form-label">기간</label>
                <select name="searchLoginDays" class="form-select">
                    <option value="">선택하세요</option>
                    <option value="7" ${vo.searchLoginDays == 7 ? 'selected' : ''}>최근 7일</option>
                    <option value="30" ${vo.searchLoginDays == 30 ? 'selected' : ''}>최근 1개월</option>
                    <option value="365" ${vo.searchLoginDays == 365 ? 'selected' : ''}>최근 1년</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn btn-primary mt-3 ">검색</button>
    </form>
		

		
    	<!-- 사원 목록 테이블 -->
		<div class="row">
		  <div class="col" style="margin: 0 auto;">
		    <form id="logForm">
            <c:choose>
            <c:when test="${logList != null}">
		      <table class="table table-hover mt-2" style="width: 90%;">
		        <thead>
		          <tr>
		            <th>시간</th>
		            <th>이름</th>
                    <th>IP</th>
                    <th>브라우저</th>
		          </tr>
		        </thead>
		        <tbody>
                    <c:forEach var="loginRecordDto" items="${logList}">
		            <tr>
		              <td class="align-middle">${loginRecordDto.logLogin}</td>
		              <td class="align-middle">${loginRecordDto.empName}</td>
	                  <td class="align-middle">${loginRecordDto.logIp}</td>
                      <td class="align-middle">${loginRecordDto.logBrowser}</td>
		            </tr>
		          </c:forEach>
		        </tbody>
		      </table>
            </c:when>
            <c:otherwise>
                <div>
                    결과가 없습니다.
                </div>
            </c:otherwise>
            </c:choose>
		    </form>
		  </div>
		</div>
		
		
		
		
		
		
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	  
<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    