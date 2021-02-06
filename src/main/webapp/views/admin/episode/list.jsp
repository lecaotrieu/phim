<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/api/admin/film/episode/status" var="apiUpdateStatusUrl"></c:url>
<c:url value="/api/admin/film/episode" var="apiDeleteUrl"></c:url>
<c:url value="/ajax/admin/film/list" var="episodeListUrl">
    <c:param name="filmId" value="${film.id}"></c:param>
</c:url>
<link rel="stylesheet" type="text/css" href="<c:url value="/template/DataTables/datatables.css"/>">
<script type="text/javascript" charset="utf8"
        src="<c:url value="/template/DataTables/jQuery-3.3.1/jquery-3.3.1.min.js"/>"></script>
<script type="text/javascript" charset="utf8" src="<c:url value="/template/DataTables/datatables.js"/>"></script>
<table id="table_id" class="table table-bordered display">
    <thead class="thead-dark">
    <tr>
        <th scope="col"><fmt:message key="label.id" bundle="${lang}"/></th>
        <th scope="col"><fmt:message key="label.episode.chapter" bundle="${lang}"/></th>
        <th scope="col"><fmt:message key="label.episode.name" bundle="${lang}"/></th>
        <th scope="col"><fmt:message key="label.create.date" bundle="${lang}"/></th>
        <th scope="col"><fmt:message key="label.modified.date" bundle="${lang}"/></th>
        <security:authorize access="hasAnyRole('ADMIN')">
            <th scope="col"><fmt:message key="label.status" bundle="${lang}"/></th>
        </security:authorize>
        <th scope="col"><fmt:message key="label.action" bundle="${lang}"/></th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${items.listResult}" var="episode">
        <tr id="tr_${episode.id}">
            <th scope="row">${episode.id}</th>
            <td>${episode.episodeCode}</td>
            <td>${episode.name}</td>
            <td>${episode.createdDate}</td>
            <td>${episode.modifiedDate}</td>
            <security:authorize access="hasAnyRole('ADMIN')">
                <td>
                    <div class="custom-control custom-switch"
                         style="width: fit-content; margin: auto;">
                        <input type="checkbox" class="custom-control-input"
                               id="status_${episode.id}"
                               onchange="updateStatusOfEpisode(${episode.id},function() {})"
                               <c:if test="${episode.status == 1}">checked</c:if>>
                        <label class="custom-control-label"
                               for="status_${episode.id}"></label>
                    </div>
                </td>
            </security:authorize>
            <td>
                <a href="<c:url value="/admin/film/${film.code}-${film.id}/tap-${episode.episodeCode}-${episode.id}"/>"><fmt:message
                        key="label.update" bundle="${lang}"/></a>
                <security:authorize access="!hasAnyRole('ADMIN')">
                    <a type="button" style="color: red;"
                       onclick="warningBeforeDeleteOfPoster(${episode.id})"><fmt:message key="label.delete"
                                                                                         bundle="${lang}"/></a>
                </security:authorize>
                <security:authorize access="hasAnyRole('ADMIN')">
                    <a type="button" style="color: red;"
                       onclick="warningBeforeDeleteOfAdmin(${episode.id})"><fmt:message key="label.delete"
                                                                                        bundle="${lang}"/></a>
                </security:authorize>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>
    $(document).ready(function () {
        var arr = [];
        for (var i = 1; i < 50; i++) {
            arr[i - 1] = i;
        }
        $('#table_id').DataTable({
            select: true,
            aLengthMenu: arr,
            order: [[1, "asc"]],
            iDisplayLength: 10
        });
    });

    function warningBeforeDeleteOfAdmin(x) {
        if (x != null) {
            showAlertBeforeDelete(function () {
                deleteEpisode(x)
            });
        }
    }

    function updateStatusOfEpisode(id, x) {
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

    function warningBeforeDeleteOfPoster(x) {
        if (x != null) {
            showAlertBeforeDelete(function () {
                updateStatusOfEpisode(x, function () {
                    $('#profile').load('${episodeListUrl}');
                });
            });
        }
    }


</script>