$(function () {
  $(".message-delete-btn").click(function (e) {
    if (!confirm("정말 삭제하시겠습니까?")) {
      e.preventDefault();
      return;
    }
    $.ajax({
      url:contextPath+ "/rest/message/send",
      method: "put",
      data: { messageNo: messageNo },
      success: function () {
        window.location.href =contextPath+"/message/send";
      },
      error: function () {
        console.log("받은 메세지 삭제 통신 에러!!!!");
      },
    })
    })
    
});