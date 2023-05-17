<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 캘린더 등록</title>
<link href="/static/css/appModal-style.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
<style type="text/css">
.m-footer {
		width:100%;
		height:80px;
		display:flex;
		justify-content:center;
	}
.s-input {
		width: 89%;
		float: left;
	}
	.s-text {
		width: 100%;
	}
	.m-list {
		height: 35%;
		 width: 100%;
		 
	}
	.g-text {
		display: inline-flex;
		height: 30px;
		width: 200px;
		border-radius: 4px;
		border: solid 1px rgb(190, 190, 190);
	}

</style>
</head>
<body>
	 <div class="m-appSel-wrap" id="myCalModal">
		<div class="m-appSel" id="appSel">
			<div class="m-header">
				<span class="m-header-title" id="header"></span>
			</div>
			<div class="m-body" style="width: 300px;">
				<div class="m-tit" >
					<strong id="g-text"></strong> &nbsp;&nbsp;<input type="text" id="calName" name="calName" class="g-text">
				</div>
				<br>
			</div>
			<div class="m-footer">
				<span class="m-btn confirm" id="cal-confirm">등록</span>
				<span class="m-btn cancel" id="cal-cancel">취소</span>
			</div>
		</div>
	</div>
	
</body>
<script type="text/javascript">
function myCalendar() {
	$("#myCalModal").css('display', 'flex').hide().fadeIn();
	$("#header").html("내 캘린더 등록");
	$("#g-text").html("캘린더 이름");
	
}

$("#cal-confirm").click(function(){
	 var calName = $("#calName").val(); 
	 $.ajax({
		url : "/calendar/calRegister",
		type : "post",
		data : {
			"calName" : calName
		},
		success : function(data) {
			$("#myCalModal").fadeOut();
			refreshList();
		},
		error : function() {
			alert("내캘린더 등록 실패");
		}
	}) 
	;
   
});
$("#cal-cancel").click(function(){
	 $("#myCalModal").fadeOut(); 
});
</script>
</html>