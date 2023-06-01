//댓글 처리 자바스크립트 파일

$(function(){
	//글 번호를 가져온다
	var params = new URLSearchParams(location.search);
	var replyOrigin = params.get("boardNo");
	
	//댓글 목록 불러오기
	loadList();
	
	//.reply-insert-btn을 누르면 작성한 내용을 등록하는 처리 구현
	$(".reply-insert-btn").click(function(){
		var content = $("[name=replyContent]").val();//입력값 불러오기
		if(content.trim().length == 0) return;//의미없는 값 차단
		
		$.ajax({
			url:contextPath+"/rest/reply/",
			method:"post",
			data:{
				replyOrigin: replyOrigin,
				replyContent: content
			},
			success:function(response){
				loadList();//목록 불러오기
				$("[name=replyContent]").val("");//입력창 청소
			},
			error:function(){
				alert("통신 오류 발생\n잠시 후 다시 시도하세요");
			}
		});
	});
	
	// 목록을 불러오는 함수 (형석)
		function loadList() {
		  $(".reply-list").empty(); // 대상 영역을 청소
		
		  $.ajax({
		    url: contextPath + "/rest/reply/" + replyOrigin,
		    method: "get",
		    success: function (response) { // response == List<ReplyDto>
		      // 댓글 개수 변경
		      $(".reply-count").text(response.length);
		
		      for (var i = 0; i < response.length; i++) {
		        // 템플릿 불러와서 세팅하고 추가하는 코드
		        var template = $("#reply-template").html(); // 템플릿 불러와서
		        var html = $.parseHTML(template); // 사용할 수 있게 변환하고
		
		        $(html).find(".replyWriter").text(response[i].empName);
		
		        // 프로필 사진 추가
		        var profileImage = $("<img>")
		          .attr("src", getProfileImage(response[i].attachmentNo))
		          .attr("width", "40")
		          .attr("height", "40")
		          .css("border-radius", "50%");
		
		        $(html).find(".profile-image.employee-name").append(profileImage);
		
		        $(html).find(".replyContent").text(response[i].replyContent);
		        $(html).find(".replyTime").text(response[i].replyTime);
		
		        // 작성자 본인의 댓글에는 태그를 생성해서 추가 표시
		        // -> boardWriter == response[i].replyWriter
		        if (boardWriter == response[i].replyWriter) {
		          var author = $("<span>").addClass("author ms-10").text("작성자");
		          $(html).find(".replyWriter").append(author);
		        }
		
		        // 내가 쓴 댓글에는 수정/삭제 버튼을 추가 표시
		        if (empNo == response[i].replyWriter) {
		          var editButton = $("<i>")
		            .addClass("fa-solid fa-edit ms-30")
		            .attr("data-reply-no", response[i].replyNo)
		            .attr("data-reply-content", response[i].replyContent)
		            .click(editReply);
		
		          var deleteButton = $("<i>")
		            .addClass("fa-solid fa-trash ms-10")
		            .attr("data-reply-no", response[i].replyNo)
		            .click(deleteReply);
		
		          $(html)
		            .find(".replyWriter")
		            .append(editButton)
		            .append(deleteButton);
		        }
		
		        $(".reply-list").append(html); // 목록 영역에 추가
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


	
	function deleteReply() {
		//this == span
		var choice = window.confirm("정말 삭제하시겠습니까?\n삭제 후 복구는 불가능합니다");
		if(choice == false) return;
		
		var replyNo = $(this).data("reply-no");
		
		$.ajax({
			url:contextPath+"/rest/reply/"+replyNo,
			method:"delete",
			success:function(response){
				loadList();
			},
			error:function(){
				alert("통신 오류 발생\n잠시 후 다시 실행하세요");
			},
		});
	}
	
	function editReply() {
		//this == 수정버튼
		//- data-reply-no라는 이름으로 댓글번호가 존재
		//- data-reply-content라는 이름으로 댓글내용이 존재
		var replyNo = $(this).data("reply-no");
		var replyContent = $(this).data("reply-content");
		
		//계획
		//- 입력창과 등록버튼, 취소버튼을 생성
		//- 등록버튼을 누르면 비동기통신으로 댓글을 수정 후 목록 갱신
		//- 취소버튼을 누르면 생성한 태그를 삭제
		var textarea = $("<textarea>").addClass("form-input w-100")
														.attr("placeholder", "변경 내용 작성")
														.val(replyContent);
		var confirmButton = $("<button>").addClass("form-btn positive ms-10")
												.text("수정")
												.click(function(){
													//번호와 내용을 비동기 전송 후 목록 갱신
													$.ajax({
														url:contextPath+"/rest/reply/",
														method:"patch",
														data:{
															replyNo:replyNo,
															replyContent:textarea.val()
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
												$(this).parents(".reply-item").prev(".reply-item").show();
												$(this).parents(".reply-item").remove();
											});	
		var div = $("<div>").addClass("reply-item right");
		
		div.append(textarea).append(cancelButton).append(confirmButton);
		
		$(this).parents(".reply-item").hide().after(div);
	}
});



