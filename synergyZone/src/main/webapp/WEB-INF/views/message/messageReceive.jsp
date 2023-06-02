<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
</head>
<body>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    var empNo = "${sessionScope.empNo}";
  </script>
  <script src="${pageContext.request.contextPath}/static/js/message/messageReceive.js"></script>
 <script>
    $(function() {
      const queryString = new URLSearchParams(location.search);
      let page = queryString.get("page") == null ? 1 : queryString.get("page");
      let column = queryString.get("column") == null ? "" : queryString.get("column");
      let keyword = queryString.get("keyword") == null ? "" : queryString.get("keyword");
      let mode = queryString.get("mode") == null ? "" : queryString.get("mode");
      let data = {
        page: page,
        column: column,
        keyword: keyword,
        mode: mode
      };

      loadList();

      // 체크박스
      var checkAllEle = $(".message-check-all");
      var checkOneBtn = $(".message-check-one");
      checkAllEle.change(function() {
        $("input[type=checkbox]").prop("checked", $(this).prop("checked"));
      });
      checkOneBtn.change(function() {
        var checkedOneBtn = $(".message-check-one:checked");
        var checkOneCnt = checkOneBtn.length;
        var checkedCnt = checkedOneBtn.length;
        checkAllEle.prop("checked", checkOneCnt == checkedCnt);
      });

      // 메세지 삭제
      $(".message-delete-btn").click(function() {
        var checkedOneBtn = $("input.message-check-one:checked");
        var checkedCnt = checkedOneBtn.length;
        if (checkedCnt == 0) {
          alert("삭제하실 쪽지를 선택하세요");
        } else {
          if (!confirm(checkedCnt + "개의 쪽지를 삭제하시겠습니까?")) {
            return;
          }
          var list = [];
          checkedOneBtn.each(function() {
            list.push(parseInt($(this).val()));
          });
          for (var i = 0; i < list.length; i++) {
            $.ajax({
              url: contextPath + "/rest/message/receive",
              method: "put",
              data: {
                messageNo: list[i]
              },
              success: function() {
                loadList();
              },
              error: function() {},
            });
          }
        }
      });

      // 메세지 새로고침
      $(".message-refresh-btn").click(function() {
        loadList();
        $(".fa-rotate-right").addClass("custom-spin");
        setTimeout(function() {
          $(".fa-rotate-right").removeClass("custom-spin");
        }, 500);
      });

      // 메세지 검색
      $(".message-receive-search-form").submit(function(e) {
        e.preventDefault();
        const messageSearchForm = $(".message-receive-search-form");
        column = messageSearchForm.find("[name=column]").val();
        keyword = messageSearchForm.find("[name=keyword]").val();
        const searchQueryString = new URLSearchParams(location.search);
        mode = searchQueryString.get("mode") == null ? "" : searchQueryString.get("mode");
        page = 1;
        data = {
          page: page,
          column: column,
          keyword: keyword,
          mode: mode
        };
        loadList();
      });

      function loadList() {
        $.ajax({
          url: contextPath + "/rest/message/receive/",
          method: "get",
          data: data,
          success: function(response) {
            var messageList = response.list;
            var sendTimeList = response.sendTimeList;
            const pageVo = response.pageVoList[0];

            $(".target").empty();
            for (let i = 0; i < messageList.length; i++) {
              const message = messageList[i];
              if (mode === "new" && message.messageReadTime != null) {
                continue;
              }
              const sendTime = sendTimeList[i];

              var newReceiveMsgRow = $.parseHTML($("#receive-message-row").html());

              $(newReceiveMsgRow)
                .find("input.message-check-one")
                .val(message.messageNo);
              const messageSender = message.messageSender;
              $(newReceiveMsgRow)
                .find(".message-sender-col")
                .text(
                  message.messageSenderNick +
                  `(${messageSender.length >= 4 ? messageSender.substring(0, 4) + "*".repeat(messageSender.length - 4) : messageSender})`
                )
                .attr("href", "/message/write?recipient=" + message.messageSender);

              $(newReceiveMsgRow)
                .find(".message-title-col")
                .text(message.messageTitle)
                .attr("href", "/message/receive/detail?messageNo=" + message.messageNo);

              const now = new Date();
              const nowYear = now.getFullYear();
              const nowMonth = now.getMonth();
              const nowDay = now.getDate();

              const sendTimeDate = new Date(sendTime);
              const sendYear = sendTimeDate.getFullYear();
              const sendMonth = sendTimeDate.getMonth();
              const sendDay = sendTimeDate.getDate();

              const isToday = nowYear === sendYear && nowMonth === sendMonth && nowDay === sendDay;

              $(newReceiveMsgRow)
                .find(".message-send-time-col")
                .text(isToday ? sendTime.slice(-5) : sendTime)
                .attr("href", "/message/receive/detail?messageNo=" + message.messageNo);

              if (message.messageReadTime != null) {
                $(newReceiveMsgRow).find("a").addClass("gray");
              } else {
                $(newReceiveMsgRow).find("a").addClass("blue");
              }

              $(".target").append(newReceiveMsgRow);
            }

            $(".message-receive-cnt").text(pageVo.count);

            $.ajax({
              url: contextPath + "/rest/message/receive/notReadCount",
              method: "get",
              data: data,
              success: function(response) {
                $(".message-not-read-cnt").text(response);
              },
              error: function() {
                console.log("안 읽은 메세지 count 통신에러 !!!!");
              },
            });

            loadPagination(pageVo);
          },
          error: function() {
            console.log("받은 편지함 테스트 통신오류");
          },
        });
      }

      }
    });
  </script>
  <script id="receive-message-row" type="text/html">
    <tr>
      <td>
        <div class="form-check">
          <input class="form-check-input message-check-one" type="checkbox" value="">
        </div>
      </td>
      <td>
        <a class="message-sender-col" href=""></a>
      </td>
      <td>
        <a class="message-title-col" href=""></a>
      </td>
      <td>
        <a class="message-send-time-col" href=""></a>
      </td>
    </tr>
  </script>
  <!-- aside -->
  <jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>

 <div class="container">
    <div class="message-header">
      <h5>받은 쪽지함
        <a class="message-count" href="${pageContext.request.contextPath}/message/receive?mode=new">(${notReadCnt})</a>
      </h5>
      <div class="message-options">
        <div class="message-delete-btn" title="삭제">
          <i class="fa-solid fa-xmark"></i>
        </div>
        <div class="message-refresh-btn" title="새로고침">
          <i class="fa-solid fa-rotate-right"></i>
        </div>
      </div>
    </div>
    <div class="table-responsive">
      <table class="table table-striped">
        <thead>
          <tr>
            <th scope="col">
              <div class="form-check">
                <input class="form-check-input message-check-all" type="checkbox">
              </div>
            </th>
            <th scope="col">보낸사람</th>
            <th scope="col">제목</th>
            <th scope="col">날짜</th>
          </tr>
        </thead>
        <tbody class="target">
          <!-- 여기에 서버에서 받은 데이터로 테이블 내용을 동적으로 추가합니다. -->
        </tbody>
      </table>
    </div>
  
  <!-- 페이지네이션 -->
  <div class="mt-3 center pagination"></div>
  
  <!-- 검색창 -->
 <div class="row center">
  <form class="message-receive-search-form" action="/message/receive" method="get" autocomplete="off">
      <div class="input-group">
        <select name="column" class="form-select">
          <option class="column-option" value="message_title">제목</option>
          <option class="column-option" value="message_sender_nick">닉네임</option>
          <option class="column-option" value="message_sender">아이디</option>
          <option class="column-option" value="message_content">내용</option>
        </select>
        <input name="keyword" class="form-control search-input" value="${param.keyword}" placeholder="검색" />
        <input name="item" type="hidden" value="${param.item}" />
        <input name="order" type="hidden" value="${param.order}" />
        <input name="special" type="hidden" value="${param.special}" />
        <button class="btn btn-primary">검색</button>
      </div>
    </form>
	</div>


</div>


</body>

</html>
