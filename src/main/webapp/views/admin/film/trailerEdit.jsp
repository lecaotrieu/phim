<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title><fmt:message key="label.film.trailer.edit" bundle="${lang}"/></title>
</head>
<body>
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href='<c:url value="/admin/trang-chu"/>'><i class="fa fa-home"></i>Trang chủ</a>
        </li>
        <li class="breadcrumb-item"><a href='<c:url value="/admin/film/list"/>'><fmt:message
                bundle="${lang}"
                key="label.film.list"/> </a>
        </li>
        <li class="breadcrumb-item"><a href='<c:url value="/admin/film/show?id=${item.id}"/>'>${item.name}</a>
        </li>
        <li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.update"
                                                                            bundle="${lang}"/></li>
    </ol>
</nav>
<div class="col-8 mx-auto">
    <c:if test="${not empty messageResponse}">
        <div class="alert alert-block alert-${alert}">
            <button type="button" class="close" data-dismiss="alert">
                <i class="ace-icon fa fa-times"></i>
            </button>
                ${messageResponse}
        </div>
    </c:if>
    <div class="card">
        <div class="card-header">
            <strong>
                <fmt:message bundle="${lang}" key="label.film.trailer.update"/>
            </strong>
        </div>

        <div class="card-body card-block">

            <form action="<c:url value="/api/admin/film/trailer"/>" class="form-horizontal"
                  id="form-submit" enctype="multipart/form-data">
                <div class="row form-group">
                    <div class="col-12">
                        <c:if test="${not empty item.trailer}">
                            <c:set value="https://drive.google.com/uc?export=view&id=${item.trailer}"
                                   var="videoUrl"/>
                        </c:if>
                        <div class="row">
                            <div class="col-12">
                                <video width="100%" controls>
                                    <source src="${videoUrl}" id="trailer">
                                </video>
                            </div>
                        </div>
                        <input type="file" name="video" id="video" onchange="readVideo(this,'trailer')"
                               accept="video/*">
                        <input type="hidden" value="${item.id}" name="id">
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer">
            <button type="button" class="btn btn-primary btn-sm" id="btnAddOrUpdate">
                <i class="fas fa-check"></i> <fmt:message key="label.update" bundle="${lang}"/>
            </button>
            <button type="reset" class="btn btn-danger btn-sm">
                <i class="fa fa-ban"></i> Reset
            </button>
        </div>
    </div>
</div>
<script>
    $('#video').change(function () {
        if ($(this).val() != "") {
            $('#btnAddOrUpdate').prop('disabled', false);
        } else {
            $('#btnAddOrUpdate').prop('disabled', true);
        }
    });
    <c:url value="/admin/film/trailer?id=${item.id}" var="urlTrailer"/>

    function updateTrailer() {
        showAlertLoading();
        var form = $('#form-submit')[0];
        var data = new FormData(form);
        $.ajax({
            type: "PUT",
            url: $('#form-submit').attr('action'),
            data: data,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            method: 'PUT',
            success: function (res) {
                showAlertAfterSuccess(function () {
                    window.location.href = "${urlTrailer}&message=redirect_update"
                });
            },
            error: function (res) {
                window.location.href = "${urlTrailer}&message=redirect_error"
            }
        });
    }

    $('#btnAddOrUpdate').click(function () {
        $(this).prop('disabled', true);
        updateTrailer(function () {
        });
    });
</script>
</body>
</html>
