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
                     <a class="nav-link" href="${pageContext.request.contextPath}/employee/edit">기본 정보</a>
                 </li>
                 <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/employee/password">비밀번호 변경</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>
<h1>비밀번호 변경이 완료되었습니다.</h1>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>