<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .employee-name {
    color: dodgerblue;
  }
  
</style>
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
                $(this).addClass("bg-dangers");
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
                badgeClass = "bg-danger";
                break;
            default:
                break;
        }

     	// 모든 statusBadge 요소에 뱃지 내용 업데이트 및 클래스 추가/제거
        $(".statusBadge").text(badgeText).removeClass("bg-primary bg-warning bg-success bg-danger").addClass(badgeClass);
    });

});

</script>


<div class="container-800" style="margin-left: 5%;">
    <!-- 검색창 -->
    <form class="d-flex" action="myWorkList" id="workForm" method="get">
        <select name="column" class="form-input me-sm-2" onchange="submitForm()">
            <option value="work_title" ${column eq 'work_title' ? 'selected' : ''}>제목</option>
        </select>
        <input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${param.keyword}" style="width: 13%;">
        <button class="btn btn-info my-2 my-sm-0" type="submit">Search</button>
    </form>
    
    <!-- 사원 목록 테이블 -->
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
						<th>부서번호(나중에삭제)</th>
						<th>관리</th>
                    </tr>
                </thead>
					<tbody>
					    <c:forEach var="work" items="${list}">
					        <tr>
					            <td class="align-middle">${work.workReportDate}</td>
					            <td class="align-middle work-title" data-work-no="${work.workNo}">${work.workTitle}</td>
					            <td class="align-middle">
					                <span class="badge statusBadge" data-work-status="${work.workStatus}"></span>
					            </td>
					            <td class="align-middle">${work.workType}</td>
					            <td class="align-middle">${work.empName}</td>
					            <td class="align-middle">${work.deptNo}</td>
					            <td><a href="report?workNo=${work.workNo}">보고하기</a></td>
					        </tr>
					    </c:forEach>
					</tbody>

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

<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $(".work-title").click(function(){
        var workNo = $(this).data("work-no"); // Retrieve the workNo from the data attribute
        var detailUrl = "detail?workNo=" + workNo; // Construct the detail page URL
        window.location.href = detailUrl; // Redirect to the detail page
    });
});

</script>




<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>