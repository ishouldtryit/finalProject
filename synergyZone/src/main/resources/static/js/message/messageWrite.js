$(function () {
	$(document).ready(function() {
  // URL에서 selectedEmployees 파라미터 값 가져오기
  const urlParams = new URLSearchParams(window.location.search);
  const selectedEmployeesData = urlParams.get('selectedEmployees');
	

  if (selectedEmployeesData) {
    // 데이터가 존재하는 경우 처리 로직 작성
    const selectedEmployees = JSON.parse(selectedEmployeesData);

    // 선택된 직원들에 대한 처리 수행
    for (let i = 0; i < selectedEmployees.length; i++) {
      // selectedEmployees 배열에서 필요한 작업 수행
//       예: makeNewRecipientEle(selectedEmployees[i]);
       makeNewRecipientEle(selectedEmployees[i]);
    }
    // #message-recipient-input에 선택된 직원들의 값을 설정
  }
});


	
  // 쿼리스트링으로 전달받은 대상 처리
  const queryString = new URLSearchParams(location.search);
  const promiseRecipient = queryString.get("recipient");

  // 메세지 입력창
  const recipientInput = $("#message-recipient-input");
  // 내게쓰기 버튼
  const messageToMeBtn = $(".message-to-me-btn");

  // 메세지 발송 대상 있는 경우 처리
 if (promiseRecipient !== null) {
    if (promiseRecipient === empNo) {
      toMeFn();
    } else {
      makeNewRecipientEle(promiseRecipient);
    }
  }

 // 메세지 내게 쓰기
  function toMeFn() {
    // 내게쓰기btn check
    messageToMeBtn.prop("checked", true);
    // 기존 메세지 받는사람 ele 있으면 확인 후 처리
    const recipientEles = $(".message-recipient-ele");
    if (
      recipientEles.length > 0 &&
      !confirm(
        "내게 쓰기시에는 다른 사람에게 쪽지를 보낼 수 없습니다\n내게쓰기 모드로 전환하시겠습니까?"
      )
    ) {
      messageToMeBtn.prop("checked", false);
      return;
    }
    // 기존에 있던 ele들 삭제
    removeRecipientEle();
    // 새로운 recipientEle 생성
    const newMessageRecipientEle = $.parseHTML(
      $("#message-recipient-template").html()
    );
    // recipientEle 이름: 사용자 본인
    const messageRecipientOne = $(newMessageRecipientEle).find(
      "[name=messageRecipient]"
    );
    messageRecipientOne.val(empNo).attr("disabled", "true");
    // 수정 버튼 없애기
    $(newMessageRecipientEle).children().eq(1).remove();
    // 삭제버튼 이벤트 등록
    $(newMessageRecipientEle)
      .children()
      .eq(1)
      .click(function () {
        $(this).parent().remove();
        recipientInput.removeAttr("disabled");
        messageToMeBtn.prop("checked", false);
        countRecipient();
      });
    // 메세지 새로운 받는 사람 추가
    $(newMessageRecipientEle).insertBefore("#message-recipient-input");

    recipientInput.val(empNo).attr("disabled", "true");
    countRecipient();
  }


  // 메세지 수신자 템플릿 생성
  function makeNewRecipientEle(recipientVal) {
    // 메세지 수신자 템플릿 생성
    const newMessageRecipientEle = $.parseHTML(
      $("#message-recipient-template").html()
    );
    const messageRecipientOne = $(newMessageRecipientEle).find(
      "[name=messageRecipient]"
    );

    // 메세지 수신 memberId 설정
    let isExist;
    $.ajax({
      url:contextPath+ "/rest/member/memberId/" + recipientVal,
      method: "get",
      async: false,
      success: function (response) {
        isExist = !(response === "Y");
      },
      error: function () {
        console.log("받는 사람 체크 통신오류!!!!");
      },
    });
    if (!isExist) {
      $(newMessageRecipientEle).removeClass("back-sc-brighter");
      $(newMessageRecipientEle).addClass("back-red-brighter");
      // return;
    }

    // 메세지 받는사람 입력 비우기
    $("#message-recipient-input").val("");
    // 받는사람 기입
    messageRecipientOne.val(recipientVal);

    // 메세지 받는사람 ele 자식(인풋, 수정버튼, 삭제버튼)
    const eleChildren = $(newMessageRecipientEle).children();

    // 메세지 받는사람 ele 수정 버튼 이벤트 등록
    $(newMessageRecipientEle)
      .find(".message-recipient-modify-btn")
      .click(function () {
        eleChildren.hide();
        const newInput = $("<input>")
          .attr("type", "text")
          .addClass("border-0 back-inherit w-70")
          .css("outline", "none")
          .val(messageRecipientOne.val());
        const confirmBtn = $("<i>")
          .addClass("fa-solid fa-check ps-10 recipient-btn")
          .css("color", "forestgreen");
        const cancleBtn = $("<i>")
          .addClass("fa-solid fa-xmark ps-5 recipient-btn")
          .css("color", "orange");

        // 수신인 수정 인풋창에서 탭이나 엔터를 칠 경우 수정버튼 눌리기
        newInput.keydown(function (e) {
          let code = e.keyCode;
          if (code === 13 || code === 9) {
            e.preventDefault();
            $(this).next().click();
          } else if (code === 27) {
            // $(this).next().next().click();
          }
        });
        // 수정 -> 수정 눌렀을 시 색깔 반영, 수정확정, 수정취소 삭제 btn 지우고 원래 내용 show()
        confirmBtn.click(function () {
          const newRecipient = $(newMessageRecipientEle).children().eq(3).val();

          let isExist;
          $.ajax({
            url:contextPath+ "/rest/member/memberId/" + newRecipient,
            method: "get",
            async: false,
            success: function (response) {
              isExist = !(response === "Y");
            },
            error: function () {
              console.log("받는 사람 체크 통신오류!!!!");
            },
          });
          if (!isExist) {
            $(newMessageRecipientEle).removeClass("back-sc-brighter");
            $(newMessageRecipientEle).addClass("back-red-brighter");
          } else {
            $(newMessageRecipientEle).removeClass("back-red-brighter");
            $(newMessageRecipientEle).addClass("back-sc-brighter");
          }

          $(this).parent().children().eq(0).val(newRecipient);
          eleChildren.show();
          $(this).prev().remove();
          $(this).next().remove();
          $(this).remove();
        });
        cancleBtn.click(function () {
          eleChildren.show();
          $(this).prev().prev().remove();
          $(this).prev().remove();
          $(this).remove();
        });

        $(newMessageRecipientEle).append(newInput);
        $(newMessageRecipientEle).append(confirmBtn);
        $(newMessageRecipientEle).append(cancleBtn);

        $(this).parent().children().eq(3).focus();
      });
    // 메세지 받는사람 제거 버튼
    $(newMessageRecipientEle)
      .find(".message-recipient-delete-btn")
      .click(function () {
        $(this).parent().remove();
        countRecipient();
      });

    // 메세지 새로운 받는 사람 추가
    $(newMessageRecipientEle).insertBefore("#message-recipient-input");
    // 받는 사람 숫자 반영
    countRecipient();
  }

  // 메세지 수신자 제거, 수신자 숫자반영
  function removeRecipientEle() {
    $(".message-recipient-ele").remove();
    countRecipient();
  }
  // 내게 쓰기 (체인지 이벤트)
  messageToMeBtn.change(function () {
    if ($(this).prop("checked")) {
      toMeFn();
    } else {
      removeRecipientEle();
      $("[name=messageRecipient]").val("").removeAttr("disabled");
    }
  });
  // 받는 사람 숫자 class적용
  function countRecipient() {
    const recipientEleCnt = $(".message-recipient-ele").length;
    $(".recipient-cnt").text(recipientEleCnt);
    if (recipientEleCnt === 10) {
      $(".recipient-cnt").addClass("red");
    } else {
      $(".recipient-cnt").removeClass("red");
    }
  }

  // 받는사람 추가 (블러 이벤트)
  recipientInput.blur(function () {
    if ($(".message-recipient-ele").length < 10 && $(this).val() !== "") {
      makeNewRecipientEle($(this).val());
    }
  });

  // 받는사람 추가 (키다운 이벤트)
  recipientInput.keydown(function (e) {
    let code = e.keyCode;
    const messageRecipientVal = recipientInput.val();
    const messageRecipientEle = $(".message-recipient-ele");
    if (code === 13 || code === 27) {
      if (code === 13) e.preventDefault();
      // 미입력 시 진행 X
      if (messageRecipientVal === "") return;
      // 최대 10명 제한
      if (messageRecipientEle.length >= 15) {
        alert("쪽지 보내기는 한 번에 최대 15명까지 보낼 수 있습니다");
        return;
      }
      makeNewRecipientEle(messageRecipientVal);
    }
  });
  
  // 메세지 전송 (클릭 이벤트)
  var messageSendForm = $("#message-send-form");
  $("#message-send-btn").click(function (e) {
    e.preventDefault();
    var isLogin =
      messageSendForm.find("input[name='messageSender']").val() != "";
    if (!isLogin) {
      alert("로그인해야 메세지를 보낼 수 있습니다.");
      return;
    }
    const messageRecipient = $("[name=messageRecipient]").val();
    if (messageRecipient == "") {
      alert("쪽지를 받는 사람을 입력해주세요");
      return;
    }
    const messageTitle = $("[name=messageTitle]").val();
    if (messageTitle=="") {
      alert("쪽지 제목을 입력해주세요");
      return;
    } else {
			const titleRegex = /^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ\s]{1,100}$/;
      if(!titleRegex.test(messageTitle)){
        alert("쪽지는 일부의 특수문자, 숫자, 영어 대소문자, 한글로 이루어진 1~100자 이어야 합니다");
        return;
      }
    }
    const isMessageContentNull = $("[name=messageContent]").val() == "";
    if (isMessageContentNull) {
      alert("쪽지 내용을 입력해주세요");
      return;
    }

    // 메세지 보내는 대상자 확인
    let result = true;
    $(".message-recipient-ele").each(function () {
      $.ajax({
        url:contextPath+"/rest/member/memberId/" +
          $(this).find("[name=messageRecipient]").val(),
        method: "get",
        async: false,
        success: function (response) {
          result &&= response === "N";
        },
        error: function () {
          console.log("멤버 확인 통신오류!!!!");
        },
      });
    });
    if (!result) {
      alert("쪽지를 보낼 수 없습니다\n받는 주소를 확인해주세요");
      return;
    }

    // 다수 쪽지 보내기 처리
    const test = [];
    $(".message-recipient-ele").each(function () {
      test.push($(this).find("[name=messageRecipient]").val());
    });
    $.ajax({
      url:contextPath+ "/rest/message/write",
      method: "post",
      data:
        messageSendForm.serialize() +
        "&recipients=" +
        test.join("&recipients="),
      success: function () {
    alert("쪽지를 성공적으로 보냈습니다");
    console.log(messageSendForm.serialize());
    messageSendForm[0].reset();
    removeRecipientEle();
    window.location.href = contextPath + "/message/send";
  },
      error: function () {
        console.log("메세지 전송 통신오류");
      },
    });
  });
});