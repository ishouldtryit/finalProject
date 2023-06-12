<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(document).ready(function() {
	    $("form").submit(function(e) {
	        e.preventDefault();

	        // 필드 검증
	        var deptNo = $("input[name='jobNo']").val();
	        var deptName = $("input[name='jobName']").val();

	        $(".error-message").remove(); // 기존의 에러 메시지 삭제

	        if (deptNo === "") {
	            $("input[name='jobNo']").after('<div class="error-message text-danger">직위코드를 입력해 주세요.</div>');
	        }

	        if (deptName === "") {
	            $("input[name='jobName']").after('<div class="error-message text-danger">직위명을 입력해 주세요.</div>');
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
    <form action="${pageContext.request.contextPath}/admin/job/register" method="post" autocomplete="off">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">직위코드</label>
                            <input class="form-control rounded" type="text" name="jobNo" placeholder="직위코드">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">직위명</label>
                            <input class="form-control rounded" type="text" name="jobName" placeholder="직위명">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                          <button class="btn btn-primary w-100">
                          등록하기
                          </button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
