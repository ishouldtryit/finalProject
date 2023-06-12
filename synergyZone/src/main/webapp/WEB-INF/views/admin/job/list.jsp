<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .btn-light a {
        color: gray;
    }
</style>

<div class="container-fulid" style="margin-left: 5%;">
		<button class="btn btn-light"><a href="/admin/job/register">추가</a></button>
		
    	<!-- 사원 목록 테이블 -->
		<div class="row">
		  <div class="col" style="margin: 0 auto;">
		    <form id="jobForm">
		      <table class="table table-hover mt-2" style="width: 90%;">
		        <thead>
		          <tr>
		            <th>명칭</th>
		            <th>코드번호</th>
                    <th>관리</th>
		          </tr>
		        </thead>
		        <tbody>
                    <c:forEach var="jobDto" items="${jobs}">
		            <tr>
		              <td class="align-middle">${jobDto.jobNo}</td>
		              <td class="align-middle">${jobDto.jobName}</td>
	                  <td class="align-middle"><a href="/admin/job/delete?jobNo=${jobDto.jobNo}">삭제</a></td>
		            </tr>
		          </c:forEach>
		        </tbody>
		      </table>
		    </form>
		  </div>
		</div>

</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	  
<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
