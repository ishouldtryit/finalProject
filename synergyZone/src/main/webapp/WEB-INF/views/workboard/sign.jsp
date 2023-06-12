<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.custom-list-item {
	  list-style-type: none; /* 리스트 스타일 제거 */
	}
	.duplicate-alert-container {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 9999;
	}
	.btn{
	width: 120px;
	}
	.badge {
    display: inline-block; /* 또는 display: inline-flex; */
    margin-right: 5px; /* 원하는 간격으로 수정 */
}
a{color:#34649C;}
a:hover{color:blue;}
</style>

    <script>
    	const empNo = "${sessionScope.empNo}";
    </script>

	<form action="sign" method="post" enctype="multipart/form-data">
		
		
		<div class="container mt-4">
		
		    
		<div class="row mt-4">
				<div class="">
					<div class="d-flex align-items-center">
						<div class="col">
							<c:if test="${workSups != null}">
								<c:forEach var="employeeDto" items="${workSups}">
								<div class="badge badge-pill badge-light text-dark">
							          ${employeeDto.empName}								
								</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>

			<!-- 제목 -->
			<div class="row">
				<div class="row mt-4">
					<div class="">
						<div class="d-flex align-items-center mb-2">
							<h3 class="me-2">${workBoardDto.workTitle}</h3>
							<span class="badge badge-pill secretBadge"
								data-work-secret="${workBoardDto.workSecret}"></span>
						</div>
						<div class="d-flex align-items-center">
							<div class="profile-image employee-name">
								<img width="24" height="24"
									src="<c:choose>
                                <c:when test="${profile.empNo == workBoardDto.empNo}">
                                    /attachment/download?attachmentNo=${profile.attachmentNo}
                                </c:when>
                                <c:otherwise>
                                    https://image.dongascience.com/Photo/2022/06/6982fdc1054c503af88bdefeeb7c8fa8.jpg
                                </c:otherwise>
                            </c:choose>"
									alt="" style="border-radius: 50%;">
							</div>
							<h6 class="text"
								style="margin-left: 10px; margin-top: 10px; font-weight: nomal">
								<c:forEach var="employeeDto" items="${employees}">
									<c:if test="${employeeDto.empNo == workBoardDto.empNo}">
		                                ${employeeDto.empName}
		                            </c:if>
								</c:forEach>
								<span class="ms-2 text-secondary"
									style="font-weight: lighter; font-size: 14px;"> <fmt:formatDate
										value="${workBoardDto.workReportDate}"
										pattern="y년 M월 d일 H시 m분 " />
								</span>
							</h6>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<!-- 게시글 내용 -->
			<div class="row mt-4" style="min-height: 350px;">
				<div class=""
					value="${workBoardDto.workContent}">
					${workBoardDto.workContent}</div>

				<c:if test="${files != null}">

					<div class="col-md-10 offset-md-1">
						<div class="row mt-4">
							<div class="col-lg-12">
								<div class="card shadow mb-4">
									<div class="card-header py-3">
										<h4 class="m-0 font-weight-bold text-info">File Attach</h4>
									</div>
									<div class="card-body">
										<div class="text-info">
											<c:forEach var="file" items="${files}">
												<a
													href="/attachment/download?attachmentNo=${file.attachmentNo}"
													data-file-size="${file.attachmentSize}">
													${file.attachmentName} </a>
												<br />
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</c:if>
			</div>
			<br>
		</div>
	<div class="row mt-4">
			<input type="hidden" name="workNo" id="workNo"
				value="${workBoardDto.workNo}">
			<div class="d-flex justify-content-center">
			<button type="submit" class="btn btn-outline-info" name="action" value="approve">결재</button>
			<a href="/workboard/workReturn?workNo=${workBoardDto.workNo}" class="btn btn-outline-secondary ms-2">반려</a>
				</div>
			<!-- 나머지 입력 필드들 -->

		</div>

	</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>