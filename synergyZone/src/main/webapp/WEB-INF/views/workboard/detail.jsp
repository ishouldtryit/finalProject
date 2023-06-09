<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<style>
   a{color:#34649C;}
   a:hover{
      color:blue;
   }
</style>

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
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/write">일지 작성</a>
                 </li>
                 <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/list">부서 업무일지</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/myWorkList">내 업무일지</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/supList">공유받은 업무일지</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>
<script>
    $(document).ready(function() {
        //글 삭제 시 경고창
        $(".delete-button").click(function(){
            var result = confirm("정말 삭제하시겠습니까?");
            if(result){
                return true;
            }
            else{
                return false;
            }
        });

        //비밀글 표시
        $(".secretBadge").each(function() {
            var workSecret = $(this).data("work-secret");
            var badgeText = "";

            if(workSecret == 'Y'){
                badgeText = '비밀글';
                $(this).addClass("badge-secondary");
            } else {
                badgeText = '';
            }

            // 뱃지 내용 업데이트
            $(this).text(badgeText);
        });

        $(".text-info a").each(function() {
            var fileSize = $(this).attr("data-file-size");
            var formattedSize = formatBytes(fileSize);
            $(this).text($(this).text() + " [" + formattedSize + "]");
        });
    });

    function formatBytes(bytes, decimals = 2) {
        if (bytes === 0) return '0 Bytes';

        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

        const i = Math.floor(Math.log(bytes) / Math.log(k));

        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
    }
</script>

<div class="container">

    <div class="d-flex justify-content-end">
		<div class="container-fluid mb-2">
   
    <div class="d-flex justify-content-end col-md-10 offset-md-1">

        <c:if test="${owner}">
            <a href="${pageContext.request.contextPath}/workboard/edit?workNo=${workBoardDto.workNo}" class="btn btn-outline-secondary ms-2">
                <i class="fa-regular fa-pen-to-square" style="color: #8f8f8f;"></i>&nbsp;수정
            </a>
        </c:if>
        <c:if test="${owner || admin}">

            <a href="${pageContext.request.contextPath}/workboard/delete?workNo=${workBoardDto.workNo}" class="btn btn-outline-secondary delete-button ms-2">
                <i class="fa-solid fa-trash-can" style="color: #8f8f8f;"></i>&nbsp;삭제
            </a>
        </c:if>

        <a href="${pageContext.request.contextPath}/workboard/list" class="btn btn-outline-secondary ms-2">

            <i class="fa-solid fa-bars" style="color: #8f8f8f;"></i>&nbsp;목록
        </a>
    </div>
<!-- </div> -->
<!-- </div> -->

    <!-- 제목 -->
    <div class="row">
        <div class="row mt-4">
            <div class="">
                <div class="mb-4 ms-1">
                    <h3 class="">${workBoardDto.workTitle}</h3>
                    <span class="badge badge-pill secretBadge" data-work-secret="${workBoardDto.workSecret}"></span>
                </div>

                <div class="d-flex align-items-center">
                    <div class="profile-image employee-name">
                        <img width="24" height="24" src="<c:choose>
                                <c:when test="${workBoardDto.attachmentNo > 0}">
                                    ${pageContext.request.contextPath}/attachment/download?attachmentNo=${workBoardDto.attachmentNo}
                                </c:when>
                                <c:otherwise>
                                    https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
                                </c:otherwise>
                            </c:choose>" alt="" style="border-radius: 50%;">
                    </div>
                    <h6 class="text" style="margin-left: 10px; margin-top:10px; font-weight: nomal">
                        <c:forEach var="employeeDto" items="${employees}">
                            <c:if test="${employeeDto.empNo == workBoardDto.empNo}">
                                ${employeeDto.empName}
                            </c:if>
                        </c:forEach>
                        <span class="ms-2 text-secondary" style="font-weight:lighter; font-size:14px;">
                            <fmt:formatDate value="${workBoardDto.workReportDate}" pattern="y년 M월 d일 H시 m분 "/>
                        </span>
                    </h6>
                </div>
            </div>

        </div>

    </div>
<hr>
    <!-- 게시글 내용 -->
    <div class="row mt-4" style="min-height:350px;">
        <div class="" value="${workBoardDto.workContent}">
            ${workBoardDto.workContent}
        </div>
   
      <c:if test="${files != null}">
      
               <div class="row mt-4">
                   <div class="col-lg-12">
                       <div class="card shadow mb-4">
                           <div class="card-header py-3">
                               <h4 class="m-0 font-weight-bold text-info">File Attach</h4>
                           </div>
                           <div class="card-body">
                               <div class="text-info">
                                   <c:forEach var="file" items="${files}">
                                       <a href="${pageContext.request.contextPath}/attachment/download?attachmentNo=${file.attachmentNo}" data-file-size="${file.attachmentSize}">
                                           ${file.attachmentName}
                                       </a>
                                       <br/>
                                   </c:forEach>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
           
      </c:if>
      <c:if test="${files == null}">
      	<div class="row mt-4">
                   <div class="col-lg-12">
                       <div class="card shadow mb-4">
                           <div class="card-header py-3">
                               <h4 class="m-0 font-weight-bold text-info">File Attach[0]</h4>
                           </div>
                       </div>
                   </div>
               </div>
      </c:if>
	
    </div>
    <br>
</div>
</div>
</div>
