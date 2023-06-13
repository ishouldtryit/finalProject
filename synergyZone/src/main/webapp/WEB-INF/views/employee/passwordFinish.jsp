<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <div class="container-fluid">
<style>
   #img_2{
      width:550px;
   }
</style>

<div class="container">
   <div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="p-5 bg-light border border-2 rounded-3">
        <img src="/static/img/logo.png" id="img_2" class="mb-4">
           <div class="text-center">
            <h3 class="text-center mt-4">비밀번호 변경이 완료되었습니다.</h3>
           </div>
      </div>
   </div>
</div>
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