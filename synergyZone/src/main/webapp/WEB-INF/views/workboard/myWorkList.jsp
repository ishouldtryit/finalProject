<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
  .employee-name {
    color: dodgerblue;
  }
  
</style>

<div class="container-800" style="margin-left: 5%;">
    <!-- 검색창 -->
    <form class="d-flex" action="list" method="get">
        <select id="workStatus" name="column" class="form-input me-sm-2">
            <option value="emp_name" ${column eq 'emp_name' ? 'selected' : ''}>이름</option>
            <option value="emp_no" ${column eq 'emp_no' ? 'selected' : ''}>사원번호</option>
            <option value="dept_name" ${column eq 'dept_name' ? 'selected' : ''}>부서</option>
            <option value="job_name" ${column eq 'job_name' ? 'selected' : ''}>직위</option>
        </select>
        <input class="form-control me-sm-2" type="search" placeholder="검색어" name="keyword" value="${param.keyword}" style="width: 13%;">
        <button class="btn btn-info my-2 my-sm-0" type="submit">Search</button>
    </form>
    
    <!-- 사원 목록 테이블 -->
    <div class="row">
        <div class="col" style="margin: 0 auto;">
            <form id="employeeForm">
                <table class="table table-hover mt-2" style="width: 90%;">
                    <thead>
                        <tr>
                            <th>보고일자</th>
                            <th>제목</th>
                            <th>업무 상태</th>
                            <th>업무 종류</th>
                            <th>보고자</th>
                            <th>결재상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="work" items="${myWorkList}">
                            <tr>
                                <td class="align-middle">${work.workReportDate}</td>
                                <td class="align-middle">${work.workTitle}</td>
                                <td class="align-middle">
                                    <span class="badge bg-success statusBadge" data-work-status="${work.workStatus}"></span>
                                </td>
                                <td class="align-middle">${work.workType}</td>
                                <td class="align-middle">${work.empName}</td>
                                <td class="align-middle">${work.workResult}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
</div>

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
                case '0':
                    badgeText = '요청';
                    break;
                case '1':
                    badgeText = '진행';
                    break;
                case '2':
                    badgeText = '완료';
                    break;
                case '3':
                    badgeText = '보류';
                    break;
                default:
                    break;
            }

            // 뱃지 내용 업데이트
            $(this).text(badgeText);
        });

        // workStatus 변경 시 뱃지 내용 업데이트
        $("#workStatus").change(function(){
            var selectedValue = $(this).val();
            var badgeText = "";

            // 선택한 값에 따라 뱃지 내용 설정
            switch (selectedValue) {
                case '0':
                    badgeText = '요청';
                    break;
                case '1':
                    badgeText = '진행';
                    break;
                case '2':
                    badgeText = '완료';
                    break;
                case '3':
                    badgeText = '보류';
                    break;
                default:
                    break;
            }

            // 모든 statusBadge 요소에 뱃지 내용 업데이트
            $(".statusBadge").text(badgeText);
        });
    });
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
