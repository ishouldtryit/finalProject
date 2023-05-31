<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.message {
		border:1px solid gray;
		padding:10px;
	}
</style>

<h1>채널 예제 6번(채널을 선택하여 입장)</h1>
<h2>${sessionScope.empNo}, ${sessionScope.empName}</h2>

<hr>

<!-- 메세지 입력창+전송버튼 -->
<input type="text" class="user-input">
<button class="btn-send">전송</button>

<hr>

<!-- 메세지가 표시될 공간 -->
<div class="message-wrapper"></div>


<!-- 
	SockJS를 사용하려면 sockjs-client 라이브러리의 의존성을 추가해야 한다
	[1] 주소를 http로 써도 된다(알아서 ws로 바꿔준다)
	[2] WebSocket을 지원하지 않는 브라우저는 풀링 방식으로 자동 변환한다
	[3] 주기적으로 생존여부를 체크해준다(heartbeat)
-->
<script type="text/template" id="message-template">
<div class="message">
	<h2 class="empNo">보낸사람</h2>
	<p class="content">내용</p>
	<span class="time">HH:mm</span>
</div>
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function(){
		//메세지 호출
		loadMessage();
		
		
		//코드정상
		function loadMessage() {
			// roomName 파라미터 받아서
			const roomName = new URLSearchParams(location.search).get("room");
			//비동기호출
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/message/"+roomName,
				method:"get",
				success:function(resp){
					//resp에 있는 목록의 모든 메세지를 화면에 추가
					displayMessageList(resp);
					//웹소켓 연결
					connectWebSocket();
				},
			});
		}
		
		//
		function displayMessageList(resp){
			for(let i=0; i < resp.length; i++) {
				//수신한 데이터(e.data)가 JSON 문자열 형태이므로 해석 후 처리
				const data = JSON.parse(resp[i].messageBody);
				const time = moment(data.time).format("HH:mm");
				//const time = moment(data.time).fromNow();
				
				var template = $("#message-template").html();
				var html = $.parseHTML(template);
				$(html).find(".empNo").text(data.empNo);
				$(html).find(".content").text(data.content);
				$(html).find(".time").text(time);
				
				
				/*
				switch(data.memberLevel) {
				case "우수회원": 
					$(html).find(".empNo").css("color", "dodgerblue"); 
					break;
				case "관리자":
					$(html).find(".empNo").css("color", "firebrick");
					break;
				}
				
				*/
				
				
				$(".message-wrapper").append(html);
			}
		}
		
		function connectWebSocket(){
			changeToDisconnect();
			
			//시작하자마자 연결
				
			//SockJS를 사용하여 달라지는 부분(주소, 연결생성)
			const url = "${pageContext.request.contextPath}/ws/chat";
			window.socket = new SockJS(url);
			
			//실제로 연결이 됐는지, 끊어졌는지 알 방법이 없다
			//- 웹소켓에서 이벤트 형태로 제공한다(callback)
			//- 지금 현재 서버의 대기실에 위치하고 있으므로 방 번호를 알려줘서 이동 처리
			window.socket.onopen = function(){
				//파라미터 중에서 room이라는 항목을 읽어서 첨부하여 전송
				//const data = {type : 2, room : "${param.room}"};
				
				const room = new URLSearchParams(location.search).get("room");
				const data = {type : 2, room : room};
				window.socket.send(JSON.stringify(data));
				
				changeToConnect();
				$("<p>").text("서버에 연결되었습니다")
							.appendTo(".message-wrapper");
			};
			window.socket.onclose = function(){
				changeToDisconnect();
				$("<p>").text("서버와의 연결이 종료되었습니다")
							.appendTo(".message-wrapper");
			};
			window.socket.onerror = function(){
				changeToDisconnect();
				$("<p>").text("서버와의 연결 오류가 발생했습니다")
							.appendTo(".message-wrapper");
			};
			
			
			//메세지를 수신하면 수신된 메세지로 태그를 만들어서 추가
			//메세지 추가기능
			window.socket.onmessage = function(e){
				//수신한 데이터(e.data)가 JSON 문자열 형태이므로 해석 후 처리
				const data = JSON.parse(e.data);
				const time = moment(data.time).format("HH:mm");
				//const time = moment(data.time).fromNow();
				
				var template = $("#message-template").html();
				var html = $.parseHTML(template);
				$(html).find(".empNo").text(data.empNo);
				$(html).find(".content").text(data.content);
				$(html).find(".time").text(time);
				
				/*
				해당기능은 관리 레벨에 따라 색표시기능
				switch(data.memberLevel) {
				case "우수회원": 
					$(html).find(".empNo").css("color", "dodgerblue"); 
					break;
				case "관리자":
					$(html).find(".empNo").css("color", "firebrick");
					break;
				}
				*/
				
				$(".message-wrapper").append(html);
			};
				
			
			//페이지 나가면 종료이므로 처리하지 않음
			
			//전송 버튼을 누르면 서버에게 메세지를 전송하도록 구현
			$(".btn-send").click(function(){
				const text = $(".user-input").val();
				if(text.length == 0) return;
				
				//window.socket.send(text); //일반 텍스트
				
				//<자바스크립트에서 JSON을 처리하는 명령>
				//JSON.stringify(객체) ---> 객체를 JSON 문자열로 변환
				//JSON.parse(JSON문자열) ---> JSON 문자열을 객체로 변환
				const data = {type:1, content:text};
				window.socket.send(JSON.stringify(data));
				
				$(".user-input").val("");//입력창 초기화
			});
			
			//연결 상태일 때의 화면을 만드는 함수
			function changeToConnect(){
				$(".user-input").prop("disabled", false);
				$(".btn-send").prop("disabled", false);
			}
			
			//종료 상태일 때의 화면을 만드는 함수
			function changeToDisconnect(){
				$(".user-input").prop("disabled", true);
				$(".btn-send").prop("disabled", true);
			}
		}
		
		
		
		
	});
</script>









