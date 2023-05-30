//댓글 처리 자바스크립트 파일

$(function(){
	//글 번호를 가져온다
	var params = new URLSearchParams(location.search);
	var noticeReplyOrigin = params.get("noticeNo");
	
	//댓글 목록 불러오기
	loadList();
	
	//.reply-insert-btn을 누르면 작성한 내용을 등록하는 처리 구현
	$(".notice-reply-insert-btn").click(function(){
		var noticeContent = $("[name=noticeReplyContent]").val();//입력값 불러오기
		if(noticeContent.trim().length == 0) return;//의미없는 값 차단
		
		$.ajax({
			url:contextPath+"/rest/noticeReply/",
			method:"post",
			data:{
				noticeReplyOrigin: noticeReplyOrigin,
				noticeReplyContent: noticeContent
			},
			success:function(response){
				loadList();//목록 불러오기
				$("[name=noticeReplyContent]").val("");//입력창 청소
			},
			error:function(){
				alert("통신 오류 발생\n잠시 후 다시 시도하세요");
			}
		});
	});
	
	//목록을 불러오는 함수
	function loadList() {
		$(".notice-reply-list").empty();//대상 영역을 청소
		
		$.ajax({
			url:contextPath+"/rest/noticeReply/"+noticeReplyOrigin,
			method:"get",
			success:function(response){//response == List<ReplyDto>
				//댓글 개수 변경
				$(".notice-reply-count").text(response.length);
			
				//console.log(response);
				for(var i=0; i < response.length; i++) {
					//템플릿 불러와서 세팅하고 추가하는 코드
					var template = $("#notice-reply-template").html();//템플릿 불러와서
					var html = $.parseHTML(template);//사용할 수 있게 변환하고
					
					$(html).find(".noticeReplyWriter").text(response[i].noticeReplyWriter);
					$(html).find(".noticeReplyContent").text(response[i].noticeReplyContent);
					$(html).find(".noticeReplyTime").text(response[i].noticeReplyTime);
					
					//작성자 본인의 댓글에는 태그를 생성해서 추가 표시
					//-> noticeWriter == response[i].noticeReplyWriter
					if(noticeWriter == response[i].noticeReplyWriter) {
						var author = $("<span>").addClass("author ms-10")
															.text("작성자");
						$(html).find(".noticeReplyWriter").append(author);
					}
					
					//내가 쓴 댓글에는 수정/삭제 버튼을 추가 표시
					if(empNo == response[i].noticeReplyWriter) {
						var editButton = $("<i>").addClass("fa-solid fa-edit ms-30")
																.attr("data-notice-reply-no", response[i].noticeReplyNo)
																.attr("data-notice-reply-content", response[i].noticeReplyContent)
																	.click(editNoticeReply);
						var deleteButton = $("<i>").addClass("fa-solid fa-trash ms-10")
																	.attr("data-notice-reply-no", response[i].noticeReplyNo)
																	.click(deleteNoticeReply);
						
						$(html).find(".noticeReplyWriter").append(editButton)
																.append(deleteButton);
					}
					
					$(".notice-reply-list").append(html);//목록 영역에 추가
				}
			},
			error:function(){
				alert("통신 오류 발생");
			}
		});
	}
	
	function deleteNoticeReply() {
		//this == span
		var choice = window.confirm("정말 삭제하시겠습니까?\n삭제 후 복구는 불가능합니다");
		if(choice == false) return;
		
		var noticeReplyNo = $(this).data("notice-reply-no");
		
		$.ajax({
			url:contextPath+"/rest/noticeReply/"+noticeReplyNo,
			method:"delete",
			success:function(response){
				loadList();
			},
			error:function(){
				alert("통신 오류 발생\n잠시 후 다시 실행하세요");
			},
		});
	}
	
	function editNoticeReply() {
		//this == 수정버튼
		//- data-notice-reply-no라는 이름으로 댓글번호가 존재
		//- data-notice-reply-content라는 이름으로 댓글내용이 존재
		var noticeReplyNo = $(this).data("notice-reply-no");
		var noticeReplyContent = $(this).data("notice-reply-content");
		
		//계획
		//- 입력창과 등록버튼, 취소버튼을 생성
		//- 등록버튼을 누르면 비동기통신으로 댓글을 수정 후 목록 갱신
		//- 취소버튼을 누르면 생성한 태그를 삭제
		var textarea = $("<textarea>").addClass("form-input w-100")
														.attr("placeholder", "변경 내용 작성")
														.val(noticeReplyContent);
		var confirmButton = $("<button>").addClass("form-btn positive ms-10")
												.text("수정")
												.click(function(){
													//번호와 내용을 비동기 전송 후 목록 갱신
													$.ajax({
														url:contextPath+"/rest/noticeReply/",
														method:"patch",
														data:{
															noticeReplyNo:noticeReplyNo,
															noticeReplyContent:textarea.val()
														},
														success:function(response){
															loadList();
														},
														error:function(){
															alert("통신 오류 발생\n잠시 후에 시도하세요");
														},
													});
												});
		var cancelButton = $("<button>").addClass("form-btn neutral")
											.text("취소")
											.click(function(){
												$(this).parents(".notice-reply-item").prev(".notice-reply-item").show();
												$(this).parents(".notice-reply-item").remove();
											});	
		var div = $("<div>").addClass("notice-reply-item right");
		
		div.append(textarea).append(cancelButton).append(confirmButton);
		
		$(this).parents(".notice-reply-item").hide().after(div);
	}
});



