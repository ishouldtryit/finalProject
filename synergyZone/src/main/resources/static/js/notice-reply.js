//댓글 처리 자바스크립트 파일

$(function(){
	//글 번호를 가져온다
	var params = new URLSearchParams(location.search);
	var noticeReplyOrigin = params.get("noticeNo");
	
	//댓글 목록 불러오기
	loadList();
	
	//.noticeReply-insert-btn을 누르면 작성한 내용을 등록하는 처리 구현
	$(".noticeReply-insert-btn").click(function(){
		var content = $("[name=noticeReplyContent]").val();//입력값 불러오기
		if(content.trim().length == 0) return;//의미없는 값 차단
		
		$.ajax({
			url:contextPath+"/rest/noticeReply/",
			method:"post",
			data:{
				noticeReplyOrigin: noticeReplyOrigin,
				noticeReplyContent: content
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
	
	// 목록을 불러오는 함수 (형석)
		function loadList() {
		  $(".noticeReply-list").empty(); // 대상 영역을 청소
		
		  $.ajax({
		    url: contextPath + "/rest/noticeReply/" + noticeReplyOrigin,
		    method: "get",
		    success: function (response) { // response == List<ReplyDto>
		      // 댓글 개수 변경
		      $(".noticeReply-count").text(response.length);
		
		      for (var i = 0; i < response.length; i++) {
		        // 템플릿 불러와서 세팅하고 추가하는 코드
		        var template = $("#noticeReply-template").html(); // 템플릿 불러와서
		        var html = $.parseHTML(template); // 사용할 수 있게 변환하고
		
		        $(html).find(".noticeReplyWriter").text(response[i].empName + " " + response[i].jobName);
		
		        // 프로필 사진 추가
		        var profileImage = $("<img>")
		          .attr("src", getProfileImage(response[i].attachmentNo))
		          .attr("width", "32")
		          .attr("height", "32")
		          .css("border-radius", "50%");
		
		        $(html).find(".profile-image.employee-name").append(profileImage);
		
		        $(html).find(".noticeReplyContent").text(response[i].noticeReplyContent);
		        $(html).find(".noticeReplyTime").text(response[i].noticeReplyTime);
		
		        // 작성자 본인의 댓글에는 태그를 생성해서 추가 표시
		        // -> noticeWriter == response[i].noticeReplyWriter
		        if (noticeWriter == response[i].noticeReplyWriter) {
		          var author = $("<span>").addClass("author ms-2 rounded-pill badge bg-info").text("작성자");
		          $(html).find(".noticeReplyWriter").append(author);
		        }
		
		        // 내가 쓴 댓글에는 수정/삭제 버튼을 추가 표시
		        if (empNo == response[i].noticeReplyWriter) {
		          var editButton = $("<i>")
		            .addClass("fa-solid fa-edit ms-2")
		            .attr("data-noticeReply-no", response[i].noticeReplyNo)
		            .attr("data-noticeReply-content", response[i].noticeReplyContent)
		            .click(editNoticeReply);
		
		          var deleteButton = $("<i>")
		            .addClass("fa-solid fa-trash ms-1")
		            .attr("data-noticeReply-no", response[i].noticeReplyNo)
		            .click(deleteNoticeReply);
		
		          $(html)
		            .find(".noticeReplyWriter")
		            .append(editButton)
		            .append(deleteButton);
		        }
		
		        $(".noticeReply-list").append(html); // 목록 영역에 추가
		      }
		    },
		    error: function () {
		      alert("통신 오류 발생");
		    },
		  });
		}

		// 프로필 사진 URL 가져오기(형석)
		function getProfileImage(attachmentNo) {
		  if (attachmentNo > 0) {
		    return "/attachment/download?attachmentNo=" + attachmentNo;
		  } else {
		    return "https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg";
		  }
		}


	
	function deleteNoticeReply() {
		//this == span
		var choice = window.confirm("정말 삭제하시겠습니까?\n삭제 후 복구는 불가능합니다");
		if(choice == false) return;
		
		var noticeReplyNo = $(this).data("noticeReply-no");
		
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
		//- data-noticeReply-no라는 이름으로 댓글번호가 존재
		//- data-noticeReply-content라는 이름으로 댓글내용이 존재
		var noticeReplyNo = $(this).data("noticeReply-no");
		var noticeReplyContent = $(this).data("noticeReply-content");
		
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
												$(this).parents(".noticeReply-item").prev(".noticeReply-item").show();
												$(this).parents(".noticeReply-item").remove();
											});	
		var div = $("<div>").addClass("noticeReply-item right");
		
		div.append(textarea).append(cancelButton).append(confirmButton);
		
		$(this).parents(".noticeReply-item").hide().after(div);
	}
});



