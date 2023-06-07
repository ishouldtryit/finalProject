<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
  <body>
     <form action="login" method="post">

        <div class="container-fluid mt-4">

            <div class="row">
                <div class="offset-md-2 col-md-8">

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">사원번호</label>
                            <input class="form-control rounded" type="text" name="empNo">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">비밀번호</label>
                            <input class="form-control rounded" type="password" name="empPassword">
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col">
                            <button class="btn btn-primary" type="submit">로그인</button>
                        </div>
                    </div>


                </div>
            </div>


        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>