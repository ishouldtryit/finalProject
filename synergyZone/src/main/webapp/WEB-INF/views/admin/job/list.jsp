<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
a{
 color:black;
}
a:hover{
   color:red;
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
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/log/list">사원 접근로그</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/department/list">부서 관리</a>
                 </li>
                 <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/job/list">직위 관리</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>

<div class="container">

<div class="container-800" style="margin-left: 5%;">

   <h3>직위 통합관리</h3>
   <br>
      
   <div class="d-flex justify-content-end">
      <button class="btn btn-outline-info mt-2 align-content-center">
         <a href="${pageContext.request.contextPath}/admin/job/register">
         
         추가
         </a>
      </button>
   </div>
       <!-- 사원 목록 테이블 -->

          <form id="jobForm">
            <table class="table table-hover mt-2 text-center">
              <thead>
                <tr>
                  <th>코드번호</th>
                  <th>명칭</th>
                    <th>관리</th>
                </tr>
              </thead>
              <tbody>
                    <c:forEach var="jobDto" items="${jobs}">
                  <tr>
                    <td class="align-middle">${jobDto.jobNo}</td>
                    <td class="align-middle">${jobDto.jobName}</td>
                     <td class="align-middle"><a href="${pageContext.request.contextPath}/admin/job/delete?jobNo=${jobDto.jobNo}">삭제</a></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </form>
      
      <!-- 페이징 영역 -->
      <div style="display: flex; justify-content: center;">
        <ul class="pagination" style="width: 20%;">
          <li class="page-item ${vo.isFirst() ? 'disabled' : ''}">
            <a class="page-link" href="${vo.isFirst() ? '#' : pageContext.request.contextPath}/admin/job/list?page=${vo.getPrevPage()}&sort=${vo.getSort()}${vo.getQueryString()}">&laquo;</a>
          </li>
          <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
            <li class="page-item">
              <a class="page-link ${vo.getPage() eq i ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/job/list?page=${i}&sort=${vo.getSort()}${vo.getQueryString()}">
                <span class="text-info">${i}</span>
              </a>
            </li>
          </c:forEach> 
          <li class="page-item ${vo.isLast() ? 'disabled' : ''}">
            <a class="page-link" href="${vo.isLast() ? '#' : pageContext.request.contextPath}/admin/job/list?page=${vo.getNextPage()}&sort=${vo.getSort()}${vo.getQueryString()}">
              <span class="text-info">&raquo;</span>
            </a>
          </li>
        </ul>
      </div>

</div>
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
     
<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>