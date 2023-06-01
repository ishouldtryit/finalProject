//[1] 시작하자마자 이 글에 좋아요를 한 적이 있는지 확인
//- 글번호를 어떻게 알지?
//- 글번호는 noticeDto에 있는데... noticeDto는 EL로 접근가능
//- EL로 접근 가능하다는 것은 서버에서 쓰는 데이터란 뜻
//- 필요한 곳은 자바스크립트(클라이언트 언어)
//- 개발하다보면 자바스크립트와 EL/JSTL이 섞일 때가 있다
//- 무조건 안하는 방향으로 선택하는 것이 좋다
//- 정말 어쩔 수 없는 경우(ex : 로그인 한 사용자 아이디) 제외

//[2] 하트를 클릭하면 좋아요 설정/해제 페이지로 비동기 요청
//[3] 하트에 마우스가 들어가거나 나오면 이벤트 처리로 애니메이션 부여
//[4] 좋아요가 눌릴 경우에도 애니메이션 부여
$(function(){

	//Javascript에서 파라미터 읽기
	var params = new URLSearchParams(location.search);
	var noticeNo = params.get("noticeNo");
	
	//[1]
	$.ajax({
		url:contextPath+"/rest/notice/check",
		method:"post",
		data:{
			noticeNo : noticeNo
		},
		success:function(response){
			//console.log(response);
			//console.log(typeof response);
			if(response) {
				$(".fa-heart").addClass("fa-solid");
			}
			else {
				$(".fa-heart").addClass("fa-regular");
			}
		},
		error:function(){
			$(".fa-heart").remove();
		}
	});
	
	//[2]
	$(".fa-heart").click(function(){
		$.ajax({
			url:contextPath+"/rest/notice/like",
			method:"post",
			data:{
				noticeNo:noticeNo
			},
			success:function(response){
				//response에는 result와 count가 들어있다
				if(response.result) {//좋아요 된것
					$(".fa-heart").removeClass("fa-solid fa-regular")
										.addClass("fa-solid fa-shake");
					//1초뒤에 .fa-shake를 제거(setTimeout 함수)
					//- setTimeout(함수, 시간); 지정한 시간 이후에 함수 실행
					//- setInterval(함수, 시간); 지정한 시간 간격으로 함수 실행
					setTimeout(function(){
						$(".fa-heart").removeClass("fa-shake");
					}, 800);
				
					$(".heart-count").text(response.count);
				}
				else {//좋아요 풀린것
					$(".fa-heart").removeClass("fa-solid fa-regular")
										.addClass("fa-regular");
					$(".heart-count").text(response.count);
				}
			},
			error:function(){}
		});
	});
	
	//[3] mouseenter/mouseleave
	$(".fa-heart").mouseenter(function(){
		$(this).addClass("fa-beat");
	})
	.mouseleave(function(){
		$(this).removeClass("fa-beat");
	});
	
});