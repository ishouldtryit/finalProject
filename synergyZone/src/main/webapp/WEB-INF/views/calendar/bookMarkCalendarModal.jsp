<%--<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.m-footer {
		width:100%;
		height:80px;
		display:flex;
		justify-content:center;
	}
	#m-appSel2 {
		max-width: 400px;
	}
	#m-list2 {
		height: 35%;
		width: 170%;
		text-align: center;
	}
	#m-list-table2 {
		margin: 10px;
		font-size: 14px;
		border-collapse: collapse;
		cursor:pointer;
		width: 350px;
	}
</style>

</head>
<body>
	<div class="m-appSel-wrap" id="calendarBookmarkModal">
		<div class="m-appSel" id="m-appSel2">
			<div class="m-header">
				<span class="m-header-title" id="header2"></span>
			</div>
			<div class="m-body" style="width:300px;">
				<div class="m-search">
					<select class="s-select" id="s-condition" name="searchCondition">
						<option value="all">전체</option>
						<option value="division">부서</option>
						<option value="memberName">이름</option>
					</select>
					<div class="s-input">
						<input type="text" id="boomark-value" name="searchValue" class="s-text">
						<input type="button" id="btn-search" class="i-search" value="&#xf002;">
					</div>
				</div>
				<div class="m-list" id="m-list2">
					<table id ="bookmark-list-table">
					</table>
				</div>
				<div class="m-select">
					<strong id="s-text2"></strong><br>
					<p id="bookmark-text-list">
				</div>
			</div>
			<div class="m-footer">
				<span class="m-btn confirm" id="confirm-calendarBookmark">확인</span>
				<span class="m-btn cancel" id="cancel-calendarBookmark">취소</span>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
function bookmarkSchedule() {
	$("#header2").html("관심 캘린더 등록");
	$("#s-text2").html("캘린더");
	$("#calendarBookmarkModal").css('display', 'flex').hide().fadeIn();
	$.ajax({
		url : "/modal/member/list.sw",
		type : "get",
		success : function(mList) {
			$("#bookmark-value").val(""); // 검색 입력창 지우기
			bookmarkMemList(mList);
		},
		error : function() {
			alert("사원 목록 조회 실패");
		}
	})
}    
function calendarBookmarkModalClose(){
    $("#calendarBookmarkModal").fadeOut();
}
$("#confirm-calendarBookmark").click(function(){
 	 bookmarkMemView();  
 	 calendarBookmarkModalClose();
});
$("#cancel-calendarBookmark").click(function(){
	 $("#s-list2").val(""); 
	 calendarBookmarkModalClose();
});
//참여자 선택 사원 검색
$("#btn-search2").click(function() {
	var searchCondition = $("#s-condition").val();
	var searchValue = $("#s-value").val(); 
	$.ajax({
		url : "/modal/member/search.sw",
		type : "get",
		data : { "searchCondition" : searchCondition,  "searchValue" : searchValue },
		success : function() {
			bookmarkMemList(mList); 
		},
		error : function() {
			alert("사원 목록 검색 실패");
		}
	})
});
//사원 목록 불러오기
function bookmarkMemList(mList) {
	$("#bookmark-list-table").html(""); // 테이블 값 지우기
	var tr;
	$.each(mList, function(i) {
		tr += '<tr class="tr"><td style="display:none;">' + mList[i].memberNum
		+ '</td><td>' + mList[i].division
		+ '</td><td>' + mList[i].memberName
		+ '</td><td>' + mList[i].rank  + '</td></tr>';
	});
	$("#bookmark-list-table").append(tr);
	
	bookmarkMemSelect(); // 참여자 선택
}
// 선택한 참여자 문서 작성 페이지에 표시
function bookmarkMemView() {
	/* $("#m-bmk").html({mailBmk.bmkSubject}); */
	/* $("#mailRec").val('arrText.join("<br>")'); */
/* 	$("input[name='mailReceiver']").val(arrText.join(" ")) */
}
function bookmarkMemSelect() {
	$("#bookmark-list-table tr").click(function(){
		var trArr = new Object(); // 한 행의 배열을 담을 객체 선언
		var tdArr = new Array(); // 배열 선언(사원번호, 부서, 이름, 직급)
		
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();
					
		// 반복문을 이용해서 배열에 값을 담아 사용 가능
		td.each(function(i){
			tdArr.push(td.eq(i).text());
		});
		
		// td.eq(index)를 통해 값 가져와서 trArr 객체에 넣기
		trArr.memberNum = td.eq(0).text();
		trArr.division = td.eq(1).text();
		trArr.memberName = td.eq(2).text();
		trArr.rank = td.eq(3).text();
		
		// 객체에 데이터가 있는지 여부 판단
		var checkedArrIdx = _.findIndex(Arr, { memberNum : trArr.memberNum }); // 동일한 값 인덱스 찾기
		arrText = []; // 배열 비우기
		if(checkedArrIdx > -1) {
			_.remove(Arr, { memberNum : trArr.memberNum }); // 동일한 값 지우기
		}else {
			Arr.push(trArr);
		} arrText = [];
		Arr.forEach(function(el, index) {
			arrText.push(el.mail);
		});
		$("#bookmark-text-list").html("");
		$("#bookmark-text-list").html(arrText.join("<br>")); // 개행해서 s-list 영역에 출력
	});
}
</script>
</html>--%>