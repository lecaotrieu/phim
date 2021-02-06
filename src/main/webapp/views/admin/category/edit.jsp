<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/api/admin/category" var="apiCategory"/>
<!-- Modal -->
<div class="modal fade" id="category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <c:if test="${empty item.id}">
                    <h5 class="modal-title" id="exampleModalLongTitle"><fmt:message key="label.category.add"
                                                                                    bundle="${lang}"/></h5>
                </c:if>
                <c:if test="${not empty item.id}">
                    <h5 class="modal-title" id="exampleModalLongTitle"><fmt:message key="label.category.update"
                                                                                    bundle="${lang}"/></h5>
                </c:if>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form action="" id="formSubmit" cssClass="form-horizontal" modelAttribute="item">
                    <div class="row form-group">
                        <div class="col col-md-3"><label for="code" class=" form-control-label"><fmt:message
                                bundle="${lang}" key="label.category.code"/> </label>
                        </div>
                        <div class="col-12 col-md-9">
                            <form:input path="code" cssClass="form-control" id="code"
                                        placeholder="Tự thêm nếu để trống"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col col-md-3"><label for="name" class=" form-control-label"><fmt:message
                                bundle="${lang}" key="label.category.name"/> </label>
                        </div>
                        <div class="col-12 col-md-9">
                            <form:input path="name" cssClass="form-control" id="name"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-12">
                            <label for="name" class=" form-control-label"><fmt:message
                                    bundle="${lang}" key="label.description"/>
                        </div>
                        <div class="col-12">
                            <form:textarea path="description" cssClass="form-control" id="description" rows="8"/>
                        </div>
                    </div>
                    <c:if test="${not empty item.id}">
                        <form:input path="id" type="hidden"/>
                    </c:if>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal"><fmt:message key="label.close"
                                                                                                  bundle="${lang}"/></button>
                <c:if test="${empty item.id}">
                    <button type="button" id="btn-save" class="btn btn-primary"><fmt:message key="label.save"
                                                                                             bundle="${lang}"/></button>
                </c:if>
                <c:if test="${not empty item.id}">
                    <button type="button" id="btn-update" class="btn btn-primary"><fmt:message key="label.save.change"
                                                                                               bundle="${lang}"/></button>
                </c:if>

            </div>
        </div>
    </div>
</div>
<script>
    $('#btn-save').click(function (e) {
        e.preventDefault();
        var formData = $('#formSubmit').serializeArray();
        var data = convertToJson(formData);
        saveCategory(data);
    });
    $('#btn-update').click(function (e) {
        e.preventDefault();
        var formData = $('#formSubmit').serializeArray();
        var data = convertToJson(formData);
        updateCategory(data);
    });


</script>
