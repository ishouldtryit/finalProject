<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <head>
 	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
  	</head>
  	<body>

    <form action="join" method="post">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사원번호</label>
                            <input class="form-control rounded" type="text" name="empNo" placeholder="사원번호">
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
                            <label class="form-label">비밀번호</label>
                            <input class="form-control rounded" type="password" name="empPassword" placeholder="비밀번호">
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
                            <label class="form-label">우편번호</label>
                            <input class="form-control rounded" type="text" name="empPostcode" placeholder="우편번호">
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
                            <label class="form-label">퇴사여부</label>
                            <input class="form-control rounded" type="text" name="isLeave" placeholder="퇴사여부">
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
                            <label class="form-label">직위번호</label>
                            <input class="form-control rounded" type="text" name="jobNo" placeholder="사업자 번호">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">부서번호</label>
                            <input class="form-control rounded" type="text" name="deptNo" placeholder="사업자 번호">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">형태코드</label>
                            <input class="form-control rounded" type="text" name="wtCode" placeholder="사업자 번호">
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

  </body>
</html>