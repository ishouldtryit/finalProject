$(function(){
    $.ajax({
      url: contextPath+"/rest/message/receive/notReadCount",
      method: "get",
      success: function(response){
        // console.log(response);
        if(response > 0) {
          console.log($(".header-message").eq(0).text());
          $(".header-message").text($(".header-message").text()+"("+response+")");
        }
      },
      error: function(){
        console.log("안 읽은 메세지 통신오류!!!!");
      }
    })
  })