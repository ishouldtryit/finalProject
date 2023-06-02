<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

</head>
<body>
<div class="container">
    <table class="table table-hover">
        <tr>
            <th>유형/구분</th>
            <td><select id="vacationName" name="vacationName">
                    <option value="">선택</option>
                    <option value="연차">국내출장</option>
                    <option value="병가">해외출장</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>대상자</th>
            <td><button>대상자 추가</button> <button>선택 삭제</button>
            <br>
                <table class="table">
                    <thead>
                        <tr>
                            <td> </td>
                            <td>부서</td>
                            <td>직급</td>
                            <td>이름</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                        	<td><input type="checkbox"></td>
                            <td>영업팀</td>
                            <td>사원</td>
                            <td>테스트사원</td>
                        </tr>
                    </tbody>
                </table>

            </td>
        </tr>
        <tr>
            <th>신청일시</th>
            <td><input type="date" id="startDate" name="startDate" min="YYYY-01-01" max="YYYY-12-31"> ~ <input
                    type="date" id="endDate" name="endDate" min="YYYY-01-01" max="YYYY-12-31">
                <input type="checkbox">휴일포함
            </td>
        </tr>
        <tr>
            <th>출발지</th>
            <td><input type="text" id="" placeholder="출발지를 입력해주세요"><button>경유지 추가</button>
            </td>
        </tr>
        <tr>
            <th>기간</th>
            <td>기간 <label>1일(총 8시간 0분)</label>
            </td>
        </tr>
        <tr>
            <th>목적지</th>
            <td><input type="text" id="" placeholder="출발지를 입력해주세요">
            </td>
        </tr>
        <tr>
            <th>장소</th>
            <td><input type="text" placeholder="출장장소를 입력해주세요"></td>
        </tr>
        <tr>
            <th>이동수단</th>
            <td><select>
                    <option value="">선택</option>
                    <option value="">관용차량</option>
                    <option value="">버스</option>
                    <option value="기차">기차</option>
                    <option value="비행기">비행기</option>
                    <option value="">자가</option>
                    <option value="">지하철</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>목적</th>
            <td><input type="text" name="reason" placeholder="목적을 입력해주세요"></td>
        </tr>
        <tr>
            <th>비고</th>
            <td><input type="text" name="reason" placeholder="비고를 입력해주세요"></td>
        </tr>
    </table>
    <input type="hidden" name="useCount">
    <button>등록</button>
    <br>
    <hr>
    <br>
    <h4>*신청내역</h4>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>이름</th>
                <th>부서명</th>
                <th>연차사용날짜</th>
                <th>휴가종류</th>
                <th>사유</th>
                <th>사용연차</th>
                <th>승인 상태</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td></td>
            </tr>
        </tbody>
    </table>
    </div>
</body>

</html>