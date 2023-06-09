<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        height: 35px; /* 원하는 높이로 조정하세요 */
        line-height: 35px; /* 원하는 높이로 조정하세요 */
    }
</style>


<div class="container-800" style="margin-left: 5%;">
    <!-- 검색창 -->
		<form class="d-flex" action="mylist" method="get">
	    <select name="column" class="form-input me-sm-2">
	        <option value="emp_name" ${column eq 'emp_name' ? 'selected' : ''}>이름</option>
	        <option value="emp_no" ${column eq 'emp_no' ? 'selected' : ''}>사원번호</option>
	        <option value="dept_name" ${column eq 'dept_name' ? 'selected' : ''}>부서</option>
	        <option value="job_name" ${column eq 'job_name' ? 'selected' : ''}>직위</option>
	    </select>
	
	    <input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${param.keyword}" style="width: 13%;">
	    <button class="btn btn-info my-2 my-sm-0" type="submit">Search</button>
	    <button type="button" id="deleteBtn" class="btn btn-danger">선택된 사원 삭제</button>
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
		          <c:forEach var="bookmark" items="${bookmarkList}">
		            <c:forEach var="employeeDto" items="${employees}">
		              <c:if test="${bookmark.bookmarkNo == employeeDto.empNo}">
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
						      /attachment/download?attachmentNo=${employeeDto.attachmentNo}
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
		              </c:if>
		            </c:forEach>
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
			    <img id="profileImage" width="200" height="300" src="/attachment/download?attachmentNo=" alt="프로필 이미지">
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
    <ul class="pagination" style="width: 20%;">
        <li class="page-item ${vo.isFirst() ? 'disabled' : ''}">
            <a class="page-link" href="${vo.isFirst() ? '#' : pageContext.request.contextPath}/bookmark/mylist?page=${vo.getPrevPage()}">&laquo;</a>
        </li>
        <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
            <li class="page-item">
                <a class="page-link ${vo.getPage() eq i ? 'active' : ''}" href="${pageContext.request.contextPath}/bookmark/mylist?page=${i}&sort=${param.sort}">
                    <span class="text-info">${i}</span>
                </a>
            </li>
        </c:forEach>
        <li class="page-item ${vo.isLast() ? 'disabled' : ''}">
            <a class="page-link" href="${vo.isLast() ? '#' : pageContext.request.contextPath}/bookmark/mylist?page=${vo.getNextPage()}&sort=${param.sort}">
                <span class="text-info">&raquo;</span>
            </a>
        </li>
    </ul>
</div>

</div>

</html>

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
        $("#profileImage").attr("src", "/attachment/download?attachmentNo=" + attachmentNo);
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
      // 여기에 사원 상세 정보를 설정하는 코드를 추가
    

      $('#employeeInfoModal').modal('show');
    });
  });
  
  //프로필 이미지 클릭시 모달창 
 $('.profile-image').click(function() {
    var employeeName = $(this).data('empname');
    var employeePhone = $(this).data('empphone');
    var employeeEmail = $(this).data('empemail');
    var employeeAddress = $(this).data('empaddress');
    var employeeDetailAddress = $(this).data('empdetailaddress');
    var attachmentNo = $(this).data('attachmentno');
    var departmentName = $(this).closest('tr').find('td:eq(7)').text(); // 부서 정보 가져오기
    var jobName = $(this).closest('tr').find('td:eq(8)').text(); // 직위 정보 가져오기

    $('#employeeInfoModalLabel').text(employeeName);
    $('#employeeName').text(employeeName);
    $('#employeePhone').text(employeePhone);
    $('#employeeEmail').text(employeeEmail);
    $('#employeeAddress').text(employeeAddress);
    $('#employeeDetailAddress').text(employeeDetailAddress);
    $('#employeeDepartment').text(departmentName); // 부서 정보 설정
    $('#employeeJob').text(jobName); // 직위 정보 설정

    // 더미이미지 삽입
    if (attachmentNo > 0) {
      $("#profileImage").attr("src", "/attachment/download?attachmentNo=" + attachmentNo);
    } else {
      $("#profileImage").attr("src", "https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg");
    }

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
    
    
<script>//체크박스 전체 선택 기능
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

<script>
  // 삭제 버튼 클릭 시
  $("#deleteBtn").click(function() {
    var selectedBookmarkNoList = [];

    // 선택된 북마크 번호를 배열에 추가
    $("input[type=checkbox]:checked").each(function() {
      selectedBookmarkNoList.push($(this).val());
    });

    // 선택된 북마크가 없는 경우 알림 메시지 표시
    if (selectedBookmarkNoList.length === 0) {
      alert("삭제할 사원들을 선택해주세요.");
      return;
    }

    // 삭제 여부 확인
    var confirmation = confirm("선택한 주소록을 삭제하시겠습니까?");
    if (!confirmation) {
      return;
    }

    // AJAX를 사용하여 선택된 북마크 삭제 요청 보내기
    $.ajax({
      url: "/bookmark/removeBookmark",
      type: "POST",
      contentType: "application/json;charset=UTF-8",
      data: JSON.stringify({ bookmarkNo: selectedBookmarkNoList }),
      success: function() {
        // 삭제 성공한 경우 처리할 로직 작성
        alert("주소록이 삭제되었습니다.");
        location.reload(); // 페이지 새로고침
      },
      error: function() {
        // 삭제 실패한 경우 처리할 로직 작성
        alert("주소록 삭제 실패");
      }
    });
  });
</script>


    