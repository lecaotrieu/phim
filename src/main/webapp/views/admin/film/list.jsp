<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url value="/api/admin/film/status" var="apiUpdateStatusUrl">
</c:url>
<c:url value="/api/admin/film" var="apiFilm">
</c:url>
<c:url value="/admin/film/list" var="filmListURL">
</c:url>
<html>
<head>
    <title><fmt:message key="label.film.list"
                        bundle="${lang}"/></title>
</head>
<body>
<div class="breadcrumbs" id="breadcrumbs">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href='<c:url value="/admin/home-page"/>'>
                <i class="fa fa-home"></i><fmt:message key="label.home.page" bundle="${lang}"/></a>
            </li>
            <li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.film.list"
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
        <fmt:message key="label.film.list" bundle="${lang}"/>
        <a href="<c:url value="/admin/film/edit"/>" class="float-right btn btn-outline-success"><fmt:message
                key="label.film.add" bundle="${lang}"/></a>
    </div>
    <form:form action="" id="form-film" method="get" modelAttribute="items">
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
                                    <fmt:message bundle="${lang}" key="label.search"/>
                                </button>
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
                                    <display:column property="code" titleKey="label.film.code" sortable="true"
                                                    sortName="code"/>
                                    <display:column property="name" titleKey="label.film.name" sortable="true"
                                                    sortName="name"/>
                                    <display:column property="language" titleKey="label.language" sortable="true"
                                                    sortName="language"/>
                                    <display:column property="country.name" titleKey="label.country" sortable="true"
                                                    sortName="country.name"/>
                                    <display:column property="quality" titleKey="label.quality" sortable="true"
                                                    sortName="quality"/>
                                    <display:column property="episodesCount" titleKey="label.total.episode"/>
                                    <security:authorize access="hasAnyRole('ADMIN')">
                                        <display:column property="createdBy" titleKey="label.people.create"
                                                        sortable="true"
                                                        sortName="createdBy"/>
                                        <display:column property="createdDate" titleKey="label.create.date"
                                                        sortable="true"
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
                                                       onchange="updateStatusOfFilm(${tableList.id},function() {})"
                                                       <c:if test="${tableList.status == 1}">checked</c:if>>
                                                <label class="custom-control-label"
                                                       for="status_${tableList.id}"></label>
                                            </div>
                                        </display:column>
                                    </security:authorize>
                                    <display:column titleKey="label.action" class="">
                                        <a class="btn btn-sm btn-primary btn-show"
                                           href="<c:url value="/admin/film/edit?id=${tableList.id}"/>"
                                           data-toggle="tooltip"
                                           title="<fmt:message key='label.update' bundle='${lang}'/>">
                                            <i class="fas fa-pencil-alt"></i>
                                        </a>
                                        <a class="btn btn-sm btn-success btn-show"
                                           href="<c:url value="/admin/film/show?id=${tableList.id}"/>"
                                           data-toggle="tooltip"
                                           title="<fmt:message key='label.show' bundle='${lang}'/>">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <security:authorize access="hasRole('ADMIN')">
                                            <a class="btn btn-sm btn-warning" sc-url="#"
                                               onclick="warningBeforeDelete(${tableList.id})"
                                               title="<fmt:message key='label.delete' bundle='${lang}'/> ">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </security:authorize>
                                        <security:authorize access="!hasRole('ADMIN')">
                                            <a class="btn btn-sm btn-warning" sc-url="#"
                                               onclick="warningBeforeDeleteOfPoster(${tableList.id})"
                                               title="<fmt:message key='label.delete' bundle='${lang}'/> ">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </security:authorize>
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
        $('#form-film').submit();
    })

    function warningBeforeDelete(x) {
        if (x != null) {
            showAlertBeforeDelete(function () {
                deleteFilm([x]);
            });
        } else {
            showAlertBeforeDelete(function () {
                var ids = $('tbody input[type=checkbox]:checked').map(function () {
                    return $(this).val()
                }).get();
                deleteFilm(ids);
            });
        }
    }

    function warningBeforeDeleteOfPoster(x) {
        if (x != null) {
            showAlertBeforeDelete(function () {
                updateStatusOfFilm(x, function () {
                    window.location.href = '${filmListURL}?message=redirect_delete';
                });
            });
        }
    }

    function updateStatusOfFilm(id, x) {
        var status = "status_" + id;
        if ($('#' + status).is(':checked')) {
            status = 1;
        } else {
            status = 0;
        }
        var data = {id: id, status: status};
        $.ajax({
            url: '${apiUpdateStatusUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                x();
            },
            error: function (error) {

            }
        });
    }

    function deleteFilm(data) {
        $.ajax({
            url: '${apiFilm}',
            type: 'DELETE',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function (result) {
                window.location.href = '${filmListURL}?message=redirect_delete';
            },
            error: function (result) {
                window.location.href = '${filmListURL}?&message=redirect_error';

            }
        });
    }
</script>
</body>
</html>
