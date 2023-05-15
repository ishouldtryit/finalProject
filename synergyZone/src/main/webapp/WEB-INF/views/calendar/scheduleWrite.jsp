<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	.m-appSel2 {
		    margin-right:5%;
		    padding-bottom: 2%;
		     padding-right: 3%;
	}
	.m-body2 {
			height: 60%;
		    width: 80%;
	}
	
	.m-list2 {
		height: 35%;
		 width: 100%;
		 
	}
	#m-list-table2 {
		margin: 10px;
		font-size: 14px;
		border-collapse: collapse;
		cursor:pointer;
	}
	#header2 {
		margin-left: 10%;
		
	}
</style>
</head>
<body>
	 <div class="m-appSel-wrap" id="schModal">
		<div class="m-appSel">
			<div class="m-header">
				<span class="m-header-title" id="header2"></span>
			</div>
			<div class="m-body">
				<div class="m-search">
					<select class="s-select" id="s-condition" name="searchCondition">
						<option value="all">전체</option>
						<option value="division">부서</option>
						<option value="memberName">이름</option>
					</select>
					<div class="s-input">
						<input type="text" id="s-value2" name="searchValue" class="s-text">
						<input type="button" id="btn-search" class="i-search" value="&#xf002;">
					</div>
				</div>
				<div class="m-list2">
					<table id="m-list-table2">
					</table>
				</div>
				<div class="m-select">
					<strong id="s-text2"></strong><br>
					<p id="s-list2">
				</div>
			</div>
			<div class="m-footer">
				<span class="m-btn confirm" id="confirm2">확인</span>
				<span class="m-btn cancel" id="cancel2">취소</span>
			</div>
		</div>
	</div>
</body>
</html>