<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="row">

    <form method="get">
        <div class="row">
        
         <div class="row">
	        <label class="form-label">사원명</label>
	        <input type="text" name="empName" value="${vo.empName}">
    	</div>
    	
    	<br><br>
    	
            <label class="form-label">기간</label>
            <select name="searchLoginDays">
                <option value="">선택하세요</option>
                <option value="7" ${vo.searchLoginDays == 7 ? 'selected' : ''}>최근 7일</option>
                <option value="30" ${vo.searchLoginDays == 30 ? 'selected' : ''}>최근 1개월</option>
                <option value="365" ${vo.searchLoginDays == 365 ? 'selected' : ''}>최근 1년</option>
            </select>
        </div>
        <button type="submit">검색</button>
    </form>

    <br><br>

    <!-- 결과화면 -->
    <c:choose>
        <c:when test="${logList != null}">
            <table>
                <thead>
                    <tr>
                        <th>시간</th>
                        <th>이름(이메일)</th>
                        <th>IP</th>
                        <th>브라우저</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="loginRecordDto" items="${logList}">
                        <tr>
                            <td>${loginRecordDto.logLogin}</td>
                            <td>${loginRecordDto.empName}</td>
                            <td>${loginRecordDto.logIp}</td>
                            <td>${loginRecordDto.logBrowser}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div>
                결과가 없습니다.
            </div>
        </c:otherwise>
    </c:choose>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>