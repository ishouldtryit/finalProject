<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<head>
	    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
	    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
  	</head>
  
  <body>
    <form action="${pageContext.request.contextPath}/employee/job/register" method="post" autocomplete="off">
        <div class="container-fluid mt-4">
    
            <div class="row">
                <div class="offset-md-2 col-md-8">

                    <div class="row mt-4">
                        <div class="col">
                            <label class="form-label">직위번호</label>
                            <input class="form-control rounded" type="text" name="jobNo" placeholder="직위번호">
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

  </body>
</html>