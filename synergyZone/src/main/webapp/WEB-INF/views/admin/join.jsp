<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/static/js/employee/employee.js"></script>

    <!-- 다음 우편 API 사용을 위한 CDN -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/YURIMEEI/find-address@0.0.1/find-address.js"></script>
    
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
	
	<script type="text/javascript">
	   //주소api
    	$(function(){
		
        $(".address-btn").click(function(){
                   
            new daum.Postcode({ 
                oncomplete: function(data) {
                   
                    var addr = ''; 
                    var extraAddr = ''; 
                   
                    if (data.userSelectedType === 'R') { 
                        addr = data.roadAddress;
                    } else { 
                        addr = data.jibunAddress;
                    }
                    
                    document.querySelector("[name=empPostcode]").value = data.zonecode;
                    document.querySelector("[name=empAddress]").value = addr;
                    document.querySelector("[name=empDetailAddress]").focus();
                }
                }).open();
        
    		});
    	});
	</script>
	
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
	
    <form action="join" method="post" enctype="multipart/form-data">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">
                
                	<div class="row mt-4">
                        <div class="col">
                           <div class="file-container d-flex justify-content-center">
							  <img src="https://via.placeholder.com/200x200?text=P" alt="이미지 미리보기" class="file-preview rounded-circle" width="200" height="200">
							  <input class="file-input" type="file" name="attach" accept="image/*">
							</div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사원명</label>
                            <input class="form-control rounded" type="text" name="empName" placeholder="사원명">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">이메일</label>
                            <input class="form-control rounded" type="text" name="empEmail" placeholder="이메일">
                        </div>
                    </div>
                
                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">휴대폰번호</label>
                            <input class="form-control rounded" type="text" name="empPhone" placeholder="휴대폰번호">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">우편번호</label>
                            <input class="form-control rounded" type="text" name="empPostcode" placeholder="우편번호">
                            <button class="mt-2 btn btn-info address-btn" type="button">우편번호 찾기</button>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">기본주소</label>
                            <input class="form-control rounded" type="text" name="empAddress" placeholder="기본주소">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">상세주소</label>
                            <input class="form-control rounded" type="text" name="empDetailAddress" placeholder="상세주소">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">입사일</label>
                            <input class="form-control rounded" type="date" name="empHireDate" placeholder="입사일">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사업자 번호</label>
                            <input class="form-control rounded" type="text" name="cpNumber" placeholder="사업자 번호">
                        </div>
                    </div>


                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">부서번호</label>
                            <select id="deptNo" name="deptNo" class="form-select rounded">
                            	<option value="">부서선택</option>
                            	<c:forEach var="department" items="${departments}">
                            		  <option value="${department.deptNo}">${department.deptName}</option>
                            	</c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">직위번호</label>
                            <select id="jobNo" name="jobNo" class="form-select rounded">
                            	<option value="">직위선택</option>
                            	<c:forEach var="job" items="${jobs}">
                            		<option value="${job.jobNo}">${job.jobName}</option>
                            	</c:forEach>
                            </select>
                        </div>
                    </div>
                    
                   	 <div class="row mt-4">
                        <div class="col">
                          <button class="btn btn-info w-100">
                          가입
                          </button>
                        </div>
                    </div>
                    

                    

                </div>
            </div>
    
            
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>