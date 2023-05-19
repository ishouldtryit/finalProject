<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<head>
 	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/journal/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
 </head>
<script>
	$(function(){
		$(".del-btn").click(function(e){
			e.preventDefault();
			
			var choice = confirm("삭제하시겠습니까?");

			if(choice == false) return;
			
			var empNo = $(this).data("empno");
			
			$(".delete_empNo").val(empNo);
			$(".delete_form").submit();
		});
	});
</script>

<div class="container-600">
	<!-- 삭제 form -->
    <form action="delete" method="post" class="delete_form">
       <input type="hidden" name="empNo" class="delete_empNo">
    </form> 
       
	<div class="row center">
		<h2>사원 상세정보</h2>
	</div>
    
	<div class="row center">
		<table class="table center ms-20">
			<colgroup>
				<col style="width: 20%;">
           		<col style="width: 20%;">
           		<col style="width: 30%;">
           		<col style="width: 30%;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">사원번호</th>
					<td scope="col" colspan=3>${employeeDto.empNo}</td>			
				</tr>
				<tr>
					<th>이름</th>
					<td colspan=3>${employeeDto.empName}</td>				
				</tr>
				<tr>
					<th>전화번호</th>
					<td colspan=3>${employeeDto.empPhone}</td>				
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan=3>${employeeDto.empEmail}</td>				
				</tr>
				<tr>
					<th>등급</th>
					<td colspan=3>
						<c:if test="${employeeDto.adminCk == 1}"> 관리자 </c:if>
                  		<c:if test="${employeeDto.adminCk == 0}"> 일반회원</c:if>				
					</td>				
				</tr>
				<tr>
					<th >주소</th>
					<td>[${employeeDto.empPostcode}]</td>		
					<td scope="col">${employeeDto.empAdrress}</td>
					<td scope="col">${employeeDto.empDetailAddress}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="row right">
		<!-- 회원 관리 메뉴 -->
		<a class="link" href="${pageContext.request.contextPath}/admin/member/edit?memberId=${memberDto.memberId}">개인정보 변경</a>
		<a class="link del-btn" data-memberid="${memberDto.memberId}">탈퇴</a>
		<a class="link" href="${pageContext.request.contextPath}/admin/member/list">목록</a>
	</div>

</div>

 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

