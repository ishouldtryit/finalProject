$(function () {
  const queryString = new URLSearchParams(location.search);
  let page = queryString.get("page") == null ? 1 : queryString.get("page");
  let column =
    queryString.get("column") == null ? "" : queryString.get("column");
  let keyword =
    queryString.get("keyword") == null ? "" : queryString.get("keyword");
  let data = { page: page, column: column, keyword: keyword };

  loadList();

  // 1. 체크박스
  // 메세지 모두 선택 체크박스
  var checkAllEle = $(".message-check-all");
  // 메세지 개별 선택 체크박스
  var checkOneBtn = $(".message-check-one");
  // 메세지 check-all과 모든 버튼 동기화
  checkAllEle.change(function () {
    $("input[type=checkbox]").prop("checked", $(this).prop("checked"));
  });

  // 메세지 개별 버튼과 check-all 동기화
  checkOneBtn.change(function () {
    var checkedOneBtn = $(".message-check-one:checked");
    var checkOneCnt = checkOneBtn.length;
    var checkedCnt = checkedOneBtn.length;
    checkAllEle.prop("checked", checkOneCnt == checkedCnt);
    // 첫번 째 다 눌리면 check-all도 체크
  });

  // 2. 메세지 삭제
  $(".message-delete-btn").click(function () {
    var checkedOneBtn = $("input.message-check-one:checked");
    var checkedCnt = checkedOneBtn.length;
    if (checkedCnt == 0) {
      alert("삭제하실 쪽지를 선택하세요");
    } else {
      // 확인
      if (!confirm(checkedCnt + "개의 쪽지를 삭제하시겠습니까?")) {
        return;
      }
      // 체크 된 메세지의 messageNo를 list에 저장
      var list = [];
      checkedOneBtn.each(function () {
        list.push(parseInt($(this).val()));
      });
      // for문으로 delete 실행
      for (var i = 0; i < list.length; i++) {
        $.ajax({
          url:contextPath+ "/rest/message/send",
          method: "put",
          data: { messageNo: list[i] },
          success: function () {
            loadList();
          },
          error: function () {},
        });
      }
    }
  });

  // 3. 메세지 새로고침
  $(".message-refresh-btn").click(function () {
    loadList();
    $(".fa-rotate-right").addClass("custom-spin");
    setTimeout(function () {
      $(".fa-rotate-right").removeClass("custom-spin");
    }, 500);
  });

  // 4. 메세지 검색
  $(".message-send-search-form").submit(function (e) {
    e.preventDefault();
    const messageSearchForm = $(".message-send-search-form");
    column = messageSearchForm.find("[name=column]").val();
    keyword = messageSearchForm.find("[name=keyword]").val();
    const searchQueryString = new URLSearchParams(location.search);
    page = 1;
    data = { page: page, column: column, keyword: keyword };
    loadList();
  });

  // 메세지 비동기 load
  function loadList() {
    $.ajax({
      url:contextPath+ "/rest/message/send",
      method: "get",
      data: data,
      success: function (response) {
        var messageList = response.list;
        var sendTimeList = response.sendTimeList;
        var readTimeList = response.readTimeList;
        const pageVo = response.pageVoList[0];
        // target 비우고 다시 로드
        $(".target").empty();
        for (var i = 0; i < messageList.length; i++) {
          const message = messageList[i];
          const sendTime = sendTimeList[i];
          const readTime = readTimeList[i];
          const newReceiveMsgRow = $.parseHTML($("#send-message-row").html());

          // 체크박스의에 PK(messageNo) 설정
          $(newReceiveMsgRow)
            .find("input.message-check-one")
            .val(message.messageNo);
          // 메세지 받은사람
          const messageRecipient = message.messageRecipient;
          $(newReceiveMsgRow)
            .find(".message-recipient-col")
            .text(
              message.messageRecipientNick +
                `(${
                  messageRecipient.length >= 4
                    ? messageRecipient.substring(0, 4) +
                      "*".repeat(messageRecipient.length - 4)
                    : messageRecipient
                })`
              //   message.messageRecipient
            )
            .attr(
              "href",
              "/message/write?recipient=" + message.messageRecipient
            );
          // 메세지 제목
          $(newReceiveMsgRow)
            .find(".message-title-col")
            .text(message.messageTitle)
            .attr(
              "href",
              "/message/send/detail?messageNo=" + message.messageNo
            );

          // 현재시간 연월일 추출
          const now = new Date();
          const nowYear = now.getFullYear();
          const nowMonth = now.getMonth();
          const nowDay = now.getDate();

          // 보낸시간 연월일 추출
          const sendTimeDate = new Date(sendTime);
          const sendYear = sendTimeDate.getFullYear();
          const sendMonth = sendTimeDate.getMonth();
          const sendDay = sendTimeDate.getDate();

          // 읽은시간 연월일 추출
          const readTimeDate = new Date(readTime);
          const readYear = readTimeDate.getFullYear();
          const readMonth = readTimeDate.getMonth();
          const readDay = readTimeDate.getDate();

          const sendToday =
            nowYear === sendYear &&
            nowMonth === sendMonth &&
            nowDay === sendDay;
          const readToday =
            nowYear === readYear &&
            nowMonth === readMonth &&
            nowDay === readDay;

          // 메세지 보낸 시간
          $(newReceiveMsgRow)
            .find(".message-send-time-col")
            .text(sendToday ? sendTime.slice(-5) : sendTime)
            .attr(
              "href",
              "/message/send/detail?messageNo=" + message.messageNo
            );

          // 메세지 읽은 시간
          if (readTimeList[i] == null) {
            $(newReceiveMsgRow)
              .find(".message-read-time-col")
              .text("읽지않음")
              .attr(
                "href",
                "/message/send/detail?messageNo=" + message.messageNo
              )
              .css("font-weight", "bold");
          } else {
            $(newReceiveMsgRow)
              .find(".message-read-time-col")
              .text(readToday ? readTime.slice(-5) : readTime)
              .attr(
                "href",
                "/message/send/detail?messageNo=" + message.messageNo
              );
          }

          // 발송취소
          $(newReceiveMsgRow)
            .find(".message-send-cancle-btn")
            .text(readTimeList[i] == null ? "발송취소" : "")
            .css("text-decoration", "underline")
            .click(function () {
              console.log("message.messageNo: " + message.messageNo);
              if (
                confirm(
                  message.messageRecipient +
                    "님에게 보낸 쪽지를 발송취소 하시겠습니까?\n"
                )
              ) {
                $.ajax({
                  url:contextPath+ "/rest/message/" + message.messageNo,
                  method: "delete",
                  success: function () {
                    loadList();
                  },
                  error: function () {
                    console.log("메세지 발송취소 통신에러!!!!");
                  },
                });
              }
            });

          $(".target").append(newReceiveMsgRow);
        }

        // h1태그 옆 숫자 반영
        // 받은 메세지 전체 숫자
        $(".message-send-cnt").text(pageVo.count);

        // 비동기 페이지네이션
        loadPagination(pageVo);
      },
      error: function () {
        console.log("메세지 비동기 list 통신에러!!!!!");
      },
    });
  }

  // 새로고침 비동기 로드
  $(".message-refresh-btn").click(function () {
    loadList();
    $(".fa-rotate-right").addClass("custom-spin");
    setTimeout(function () {
      $(".fa-rotate-right").removeClass("custom-spin");
    }, 500);
  });

  function loadPagination(pageVo) {
    const paginationContainer = $(".pagination");
    paginationContainer.empty();
    // 비동기 페이지네이션 추가
    // <<
    if (pageVo.first) {
      paginationContainer.append(
        $("<a>")
          .addClass("disabled")
          .append($("<i>").addClass("fa-solid fa-angles-left"))
      );
    } else {
      paginationContainer.append(
        $("<a>")
          .attr(
            "href",
            `/message/send?${pageVo.parameter}&page=1&${pageVo.addParameter}`
          )
          .append($("<i>").addClass("fa-solid fa-angles-left"))
      );
    }
    // <
    if (pageVo.prev) {
      paginationContainer.append(
        $("<a>")
          .attr(
            "href",
            `/message/send?${pageVo.parameter}&page=${pageVo.prevPage}&${pageVo.addParameter}`
          )
          .append($("<i>").addClass("fa-solid fa-angle-left"))
      );
    } else {
      paginationContainer.append(
        $("<a>")
          .addClass("disabled")
          .append($("<i>").addClass("fa-solid fa-angle-left disabled"))
      );
    }
    // 숫자
    for (let i = pageVo.startBlock; i <= pageVo.finishBlock; i++) {
      if (pageVo.page === i) {
        paginationContainer.append(
          $("<a>").addClass("on disabled").text(`${i}`)
        );
      } else {
        paginationContainer.append(
          $("<a>")
            .attr(
              "href",
              `/message/send?${pageVo.parameter}&page=${i}&${pageVo.addParameter}`
            )
            .text(`${i}`)
        );
      }
    }
    // >
    if (pageVo.next) {
      paginationContainer.append(
        $("<a>")
          .attr(
            "href",
            `/message/send?${pageVo.parameter}&page=${pageVo.nextPage}&${pageVo.addParameter}`
          )
          .append($("<i>").addClass("fa-solid fa-angle-right"))
      );
    } else {
      paginationContainer.append(
        $("<a>")
          .addClass("disabled")
          .append($("<i>").addClass("fa-solid fa-angle-right"))
      );
    }
    // >>
    if (pageVo.last) {
      paginationContainer.append(
        $("<a>")
          .addClass("disabled")
          .append($("<i>").addClass("fa-solid fa-angles-right"))
      );
    } else {
      paginationContainer.append(
        $("<a>")
          .attr(
            "href",
            `/message/send?${pageVo.parameter}&page=${pageVo.totalPage}&${pageVo.addParameter}`
          )
          .append($("<i>").addClass("fa-solid fa-angles-right"))
      );
    }
  }

  // option 선택
  $(".column-option").each(function () {
    if (column === $(this).val()) {
      $(this).attr("selected", "selected");
    }
  });
});