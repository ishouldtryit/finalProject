<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
    	$(document).ready(function() {
    		
    		$(".delete-button").click(function(){
    	    	var result = confirm("정말 삭제하시겠습니까?");
    	    	
    	    	if(result){
    	    		return true;
    	    	}
    	    	else{
    	    		return false;
    	    	}
    	    });
    	});
    </script>


<div class="border container-fluid">
	
	<c:if test="${owner}">
		<a href="/workboard/edit?workNo=${workBoardDto.workNo}" class="btn btn-light btn-sm"><i class="fa-solid fa-bars" style="color: #8f8f8f;"></i>&nbsp;수정</a>
	</c:if>
	<c:if test="${owner || admin}">
		<a href="/workboard/delete?workNo=${workBoardDto.workNo}" class="btn btn-light delete-button btn-sm"><i class="fa-solid fa-bars" style="color: #8f8f8f;" ></i>&nbsp;삭제</a>
	</c:if>
	<a href="/workboard/list" class="btn btn-light btn-sm"><i class="fa-solid fa-bars" style="color: #8f8f8f;"></i>&nbsp;목록</a>
	
	<!-- 제목 -->
	<div class="row">
	<div class="row mt-4">
		<div class="col-md-10 offset-md-1">
			<h3>${workBoardDto.workTitle}
						
			</h3>
			
			<div class="d-flex align-items-center">
			 <div class="profile-image employee-name">
			    <img width="24" height="24" src="<c:choose>
			        <c:when test="${profile.empNo == workBoardDto.empNo}">
			            /attachment/download?attachmentNo=${profile.attachmentNo}
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
			  <span class="ms-2 text-secondary" style="font-weight:lighter; font-size:14px;"><fmt:formatDate value="${workBoardDto.workReportDate}" 
						pattern="y년 M월 d일 H시 m분 "/></span></h6>
			</div>
		</div>
	</div>
</div>
	
	
	
	<!-- 게시글 내용 -->
	<div class="row mt-4" style="min-height:350px;">
		<div class="col-md-10 offset-md-1" value="${workBoardDto.workContent}">
			${workBoardDto.workContent}
		</div>
		
		  <c:forEach var="file" items="${files}">
                   <a href="/attachment/download?attachmentNo=${file.attachmentNo}">${file.attachmentName}</a>
                   <c:if test="${not loop.last}">, </c:if>            
               </c:forEach>
               
                <c:forEach var="workSup" items="${workSups}" varStatus="loop">
                    ${workSup.empName}
                    <c:if test="${not loop.last}">, </c:if>
                </c:forEach>
               
		
		
		<div class="col-md-10 offset-md-1" value="${workBoardDto.workContent}">
			${workBoardDto.workSecret}
		</div>
	</div>

	<br>
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>