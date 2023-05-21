<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/static/js/employee/employee.js"></script>

    <!-- 다음 우편 API 사용을 위한 CDN -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/YURIMEEI/find-address@0.0.1/find-address.js"></script>
	
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
	
    <form action="join" method="post" enctype="multipart/form-data">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사원명</label>
                            <input class="form-control rounded" type="text" name="empName" placeholder="사원명">
                        </div>
                    </div>

<!--                     <div class="row mt-4"> -->
<!--                         <div class="col"> -->
<!--                             <label class="form-label">비밀번호</label> -->
<!--                             <input class="form-control rounded" type="password" name="empPassword" placeholder="비밀번호"> -->
<!--                         </div> -->
<!--                     </div> -->

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
                            <button class="btn btn-primary address-btn" type="button">우편번호 찾기</button>
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
                    
                    <div class="row mt-4 target">
                    </div>
                    
                     <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">프로필사진</label>
                            <input class="form-control rounded" type="file" name="attach" placeholder="프로필사진">
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
                          <button class="btn btn-primary w-100">
                          회원가입
                          </button>
                        </div>
                    </div>
                    

                    

                </div>
            </div>
    
            
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>