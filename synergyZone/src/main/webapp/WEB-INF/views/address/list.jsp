<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .employee-name {
    color: dodgerblue;
  }
   /* 체크박스 열(TH)의 높이 설정 */
    th:first-child {
        vertical-align: middle;
    }

    /* 나머지 열(TH)의 높이 설정 */
    th:not(:first-child) {
        height: 35px; 
        line-height: 35px; 
    }
    .button-container button {
        margin-right: 10px; 
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
                 <li class="nav-item" >
                     <a class="nav-link" href="${pageContext.request.contextPath}/address/list">주소록</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/bookmark/mylist">나만의 주소록</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>
<div class="container-800" style="margin-left: 5%;">
		<!-- 검색창 -->

		<form class="d-flex" action="list" method="get">
		  <select name="column" class="form-input me-sm-2">
		    <option value="emp_name" ${column eq 'emp_name' ? 'selected' : ''}>이름</option>
		    <option value="emp_no" ${column eq 'emp_no' ? 'selected' : ''}>사원번호</option>
		    <option value="dept_name" ${column eq 'dept_name' ? 'selected' : ''}>부서</option>
		    <option value="job_name" ${column eq 'job_name' ? 'selected' : ''}>직위</option>
		  </select>
		  
		  <input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${param.keyword}" style="width: 13%;">
		  <button class="btn btn-info my-2 my-sm-0" type="submit">Search</button>
		  
		  <!-- My list에 추가 버튼 -->		  
		  <button class="btn btn-success my-2 my-sm-0" type="button" onclick="addToMyList()">My list에 추가</button>
		  	
		  <!-- 선택된 사원 쪽지 보내기 -->		  
		  <button type="button" id="sendMessageBtn" class="btn btn-primary">쪽지보내기</button>
		  
		</form>
		
		<!-- 데이터 없음 알림 -->
		<c:if test="${empty employees}">
		    <div class="alert alert-warning mt-3" role="alert">
	        알맞은 검색 결과가 없습니다.
		    </div>
		</c:if>
		
    	<!-- 사원 목록 테이블 -->
	<div class="row">
	  <div class="col" style="margin: 0 auto;">
	    <form id="employeeForm">
	      <table class="table table-hover mt-2" style="width: 90%;">
	        <thead>
	          <tr>
	            <th>
	            <div class="p-2">
                <input type="checkbox" id="selectAllBtn" class="btn btn-primary my-2 my-sm-0">
              </div>
              </th>
	            <th>프로필</th>
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
	              <td class="align-middle">
	                <div class="profile-image employee-name" data-empno="${employeeDto.empNo}" 
		                    data-empname="${employeeDto.empName}" data-empphone="${employeeDto.empPhone}" 
		                    data-empemail="${employeeDto.empEmail}" data-empaddress="${employeeDto.empAddress}" 
		                    data-empdetailaddress="${employeeDto.empDetailAddress}" data-attachmentno="${employeeDto.attachmentNo}">
	                  <img width="50" height="50" src="<c:choose>
	                    <c:when test="${employeeDto.attachmentNo > 0}">
	                      ${pageContext.request.contextPath}/attachment/download?attachmentNo=${employeeDto.attachmentNo}
	                    </c:when>
	                    <c:otherwise>
	                      https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
	                    </c:otherwise>
		                      </c:choose>" alt="" style="border-radius: 50%;">
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
			    <img id="profileImage" width="200" height="300" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=" alt="프로필 이미지">
			</div>
			
			  <div class="modal-body">
		        <p><strong>사원번호 :</strong> <span id="employeeNo"></span></p>
		        <p><strong>이름 :</strong> <span id="employeeName"></span></p>
		        <p><strong>전화번호 :</strong> <span id="employeePhone"></span></p>
		        <p><strong>이메일 :</strong> <span id="employeeEmail"></span></p>
		        <p><strong>주소 :</strong> <span id="employeeAddress"></span></p>
		        <p><strong>상세주소 :</strong> <span id="employeeDetailAddress"></span></p>
		        <p><strong>부서 :</strong> <span id="employeeDepartment"></span></p> <!-- 부서 정보를 표시할 곳 -->
		        <p><strong>직위 :</strong> <span id="employeeJob"></span></p> <!-- 직위 정보를 표시할 곳 -->
		        <!-- 정보 추가 가능 -->
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
		        <!-- 사원 상세 정보 추가칸 -->
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>

	
		<!-- 페이징 영역 -->
		<div style="display: flex; justify-content: center;">
		  <ul class="pagination" style="width: 20%;">
		    <li class="page-item ${vo.isFirst() ? 'disabled' : ''}">
		      <a class="page-link" href="${vo.isFirst() ? '#' : pageContext.request.contextPath}/address/list?page=${vo.getPrevPage()}&sort=${vo.getSort()}${vo.getQueryString()}">&laquo;</a>
		    </li>
		    <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
		      <li class="page-item">
		        <a class="page-link ${vo.getPage() eq i ? 'active' : ''}" href="${pageContext.request.contextPath}/address/list?page=${i}&sort=${vo.getSort()}${vo.getQueryString()}">
		          <span class="text-info">${i}</span>
		        </a>
		      </li>
		    </c:forEach> 
		    <li class="page-item ${vo.isLast() ? 'disabled' : ''}">
		      <a class="page-link" href="${vo.isLast() ? '#' : pageContext.request.contextPath}/address/list?page=${vo.getNextPage()}&sort=${vo.getSort()}${vo.getQueryString()}">
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
      var departmentName = $(this).closest('tr').find('td:eq(8)').text(); // 부서 정보 가져오기
      var jobName = $(this).closest('tr').find('td:eq(9)').text(); // 직위 정보 가져오기

      $('#employeeNo').text(employeeNo);
      $('#employeeName').text(employeeName);
      $('#employeePhone').text(employeePhone);
      $('#employeeEmail').text(employeeEmail);
      $('#employeeAddress').text(employeeAddress);
      $('#employeeDetailAddress').text(employeeDetailAddress);
      $('#employeeDepartment').text(departmentName); // 부서 정보 설정
      $('#employeeJob').text(jobName); // 직위 정보 설정

      // 더미이미지 삽입
      if (attachmentNo > 0) {
        $("#profileImage").attr("src",  contextPath+"/attachment/download?attachmentNo=" + attachmentNo);
      } else {
        $("#profileImage").attr("src", "https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg");
      }

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
  // 페이지 로드 시 선택된 옵션 설정
  var selectedColumn = "${column}"; // 서버에서 전달된 선택한 옵션 값

  $(document).ready(function() {
    // 선택된 옵션 설정
    $('select[name="column"] option[value="' + selectedColumn + '"]').prop('selected', true);
  });
</script>
    
<script>
function addToMyList() {
  var selectedEmployees = [];
  var checkboxes = document.getElementsByName('selectedEmployees');
  
  for (var i = 0; i < checkboxes.length; i++) {
    if (checkboxes[i].checked) {
      selectedEmployees.push(checkboxes[i].value);
    }
  }
  
  if (selectedEmployees.length > 0) {
    var confirmation = confirm("선택한 직원을 나만의 주소록에 추가하시겠습니까?");
    if (confirmation) {
      $.ajax({
        type: "POST",
        url: contextPath+"/bookmark/addBookmark",
        data: JSON.stringify({bookmarkNo: selectedEmployees}),
        contentType: "application/json",
        success: function(response) {
          alert("나만의 주소록에 추가되었습니다!");
        },
        error: function(xhr, status, error) {
        }
      });
    }
  } else {
    console.log("직원이 선택되지 않았습니다.");
  }
}
</script>

<script>
$(document).ready(function() {
	  $('#sendMessageBtn').on('click', function() {
	    var selectedEmployees = [];
	    $('input[name="selectedEmployees"]:checked').each(function() {
	      selectedEmployees.push($(this).val());
	    });

	    if (selectedEmployees.length > 0) {
	      console.log(selectedEmployees); // selectedEmployees 배열을 콘솔에 출력

	      // 배열 데이터를 URL 파라미터로 전달
	      const selectedEmployeesData = JSON.stringify(selectedEmployees);
	      window.location.href = contextPath + '/message/write?selectedEmployees=' + encodeURIComponent(selectedEmployeesData);
	    } else {
	      alert('선택된 직원이 없습니다.');
	    }
	  });
	});

</script>



<script>
  // 체크박스 전체선택 기능
  $(document).ready(function() {
    const selectAllBtn = $('#selectAllBtn');
    const checkboxes = $('input[name="selectedEmployees"]');

    let selectAll = false;

    selectAllBtn.on('click', function() {
      selectAll = !selectAll;

      checkboxes.prop('checked', selectAll);
    });
  });
</script>
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    
    