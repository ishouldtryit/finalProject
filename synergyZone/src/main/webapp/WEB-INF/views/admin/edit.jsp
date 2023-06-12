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
	
  	<body>

<form action="edit" method="post" enctype="multipart/form-data">

    <input type="hidden" name="empNo" value="${employeeDto.empNo}">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">
                
                	<div class="row mt-4">
                        <div class="col">
                           <div class="file-container d-flex justify-content-center">
							  <img class="rounded-circle profilePreview" width="200" height="200" src="/attachment/download?attachmentNo=${profile.attachmentNo}">
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
