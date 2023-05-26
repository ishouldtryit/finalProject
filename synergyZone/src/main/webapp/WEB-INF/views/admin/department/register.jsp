<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
  
  <body>
    <form action="${pageContext.request.contextPath}/employee/department/register" method="post" autocomplete="off">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">부서번호</label>
                            <input class="form-control rounded" type="text" name="deptNo" placeholder="부서번호">
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>