<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/ajax/admin/role/edit" var="saveRoleUrl"></c:url>
<c:url value="/api/admin/role" var="apiRole"/>
<c:url value="/admin/role/list" var="roleListUrl"></c:url>
<html>
<head>
    <title><fmt:message key="label.role.list" bundle="${lang}"/></title>
</head>
<body>
<div class="breadcrumbs" id="breadcrumbs">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<c:url value="/admin/home-page"/>'>
                <i class="fa fa-home"></i><fmt:message key="label.home.page" bundle="${lang}"/></a>
            </li>
            <li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.role.list"
                                                                                bundle="${lang}"/></li>
        </ol>
    </nav>
</div>
<div class="card mb-4">
    <c:if test="${not empty messageResponse}">
        <div class="alert alert-block alert-${alert}">
            <button type="button" class="close" data-dismiss="alert">
                <i class="ace-icon fa fa-times"></i>
            </button>
                ${messageResponse}
        </div>
    </c:if>
    <div class="card-header">
        <fmt:message key="label.role.list" bundle="${lang}"/>
        <button type="button" class="float-right btn btn-outline-success"
                onclick="updateRoleShow('<c:url value="/ajax/admin/role/edit"/>')">
            <fmt:message key="label.role.add" bundle="${lang}"/></button>
    </div>
    <form:form action="" id="form-role" method="get" modelAttribute="items">
        <div class="card-body">
            <div class="table-responsive">
                <div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
                    <div class="row">
                        <div class="col-sm-12 col-md-6">
                            <div class="dataTables_length" id="dataTable_length">
                                <label>Show
                                    <form:select path="limit" aria-controls="dataTable" id="select-limit"
                                                 cssClass="custom-select custom-select-sm form-control form-control-sm">
                                        <c:forEach begin="1" end="100" var="item">
                                            <form:option value="${item}" label="${item}"/>
                                        </c:forEach>
                                    </form:select>
                                    entries
                                </label>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 d-flex justify-content-end">
                            <form class="form-inline" style="margin-bottom: auto;">
                                <input class="form-control mr-sm-2 col-5" type="search"
                                       placeholder="<fmt:message bundle="${lang}" key="label.search"/>" name="search"
                                       aria-label="Search" value="${items.search}">
                                <button class="btn btn-outline-primary my-2 my-sm-0" type="submit"
                                        style="height: max-content;">
                                    <fmt:message bundle="${lang}" key="label.search"/></button>
                            </form>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <fmt:bundle basename="ApplicationResource">
                                <display:table id="tableList" name="items.listResult" partialList="true"
                                               sort="external"
                                               size="${items.totalItems}" pagesize="${items.limit}"
                                               requestURI="${requestUrl}"
                                               class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"
                                               style="margin: 0 0 1em;">
                                    <display:column property="id" titleKey="label.id" sortable="true"
                                                    sortName="id"/>
                                    <display:column property="code" titleKey="label.role.code" sortable="true"
                                                    sortName="code"/>
                                    <display:column property="name" titleKey="label.role.name" sortable="true"
                                                    sortName="name"/>
                                    <display:column property="createdBy" titleKey="label.people.create" sortable="true"
                                                    sortName="createdBy"/>
                                    <display:column property="createdDate" titleKey="label.create.date" sortable="true"
                                                    sortName="createdDate"/>
                                    <display:column property="modifiedBy" titleKey="label.people.modified"
                                                    sortable="true"
                                                    sortName="modifiedBy"/>
                                    <display:column property="modifiedDate" titleKey="label.modified.date"
                                                    sortable="true"
                                                    sortName="modifiedDate"/>
                                    <display:column titleKey="label.action" class="">
                                        <c:url var="updateRoleUrl" value="/ajax/admin/role/edit">
                                            <c:param name="id" value="${tableList.id}"/>
                                        </c:url>
                                        <button type="button" class="btn btn-sm btn-primary btn-update"
                                                onclick="updateRoleShow('${updateRoleUrl}')"
                                                data-toggle="tooltip"
                                                title="<fmt:message key='label.update' bundle='${lang}'/>">
                                            <i class="fas fa-pencil-alt"></i>
                                        </button>
                                        <a class="btn btn-sm btn-warning" onclick="warningBeforeDelete(${tableList.id})"
                                           title="<fmt:message key='label.delete' bundle='${lang}'/> ">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </display:column>
                                </display:table>
                            </fmt:bundle>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
    <div id="edit">
    </div>
</div>
<script>
    $('#select-limit').on("change", function () {
        $('#form-role').submit();
    });

    function updateRoleShow(url) {
        $('#edit').load(url, "", function () {
            $('#role-modal').modal("toggle");
        });
    }

    function updateRole(data) {
        $.ajax({
            url: '${apiRole}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${roleListUrl}?message=redirect_update";
            },
            error: function (error) {
                window.location.href = "${roleListUrl}?message=redirect_error";
            }
        });
    }

    function saveRole(data) {
        $.ajax({
            url: '${apiRole}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${roleListUrl}?message=redirect_insert";
            },
            error: function (error) {
                window.location.href = "${roleListUrl}?message=redirect_error";
            }
        });
    }

    function warningBeforeDelete(x) {
        if (x != null) {
            showAlertBeforeDelete(function () {
                deleteRole([x]);
            });
        } else {
            showAlertBeforeDelete(function () {
                var ids = $('tbody input[type=checkbox]:checked').map(function () {
                    return $(this).val()
                }).get();
                deleteRole(ids);
            });
        }
    }

    function deleteRole(data) {
        $.ajax({
            url: '${apiRole}',
            type: 'DELETE',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function (result) {
                window.location.href = "${roleListUrl}?message=redirect_delete";
            },
            error: function (result) {
                window.location.href = "${roleListUrl}?message=redirect_error";
            }
        });
    }

</script>
</body>
</html>
