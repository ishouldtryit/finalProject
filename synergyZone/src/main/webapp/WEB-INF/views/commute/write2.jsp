<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
    $(function(){
    	$(".add-btn").click(function() {
    	    $("#hide").removeAttr("style");
    	});
    	$(".del-btn").click(function() {
    		$("#hide").closest("tr").css("display", "none");
    		$("#stopover").val("");
    	});
    	function updateUseCount() {
			var startDate = new Date($('#startDate').val());
			var endDate = new Date($('#endDate').val());

			// 이전 날짜 선택못함
			if (endDate < startDate) {
				$('#endDate').val($('#startDate').val());
				endDate = new Date($('#endDate').val());
			}
		}

		// startDate와 endDate의 값이 변경될 때마다 useCount 업데이트
		$('#startDate, #endDate').change(function() {
			updateUseCount();
		});
		
		$('#employeeList tr').click(function() {
	        var department = $(this).find('td:eq(0)').text();
	        var position = $(this).find('td:eq(1)').text();
	        var name = $(this).find('td:eq(2)').text();
	        
	        var newRow = $('<tr></tr>').append(
	            $('<td></td>').text(department),
	            $('<td></td>').text(position),
	            $('<td></td>').text(name)
	        );
	        
	        $('#selectedEmployees').append(newRow);
	    });

});
    
    
</script>

</head>
<body>
	<div class="container" id="app">
		<form action="/commute/trip" method="post">
			<table class="table">
				<tr>
					<th>유형/구분</th>
					<td><select id="name" name="name">
							<option value="">선택</option>
							<option value="출장">출장</option>
							<option value="외근">외근</option>
					</select></td>
				</tr>
				<tr>
					<th>대상자</th>
					<td>
						<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">대상자추가</button>
						<button type="button">선택 삭제</button> <br>
						<table class="table">
							<thead>
								<tr>
									<td></td>
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
					<td><input type="date" id="startDate" name="startDate"
						min="YYYY-01-01" max="YYYY-12-31"> ~ <input type="date"
						id="endDate" name="endDate" min="YYYY-01-01" max="YYYY-12-31">
						<input type="checkbox">휴일포함</td>
				</tr>
				<tr>
					<th>기간</th>
					<td>기간 <label>1일(총 8시간 0분)</label></td>
				</tr>
				<tr>
					<th>출발지</th>
					<td><input type="text" name="startPlace"
						placeholder="출발지를 입력해주세요">
						<button class="add-btn" type="button">경유지 추가</button></td>
				</tr>

				<tr id="hide" style="display: none;">
					<th>경유지</th>
					<td><input type="text" name="middlePlace"
						placeholder="경유지를 입력해주세요">
					<button class="del-btn" type="button">삭제</button></td>
				</tr>
				<tr>
					<th>목적지</th>
					<td><input type="text" name="endPlace"
						placeholder="목적지를 입력해주세요"></td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="place" placeholder="출장장소를 입력해주세요"></td>
				</tr>
				<tr>
					<th>이동수단</th>
					<td><select id="work" name="work">
							<option value="">선택</option>
							<option value="관용차랑">관용차량</option>
							<option value="버스">버스</option>
							<option value="택시">택시</option>
							<option value="기차">기차</option>
							<option value="비행기">비행기</option>
							<option value="자가">자가</option>
							<option value="지하철">지하철</option>
					</select></td>
				</tr>
				<tr>
					<th>목적</th>
					<td><input type="text" name="purpose" placeholder="목적을 입력해주세요"></td>
				</tr>
				<tr>
					<th>비고</th>
					<td><input type="text" name="notes" placeholder="비고를 입력해주세요"></td>
				</tr>
			</table>
			<input type="hidden" name="">
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
		</form>
<!-- 모달 창 HTML -->
<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="myModalLabel">대상자 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-6">
                        <h6>사원 목록</h6>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>부서</th>
                                    <th>직급</th>
                                    <th>이름</th>
                                </tr>
                            </thead>
                            <tbody id="employeeList">
                                <tr onclick="addToSelectedEmployees(this)">
                                    <td>영업팀</td>
                                    <td>사원</td>
                                    <td>테스트사원</td>
                                </tr>
                                <!-- 다른 사원들의 정보도 추가 -->
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-6">
                        <h6>추가된 사원</h6>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>부서</th>
                                    <th>직급</th>
                                    <th>이름</th>
                                </tr>
                            </thead>
                            <tbody id="selectedEmployees">
                                <!-- 추가된 사원들의 정보가 여기에 추가될 예정 -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="saveEmployees()">저장</button>
            </div>
        </div>
    </div>
</div>





	</div>


</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

 </html>

