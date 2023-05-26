<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp">

<!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script src="${pageContext.request.contextPath}/static/js/employee/employee.js"></script>

<script type="text/javascript">
function validateForm() {
    if ($('#workSecretCheck').is(':checked')) {
        $("#workSecret").val("Y");
    } else {
        $("#workSecret").val("N");
    }
    return true;
}
</script>

<form action="write" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
    <div class="container-fluid mt-4">
        <div class="row">
        
            <div class="offset-md-2 col-md-8">
                <div class="row mt-4">
                    <div class="col">
                        <label class="form-label">공개여부</label>
                        <input type="checkbox" id="workSecretCheck">
                        <input type="hidden" id="workSecret" name="workSecret" value="N">
                        <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp" />
