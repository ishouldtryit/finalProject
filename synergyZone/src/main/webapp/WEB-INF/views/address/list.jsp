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
			  <select name="column" class="form-input me-sm-2">
			    <option value="emp_name">이름</option>
			    <option value="emp_no">사원번호</option>
			    <option value="dept_name">부서</option>
			    <option value="job_name">직위</option>
			  </select>
			  
			  <input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${keyword}" style="width: 13%;">
			  <button class="btn btn-info my-2 my-sm-0" type="submit">검색</button>
			  <button type="submit" class="btn btn-success">쪽지 보내기</button>
			</form>

		
		
		
    	<!-- 사원 목록 테이블 -->
		<div class="row">
		  <div class="col" style="margin: 0 auto;">
		    <form id="employeeForm">
		      <table class="table table-hover mt-2" style="width: 80%;">
		        <thead>
		          <tr>
		            <th>선택</th>
		            <th>사원번호</th>
		            <th>이름</th>
		            <th>전화번호</th>
		            <th>이메일</th>
		            <th>주소</th>
		            <th>상세주소</th>
		            <th>부서</th>
		            <th>직위</th>
		          </tr>
		        </thead>
		        <tbody>
		          <c:forEach var="employeeDto" items="${employees}">
		            <tr>
		              <td class="align-middle">
		                <div class="p-2">
		                  <input type="checkbox" name="selectedEmployees" value="${employeeDto.empNo}">
		                </div>
		              </td>
		              <td class="align-middle">${employeeDto.empNo}</td>
		              <td class="align-middle employee-name" data-empno="${employeeDto.empNo}" data-empname="${employeeDto.empName}" 
		                data-empphone="${employeeDto.empPhone}" data-empemail="${employeeDto.empEmail}" 
		                data-empaddress="${employeeDto.empAddress}" data-empdetailaddress="${employeeDto.empDetailAddress}"
		                data-attachmentno="${employeeDto.attachmentNo}">
		                ${employeeDto.empName}
		              </td>
		              <td class="align-middle">${employeeDto.empPhone}</td>
		              <td class="align-middle">${employeeDto.empEmail}</td>
		              <td class="align-middle">${employeeDto.empAddress}</td>
		              <td class="align-middle">${employeeDto.empDetailAddress}</td>
		              <td class="align-middle">
		                <c:forEach var="departmentDto" items="${departments}">
		                  <c:if test="${departmentDto.deptNo == employeeDto.deptNo}">
		                    ${departmentDto.deptName}
		                  </c:if>
		                </c:forEach>
		              </td>
		              <td class="align-middle">
		                <c:forEach var="jobDto" items="${jobs}">
		                  <c:if test="${jobDto.jobNo == employeeDto.jobNo}">
		                    ${jobDto.jobName}
		                  </c:if>
		                </c:forEach>
		              </td>
		            </tr>
		          </c:forEach>
		        </tbody>
		      </table>
		    </form>
		  </div>
		</div>

		<!-- 첫 번째 모달 창 -->
	 	<div class="modal fade" id="employeeModal" tabindex="-1" role="dialog" aria-labelledby="employeeModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="employeeModalLabel"></h5>
		     <div class="profile-image">
			    <img id="profileImage" width="200" height="200" src="/attachment/download?attachmentNo=${employeeDto.attachmentNo}" alt="프로필 이미지">
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

		<!-- 두 번째 모달 창 -->
		<div class="modal fade" id="employeeInfoModal" tabindex="-1" role="dialog" aria-labelledby="employeeInfoModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="employeeInfoModalLabel"></h5>
		      </div>
		      <div class="modal-body">
		        <!-- 사원 상세 정보를 추가하십시오 -->
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
      <a class="page-link" href="${pageContext.request.contextPath}/address/list?page=${vo.getPrevPage()}">&laquo;</a>
    </li>
    <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
      <li class="page-item">
        <a class="page-link" href="${pageContext.request.contextPath}/address/list?page=${i}&sort=${vo.sort}">
          <span class="text-info">${i}</span>
        </a>
      </li>
    </c:forEach> 
    <li class="page-item">
      <a class="page-link" href="${pageContext.request.contextPath}/address/list?page=${vo.getNextPage()}">
        <span class="text-info">&raquo;</span>
      </a>
    </li>
  </ul>
</div>

	</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
	  
<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    // 첫 번째 모달 창 열기
    $('.employee-name').click(function() {
      var employeeNo = $(this).data('empno');
      var employeeName = $(this).data('empname');
      var employeePhone = $(this).data('empphone');
      var employeeEmail = $(this).data('empemail');
      var employeeAddress = $(this).data('empaddress');
      var employeeDetailAddress = $(this).data('empdetailaddress');
      var attachmentNo = $(this).data('attachmentno');

      $('#employeeNo').text(employeeNo);
      $('#employeeName').text(employeeName);
      $('#employeePhone').text(employeePhone);
      $('#employeeEmail').text(employeeEmail);
      $('#employeeAddress').text(employeeAddress);
      $('#employeeDetailAddress').text(employeeDetailAddress);
      $("#profileImage").attr("src", "/attachment/download?attachmentNo="+attachmentNo);

      $('#employeeModal').modal('show');
    });

    // 두 번째 모달 창 열기
    $('#employeeName').click(function() {
      var employeeName = $(this).text();
      // 두 번째 모달 창 내용 설정
      $('#employeeInfoModalLabel').text(employeeName);
      // 여기에 사원 상세 정보를 설정하는 코드를 추가하십시오
      // 예를 들어, AJAX 요청을 통해 서버에서 사원의 상세 정보를 가져와서 모달 창에 표시할 수 있습니다.

      $('#employeeInfoModal').modal('show');
    });
  });
</script>

<script>
  $(document).ready(function() {
    // 쪽지 보내기 버튼 클릭 시 실행되는 함수
    $('.btn.btn-success').click(function(e) {
      e.preventDefault(); // 기본 동작(폼 제출) 막기

      // 체크된 사원들을 담을 배열
      var selectedEmployees = [];

      // 체크된 사원들의 값을 가져와 배열에 추가
      $('input[name="selectedEmployees"]:checked').each(function() {
        selectedEmployees.push($(this).val());
      });

      // 선택된 사원들의 정보를 받는 사람 입력 필드에 설정
      $('#message-recipient-input').val(selectedEmployees.join(', '));

      // 페이지 이동을 위해 폼 제출
      $('#employeeForm').submit();
    });
  });
</script>


    
  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    