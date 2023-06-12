<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/message/messageWrite.js"></script>
<script>
    const empNo = "${sessionScope.empNo}";
    var messageToMeBtn = $(".message-to-me-btn");

</script>
<script type="text/template" id="message-recipient-template">
    <div class="message-recipient-ele flex-all-center inline-flex back-sc-brighter radius-1em ph-h-em">
        <input class="border-0 back-inherit w-70" name="messageRecipient" type="text" disabled/>
        <i class="recipient-btn message-recipient-modify-btn fa-solid fa-pen ps-10" style="color: gray"></i>
        <i class="recipient-btn message-recipient-delete-btn fa-solid fa-xmark ps-5" style="color: red"></i>
    </div>
</script>
<style>
    /* 전체 컨테이너 스타일 */
    .container {
        max-width: 1300px; 
        margin: 0 auto;
        padding: 40px;
        background-color: white;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    /* 타이틀 스타일 */
    h1 {
        font-size: 24px;
        margin-bottom: 30px;
        text-align: center;
    }

    /* 입력 필드 레이블 스타일 */
    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    /* 입력 필드 스타일 */
    .form-input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-bottom: 10px;
        margin-top: 10px;
        
    }

    /* 입력 필드 텍스트영역 스타일 */
    textarea.form-input {
        height: 150px;
    }

    /* 버튼 스타일 */
    .form-btn {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        color: #fff;
        cursor: pointer;
        font-weight: bold;
        text-align: center;
    }

    /* 보내기 버튼 스타일 */
    .positive {
        background-color: #4a90e2; 
    }

    /* 수신자 카운트 스타일 */
    .recipient-cnt {
        font-weight: bold;
    }

    /* 체크박스 레이블 스타일 */
    label[for="message-recipient-input"] {
        font-size: 14px;
    }

    /* 내게쓰기 체크박스 스타일 */
    .message-to-me-btn {
        margin-right: 5px;
        vertical-align: middle;
    }

    /* 가로 정렬을 위한 Flex 스타일 */
    .flex {
        display: flex;
    }

    /* 줄 구분 스타일 */
    .hr-sc {
        border: none;
        border-top: 1px solid #ccc;
        margin: 20px 0;
    }
</style>


<jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col">
            <div class="mb-30">
                <h1>
                    <img src="/static/img/messageIcon.png" alt="Message Icon" class="message-icon" width="200" height="200">
                </h1>
            </div>
            <form id="message-send-form" action="write" method="post">
                <input type="hidden" name="messageSender" value="${sessionScope.empNo}">
                <div class="row">
		    <div class="col">
		        <label for="message-recipient-input">
		            받는사람 (<span class="recipient-cnt">0</span>/10)
		        </label>
		        <label style="font-size: 13px; display: flex; align-items: center; margin-top: 5px;">
		            <input class="message-to-me-btn" type="checkbox" style="margin-right: 5px;">
		            내게쓰기
		        </label>
		    </div>
		</div>

                <div class="row">
                    <div class="col">
                        <input id="message-recipient-input" class="form-input" type="text" name="messageRecipient" placeholder="받는 사람의 사번을 입력해주세요" required>
                    </div>
                </div>
                <hr class="hr-sc"/>
                <div class="row">
                    <div class="col">
                        <label>
                            제목
                            <input class="form-input" type="text" name="messageTitle" placeholder="제목을 입력해주세요" required>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <label>
                            내용
                            <textarea class="form-input" type="text" name="messageContent" placeholder="내용을 입력해주세요" required></textarea>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <button id="message-send-btn" class="form-btn positive">보내기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
$(document).ready(function() {
	  var selectedEmployees = localStorage.getItem('selectedEmployees');
	  console.log(selectedEmployees);

	  if (selectedEmployees && selectedEmployees !== '[""]') {
	    selectedEmployees = JSON.parse(selectedEmployees);

	    // 숫자만 추출하여 새로운 배열 생성
	    var employeeNumbers = selectedEmployees.filter(function(item) {
	      return /^\d+$/.test(item);
	    });

	    var recipientInput = $('#message-recipient-input');
	    var recipientCnt = $('.recipient-cnt');
	    var currentIndex = 0; // 현재 입력 중인 직원 인덱스

	    // 첫 번째 직원 입력 처리
// 	    recipientInput.val("");
// 	    recipientCnt.text(1);


	function countRecipient() {
    let recipientEleCnt = $("[name=messageRecipient]").length;
    console.log("뭐함?")
    $(".recipient-cnt").text(recipientEleCnt-1);
    if (recipientEleCnt === 10) {
      $(".recipient-cnt").addClass("red");
    } else {
      $(".recipient-cnt").removeClass("red");
    }
  }
	    // 엔터키 입력 시 다음 직원 입력 처리
	    recipientInput.on('keydown', function(e) {
	      if (e.which === 13) { // 엔터키 입력 확인
	        e.preventDefault(); // 기본 엔터키 동작 방지
	        currentIndex++; // 다음 직원 인덱스로 이동

	        if (currentIndex < employeeNumbers.length) {
	          recipientInput.val(employeeNumbers[currentIndex]);
	        } else {
	          recipientInput.val(''); // 마지막 직원 입력 후 입력란 비우기
	          localStorage.removeItem('selectedEmployees'); // 선택된 직원 목록 초기화
	        }
	          countRecipient();
	      }
	    });
	  }
	});


</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
