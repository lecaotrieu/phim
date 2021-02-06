<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url value="/api/admin/employee/status" var="apiUrl">
</c:url>
<c:url value="/api/admin/employee" var="apiEmployee">
</c:url>
<c:url value="/admin/employee/list" var="employeeListURL">
</c:url>
<html>
<head>
    <title>Danh sách nhân viên</title>
</head>
<body>
<div class="breadcrumbs" id="breadcrumbs">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<c:url value="/admin/home-page"/>'>
                <i class="fa fa-home"></i><fmt:message key="label.home.page" bundle="${lang}"/></a>
            </li>
            <li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.employee.list"
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
        <fmt:message key="label.employee.list" bundle="${lang}"/>
        <a href="<c:url value="/admin/employee/edit"/>" class="float-right btn btn-outline-success"><fmt:message
                key="label.employee.add" bundle="${lang}"/></a>
    </div>
    <form:form action="" id="form-employees" method="get" modelAttribute="items">
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
                                    <display:column property="userName" titleKey="label.username" sortable="true"
                                                    sortName="userName"/>
                                    <display:column property="firstName" titleKey="label.first.name" sortable="true"
                                                    sortName="firstName"/>
                                    <display:column property="lastName" titleKey="label.last.name" sortable="true"
                                                    sortName="lastName"/>
                                    <display:column property="address" titleKey="label.address"/>
                                    <display:column property="commune.name" titleKey="label.commune"/>
                                    <display:column property="district.name" titleKey="label.district"/>
                                    <display:column property="city.name" titleKey="label.city"/>
                                    <display:column property="country.name" titleKey="label.country"/>
                                    <display:column value="null" titleKey="label.age"/>
                                    <display:column property="birthDate" titleKey="label.birth.date"/>
                                    <display:column property="phone" titleKey="label.phone"/>
                                    <display:column property="email" titleKey="label.email"/>
                                    <display:column titleKey="label.role" style="width:200px; display:block;">
                                        <c:forEach var="role" items="${tableList.roles}">
                                            <b>[${role.name}] </b>
                                        </c:forEach>
                                    </display:column>
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
                                    <display:column titleKey="label.status">
                                        <div class="custom-control custom-switch"
                                             style="width: fit-content; margin: auto;">
                                            <input type="checkbox" class="custom-control-input"
                                                   id="status_${tableList.id}"
                                                   onchange="updateStatusOfEmployee(${tableList.id})"
                                                   <c:if test="${tableList.status == 1}">checked</c:if>>
                                            <label class="custom-control-label" for="status_${tableList.id}"></label>
                                        </div>
                                    </display:column>
                                    <display:column titleKey="label.action" class="">
                                        <c:url var="updateEmployeeUrl" value="/admin/employee/edit">
                                            <c:param name="id" value="${tableList.id}"/>
                                        </c:url>
                                        <a class="btn btn-sm btn-primary btn-show" href="${updateEmployeeUrl}"
                                           data-toggle="tooltip"
                                           title="<fmt:message key='label.update' bundle='${lang}'/>">
                                            <i class="fas fa-pencil-alt"></i>
                                        </a>
                                        <a class="btn btn-sm btn-success btn-show"
                                           href="<c:url value="/admin/employee/profile?id=${tableList.id}"/>"
                                           data-toggle="tooltip"
                                           title="<fmt:message key='label.show' bundle='${lang}'/>">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a class="btn btn-sm btn-warning" sc-url="${deleteUrl}"
                                           onclick="warningBeforeDelete(${tableList.id})"
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
</div>
<script>
    $('#select-limit').on("change", function () {
        $('#form-employees').submit();
    })

    function warningBeforeDelete(x) {
        if (x != null) {
            showAlertBeforeDelete(function () {
                deleteEmployee([x]);
            });
        } else {
            showAlertBeforeDelete(function () {
                var ids = $('tbody input[type=checkbox]:checked').map(function () {
                    return $(this).val()
                }).get();
                deleteEmployee(ids);
            });
        }
    }

    function deleteEmployee(data) {
        $.ajax({
            url: '${apiEmployee}',
            type: 'DELETE',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function (result) {
                window.location.href = '${employeeListURL}?message=redirect_delete';
            },
            error: function (result) {
                window.location.href = '${employeeListURL}?&message=redirect_error';

            }
        });
    }

    function updateStatusOfEmployee(id) {
        var status = "status_" + id;
        if ($('#' + status).is(':checked')) {
            status = 1;
        } else {
            status = 0;
        }
        var data = {id: id, status: status};
        $.ajax({
            url: '${apiUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function () {
                console.log("thanh cong");
            },
            error: function () {
                console.log("loi");
            }
        });
    }
</script>
</body>
</html>
