<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 

		<div class="container-1200" style="margin-left: 15%;">
		<!-- 삭제 form -->
       <form action="delete" method="post" class="delete_form">
          <input type="hidden" name="empNo" class="delete_empNo">
          <input type="hidden" name="page" class="delete_page">
       </form>  
       
       <!-- 정렬 
	   	<div class="row ms-10">
			<a class="link" href="${pageContext.request.contextPath}/admin/member/list?">최신 입사일순</a>
			<a class="link" href="${pageContext.request.contextPath}/admin/member/list?sort=member_regdate asc">오래된순</a>
		</div>
		-->
       
		<!-- 검색창 -->
			<form class="d-flex" action="list" method="get">
			  <select name="column" class="form-input">
			    <option value="emp_name">이름</option>
			    <option value="emp_no">사원번호</option>
			    <option value="job_no">사원직급</option>
			  </select>
			  <input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${keyword}" style="width: 13%;">
			  <button class="btn btn-info my-2 my-sm-0" type="submit">Search</button>
			</form>
		
		
		
    	<!-- 사원 목록 테이블 -->
         <div class="row">
    		<div class="col" style="margin: 0 auto;">
                    <table class="table table-hover mt-2" style="width: 80%;">
                        <thead>
                            <tr>
                                <th>사원번호</th>
                                <th>이름</th>
                                <th>전화번호</th>
                                <th>이메일</th>
                                <th>주소</th>
                                <th>상세주소</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="employeeDto" items="${employees}">
                                <tr>
                                    <td>${employeeDto.empNo}</td>
                                   <td class="employee-name" data-empno="${employeeDto.empNo}" data-empname="${employeeDto.empName}" 
                                   data-empphone="${employeeDto.empPhone}" data-empemail="${employeeDto.empEmail}" 
                                   data-empaddress="${employeeDto.empAddress}" data-empdetailaddress="${employeeDto.empDetailAddress}">${employeeDto.empName}</td>
                                    <td>${employeeDto.empPhone}</td>
                                    <td>${employeeDto.empEmail}</td>
                                    <td>${employeeDto.empAddress}</td>
                                    <td>${employeeDto.empDetailAddress}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
              </div>
        
	<!-- 모달 창 -->
	<div class="modal fade" id="employeeModal" tabindex="-1" role="dialog" aria-labelledby="employeeModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="employeeModalLabel">사원 정보</h5>
	        <div class="flex">
		<div>img</div>
	      </div>
	      <div class="modal-body">
	        <p><strong>사원번호:</strong> <span id="employeeNo"></span></p>
	        <p><strong>이름:</strong> <span id="employeeName"></span></p>
	        <p><strong>전화번호:</strong> <span id="employeePhone"></span></p>
	        <p><strong>이메일:</strong> <span id="employeeEmail"></span></p>
	        <p><strong>주소:</strong> <span id="employeeAddress"></span></p>
	        <p><strong>상세주소:</strong> <span id="employeeDetailAddress"></span></p>
	        <!-- 다른 사원 정보 항목들을 추가할 수 있습니다 -->
	      </div>
	      </div>
	      <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>	      
            </div>
	    </div>
	  </div>
	</div>


		<!-- 페이징 영역 -->
			<div style="display: flex; justify-content: center;">
		  <ul class="pagination" style="width: 35%;">
		    <li class="page-item disabled">
		      <a class="page-link" href="${pageContext.request.contextPath}/address/list?page=${vo.prevPage}">&laquo;</a>
		    </li>
		    <c:forEach var="i" begin="${vo.startBlock}" end="${vo.finishBlock}">
		      <li class="page-item">
		        <a class="page-link" href="${pageContext.request.contextPath}/address/list?page=${i}&sort=${sort}">
		          <span class="text-info">${i}</span>
		        </a>
		      </li>
		    </c:forEach> 
		    <li class="page-item">
		      <a class="page-link" href="${pageContext.request.contextPath}/address/list?page=${vo.nextPage}">
		      <span class="text-info">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</div>
	</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	  
<!-- 스크립트 -->
<script>
$(document).ready(function() {
  // employeeDto.empName을 클릭했을 때
  $('.employee-name').click(function() {
    // 사원 정보 가져오기
    var employeeNo = $(this).data('empno');
    var employeeName = $(this).data('empname');
    var employeePhone = $(this).data('empphone');
    var employeeEmail = $(this).data('empemail');
    var employeeAddress = $(this).data('empaddress');
    var employeeDetailAddress = $(this).data('empdetailaddress');
    
    // 모달 창에 사원 정보 설정
    $('#employeeNo').text(employeeNo);
    $('#employeeName').text(employeeName);
    $('#employeePhone').text(employeePhone);
    $('#employeeEmail').text(employeeEmail);
    $('#employeeAddress').text(employeeAddress);
    $('#employeeDetailAddress').text(employeeDetailAddress);
    
    // 모달 창 표시
    $('#employeeModal').modal('show');
  });

  
});
</script>
    
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    