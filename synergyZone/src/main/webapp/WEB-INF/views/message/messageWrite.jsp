<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/message/messageWrite.js"></script>
<script>
    const memberId = "${sessionScope.memberId}";
</script>
<script type="text/template" id="message-recipient-template">
    <div class="message-recipient-ele flex-all-center inline-flex back-sc-brighter radius-1em ph-h-em">
        <input class="border-0 back-inherit w-70" name="messageRecipient" type="text" disabled/>
        <i class="recipient-btn message-recipient-modify-btn fa-solid fa-pen ps-10" style="color: gray"></i>
        <i class="recipient-btn message-recipient-delete-btn fa-solid fa-xmark ps-5" style="color: red"></i>
    </div>
</script>
<jsp:include page="/WEB-INF/views/message/messageAside.jsp"></jsp:include>
    <div class="mb-30">
            <h1>쪽지 쓰기</h1>
    </div>
    <div class="row">
        <form id="message-send-form" action="write" method="post">
            <input type="hidden" name="messageSender" value="${sessionScope.memberId}">
            <div class="row">
                <label for="message-recipient-input">
                    받는사람 (<span class="recipient-cnt">0</span>/10)
                </label>
                &nbsp;
                <label style="font-size: 13px">
                    <input class="message-to-me-btn" type="checkbox">
                    내게쓰기
                </label>
                <div class="flex flex-wrap">
                    <input id="message-recipient-input" class="form-input" type="text" name="messageRecipient" placeholder="받는 사람의 아이디를 입력해주세요" required>
                </div>
            </div>
            <hr class="hr-sc"/>
            <div class="row">
                <label>
                    제목
                    <input class="form-input w-100" type="text" name="messageTitle" placeholder="제목을 입력해주세요" required>
                </label>
            </div>
            <div class="row">
                <label>
                    내용
                    <textarea class="form-input w-100" type="text" name="messageContent" placeholder="내용을 입력해주세요" required></textarea>
                </label>
            </div>
            <div class="row">
                <button id="message-send-btn" class="form-btn w-100 positive">보내기</button>
            </div>
        </form>
    </div>
  </article>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>