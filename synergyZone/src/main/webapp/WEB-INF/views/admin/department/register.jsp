<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	
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
                 <li class="nav-item">
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
                 <li class="nav-item active">
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
	        var deptNo = $("input[name='deptNo']").val();
	        var deptName = $("input[name='deptName']").val();

	        $(".error-message").remove(); // 기존의 에러 메시지 삭제

	        if (deptNo === "") {
	            $("input[name='deptNo']").after('<div class="error-message text-danger">부서코드를 입력해 주세요.</div>');
	        }

	        if (deptName === "") {
	            $("input[name='deptName']").after('<div class="error-message text-danger">부서명을 입력해 주세요.</div>');
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
    <form action="${pageContext.request.contextPath}/admin/department/register" method="post" autocomplete="off">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">
                
                <div class="row mt-4">
                        <div class="col">
                            <h3>부서 등록</h3>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">부서코드</label>
                            <input class="form-control rounded" type="text" name="deptNo" placeholder="부서코드">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">부서명</label>
                            <input class="form-control rounded" type="text" name="deptName" placeholder="부서명">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                          <button class="btn btn-info w-100">
                          등록하기
                          </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
