<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/static/js/employee/employee.js"></script>

    <style>
    	.file-container {
		  position: relative;
		  display: inline-block;
		}
		
		.file-input {
		  position: absolute;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 100%;
		  opacity: 0;
		  cursor: pointer;
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
                 <li class="nav-item active">
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
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/admin/job/list">직위 관리</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>
 
 	<script>
	$(document).ready(function() {
	    $("form").submit(function(e) {
	        e.preventDefault();

	        // 필드 검증
	        var empName = $("input[name='empName']").val();
	        var empEmail = $("input[name='empEmail']").val();
	        var empPhone = $("input[name='empPhone']").val();
	        var empPostcode = $("input[name='empPostcode']").val();
	        var empAddress = $("input[name='empAddress']").val();
	        var empDetailAddress = $("input[name='empDetailAddress']").val();
	        var empHireDate = $("input[name='empHireDate']").val();
	        var cpNumber = $("input[name='cpNumber']").val();
	        var deptNo = $("select[name='deptNo']").val();
	        var jobNo = $("select[name='jobNo']").val();

	        $(".error-message").remove(); // 기존의 에러 메시지 삭제

	        if (empName === "") {
	            $("input[name='empName']").after('<div class="error-message text-danger">사원명을 입력해 주세요.</div>');
	        }

	        if (empEmail === "") {
	            $("input[name='empEmail']").after('<div class="error-message text-danger">이메일을 입력해 주세요.</div>');
	        }

	        if (empPhone === "") {
	            $("input[name='empPhone']").after('<div class="error-message text-danger">휴대폰번호를 입력해 주세요.</div>');
	        }

	        if (empPostcode === "") {
	            $("input[name='empPostcode']").after('<div class="error-message text-danger">우편번호를 입력해 주세요.</div>');
	        }

	        if (empAddress === "") {
	            $("input[name='empAddress']").after('<div class="error-message text-danger">기본주소를 입력해 주세요.</div>');
	        }

	        if (empDetailAddress === "") {
	            $("input[name='empDetailAddress']").after('<div class="error-message text-danger">상세주소를 입력해 주세요.</div>');
	        }

	        if (empHireDate === "") {
	            $("input[name='empHireDate']").after('<div class="error-message text-danger">입사일을 입력해 주세요.</div>');
	        }

	        if (cpNumber === "") {
	            $("input[name='cpNumber']").after('<div class="error-message text-danger">사업자 번호를 입력해 주세요.</div>');
	        }

	        if (deptNo === "") {
	            $("select[name='deptNo']").after('<div class="error-message text-danger">부서번호를 선택해 주세요.</div>');
	        }

	        if (jobNo === "") {
	            $("select[name='jobNo']").after('<div class="error-message text-danger">직위번호를 선택해 주세요.</div>');
	        }

	        // 검증 후 서브밋
	        if ($(".error-message").length === 0) {
	            $("form").off("submit"); // 재검증을 막기 위해 submit 이벤트 제거
	            $("form")[0].submit(); // 폼 서브밋
	        }
	    });
	});

	</script>
	
  	<body>

<form action="${pageContext.request.contextPath}/admin/edit" method="post" enctype="multipart/form-data">

    <input type="hidden" name="empNo" value="${employeeDto.empNo}">
        <div class="container-fluid mt-4">

			<div class="row">
                <div class="offset-md-2 col-md-8">

					<div class="row mt-4">
						<div class="col">
							<h3>사원정보 수정</h3>
							<br>
						</div>
					</div>

					<div class="row mt-4">
                        <div class="col">
                           <div class="file-container d-flex justify-content-center">
							  <img class="rounded-circle profilePreview" width="200" height="200" src="${pageContext.request.contextPath}/attachment/download?attachmentNo=${profile.attachmentNo}">
							  <input class="file-input" type="file" name="attach" id="profileImage" accept="image/*">
							</div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사원명</label>
                          <input class="form-control rounded" type="text" name="empName" placeholder="사원명" value="${employeeDto.empName}">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">이메일</label>
                            <input class="form-control rounded" type="text" name="empEmail" placeholder="이메일" value="${employeeDto.empEmail}">
                        </div>
                    </div>
                
                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">휴대폰번호</label>
                            <input class="form-control rounded" type="text" name="empPhone" placeholder="휴대폰번호" value="${employeeDto.empPhone}">
                        </div>
                    </div>
                    
<!--                     <div class="row mt-4"> -->
<!-- 					    <div class="col"> -->
<%-- 					        <img class="rounded-circle profilePreview" width="200" height="200" src="/attachment/download?attachmentNo=${profile.attachmentNo}"> --%>
<!-- 					        <label class="form-label">프로필사진</label> -->
<!-- 					        <input class="form-control rounded" type="file" id="profileImage" name="attach" placeholder="프로필사진"> -->
<!-- 					    </div> -->
<!-- 					</div> -->

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">입사일</label>
                            <input class="form-control rounded" type="date" name="empHireDate" placeholder="입사일" value="${employeeDto.empHireDate}">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사업자 번호</label>
                            <input class="form-control rounded" type="text" name="cpNumber" placeholder="사업자 번호" value="${employeeDto.cpNumber}">
                        </div>
                    </div>


                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">부서</label>
                            <select id="deptNo" name="deptNo" class="form-select rounded">
                            	<option value="">부서선택</option>
                            	<c:forEach var="department" items="${departments}">
                            		  <option value="${department.deptNo}"
                            		  	<c:if test="${department.deptNo == employeeDto.deptNo}">
                            		  		selected
                            		  	</c:if>
                            		  	>
                            		  	${department.deptName}
                            		  </option>
                            	</c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">직위</label>
                            <select id="jobNo" name="jobNo" class="form-select rounded">
                            	<option value="">직위선택</option>
                            	<c:forEach var="job" items="${jobs}">
                            		<option value="${job.jobNo}"
                            			<c:if test="${job.jobNo == employeeDto.jobNo}">
                            				selected
                            			</c:if>
                            			>
                            			${job.jobName}
                            		</option>
                            	</c:forEach>
                            </select>
                        </div>
                    </div>
                    
                   	 <div class="row mt-4">
                        <div class="col">
                          <button class="btn btn-primary w-100">
                          수정
                          </button>
                        </div>
                    </div>
                    

                    

                </div>
            </div>
    
            
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>