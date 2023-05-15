<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:forEach var="approvalDto" items="${list}">
	<div>
		<a href="detail?draftNo=${approvalDto.draftNo}">
		번호:${approvalDto.draftNo}, 제목:${approvalDto.draftTitle}, 작성자:${approvalDto.drafterId}
		</a> 
		<a href="delete?draftNo=${approvalDto.draftNo}">삭제</a>
		<a href="edit?draftNo=${approvalDto.draftNo}">수정</a>
	</div>
	<hr>
</c:forEach>




	<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>

    <script>
        Vue.createApp({
            //데이터 설정 영역
            data(){
                return {
                    //화면에서 사용할 데이터를 선언

                };
            },
            computed:{

            },
            methods:{

            }
        }).mount("#app");
    </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>