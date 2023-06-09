<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .employee-name {
    color: dodgerblue;
  }
    .work-title {
    cursor: pointer;
  }
  
  a {
	color: black;
}

a:hover {
	color: red;
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
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/list">부서 업무일지</a>
                 </li>
                 <li class="nav-item active">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/myWorkList">내 업무일지</a>
                 </li>
                 <li class="nav-item">
                     <a class="nav-link" href="${pageContext.request.contextPath}/workboard/supList">공유받은 업무일지</a>
                 </li>
             </ul>
         </div>
     </div>
 </nav>
<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    // 각 뱃지 요소에 대해 처리
    $(".statusBadge").each(function() {
        var workStatus = $(this).data("work-status");
        var badgeText = "";

        // workStatus 값에 따라 뱃지 내용 설정
        switch (workStatus) {
            case 0:
                badgeText = '요청';
                $(this).addClass("bg-primary");
                break;
            case 1:
                badgeText = '진행';
                $(this).addClass("bg-warning");
                break;
            case 2:
                badgeText = '완료';
                $(this).addClass("bg-success");
                break;
            case 3:
                badgeText = '보류';
                $(this).addClass("bg-secondary");
                break;
            default:
                break;
        }

        // 뱃지 내용 업데이트
        $(this).text(badgeText);
    });

 // workStatus 변경 시 뱃지 내용 업데이트
    $("#workStatus").change(function(){
        var selectedValue = parseInt($(this).val());  // 선택한 값을 정수로 변환
        var badgeText = "";

        // 선택한 값에 따라 뱃지 내용 설정
        switch (selectedValue) {
            case 0:
                badgeText = '요청';
                badgeClass = "bg-primary";
                break;
            case 1:
                badgeText = '진행';
                badgeClass = "bg-warning";
                break;
            case 2:
                badgeText = '완료';
                badgeClass = "bg-success";
                break;
            case 3:
                badgeText = '보류';
                badgeClass = "bg-secondary";
                break;
            default:
                break;
        }

     	// 모든 statusBadge 요소에 뱃지 내용 업데이트 및 클래스 추가/제거
        $(".statusBadge").text(badgeText).removeClass("bg-primary bg-warning bg-success bg-secondary").addClass(badgeClass);
    });
 
    $(".work-title").click(function(){
        var workNo = $(this).data("work-no"); // Retrieve the workNo from the data attribute
        var detailUrl = contextPath+"/workboard/detail?workNo=" + workNo; // Construct the detail page URL
        window.location.href = detailUrl; // Redirect to the detail page
    });
    
    // 각 뱃지 요소에 대해 처리
    $(".signBadge").each(function() {
        var resultCode = $(this).data("result-code");
        var statusCode = $("#statusCode").val();
        var supCount = $("#supCount").val();
        var badgeText = "";

        // workStatus 값에 따라 뱃지 내용 설정
        switch (resultCode) {
            case 0:
                badgeText = '진행중';
                $(this).addClass("bg-secondary");
                break;
            case 1:
                badgeText = '반려';
                $(this).addClass("bg-warning");
                break;
            case 2:
                badgeText = '결재';
                $(this).addClass("bg-success");
                break;
            default:
                break;
        }

        // 뱃지 내용 업데이트
        $(this).text(badgeText);
    });

 // workStatus 변경 시 뱃지 내용 업데이트
    $("#resultCode").change(function(){
        var selectedValue = parseInt($(this).val());  // 선택한 값을 정수로 변환
        var badgeText = "";

        // 선택한 값에 따라 뱃지 내용 설정
        switch (selectedValue) {
	        case 0:
	            badgeText = '진행중';
	            $(this).addClass("bg-secondary");
	            break;
	        case 1:
	            badgeText = '반려';
	            $(this).addClass("bg-warning");
	            break;
	        case 2:
	            badgeText = '결재';
	            $(this).addClass("bg-success");
	            break;
	        default:
	            break;
	    }

     	// 모든 statusBadge 요소에 뱃지 내용 업데이트 및 클래스 추가/제거
        $(".signBadge").text(badgeText).removeClass("bg-secondary bg-warning bg-success").addClass(badgeClass);
    });

});

</script>


<div class="container-800" style="margin-left: 5%;">

	<h3>내 업무일지</h3>
	<br>
	
    <!-- 검색창 -->
    <form class="d-flex" action="${pageContext.request.contextPath}/workboard/myWorkList" id="workForm" method="get">
        <select name="column" class="form-input me-sm-2" onchange="submitForm()">
            <option value="work_title" ${column eq 'work_title' ? 'selected' : ''}>제목</option>
        </select>
        <input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${param.keyword}" style="width: 13%;">
        <button class="btn btn-info my-2 my-sm-0" type="submit">Search</button>
    </form>
    
    <!-- 내 업무일지 테이블 -->
    <div class="row">
        <div class="col" style="margin: 0 auto;">
            <table class="table table-hover mt-2" style="width: 90%;">
                <thead>
                    <tr>
                        <th>보고일자</th>
                        <th>제목</th>
                        <th>업무상태</th>
                        <th>업무종류</th>
                        <th>보고자</th>
<!--                         <th>결재상태</th> -->
                        <th>보고</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="work" items="${myWorkList}">
                        <tr>
                            <td class="align-middle">${work.workReportDate}</td>
                            <td class="align-middle work-title" data-work-no="${work.workNo}">${work.workTitle}</td>
                            <td class="align-middle">
                                <span class="badge statusBadge" data-work-status="${work.workStatus}"></span>
                            </td>
                            <td class="align-middle">${work.workType}</td>
                            <td class="align-middle">${work.empName}</td>
<!--                             <td class="align-middle"> -->
<%--                                 <span class="badge signBadge" data-result-code="${work.resultCode}"></span> --%>
<%--                                 <input type="hidden" id="statusCode" value="${work.statusCode}"> --%>
<%--                                 <input type="hidden" id="supCount" value="${work.supCount}"> --%>
<!--                             </td> -->
                            <td><a href="report?workNo=${work.workNo}">보고</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <c:if test="${empty myWorkList}">
				    <td colspan="15" class="text-center">검색 결과가 없습니다.</td>
				</c:if>
            </table>
        </div>
    </div>
    
    <!-- 페이징 영역 -->
		<div style="display: flex; justify-content: center;">
		  <ul class="pagination" style="width: 20%;">
		    <li class="page-item ${vo.isFirst() ? 'disabled' : ''}">
		      <a class="page-link" href="${vo.isFirst() ? '#' : pageContext.request.contextPath}/workboard/myWorkList?page=${vo.getPrevPage()}&sort=${vo.getSort()}${vo.getQueryString()}">&laquo;</a>
		    </li>
		    <c:forEach var="i" begin="${vo.getStartBlock()}" end="${vo.getFinishBlock()}">
		      <li class="page-item">
		        <a class="page-link ${vo.getPage() eq i ? 'active' : ''}" href="${pageContext.request.contextPath}/workboard/myWorkList?page=${i}&sort=${vo.getSort()}${vo.getQueryString()}">
		          <span class="text-info">${i}</span>
		        </a>
		      </li>
		    </c:forEach> 
		    <li class="page-item ${vo.isLast() ? 'disabled' : ''}">
		      <a class="page-link" href="${vo.isLast() ? '#' : pageContext.request.contextPath}/workboard/myWorkList?page=${vo.getNextPage()}&sort=${vo.getSort()}${vo.getQueryString()}">
		        <span class="text-info">&raquo;</span>
		      </a>
		    </li>
		  </ul>
		</div>
</div>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>