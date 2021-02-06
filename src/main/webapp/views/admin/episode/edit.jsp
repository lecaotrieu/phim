<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/admin/film/${film.code}-${film.id}" var="episodeUrl"></c:url>
<html>
<head>
    <c:if test="${not empty item.id}">
        <title><fmt:message bundle="${lang}" key="label.episode.update"/></title>
    </c:if>
    <c:if test="${empty item.id}">
        <title><fmt:message bundle="${lang}" key="label.episode.add"/></title>
    </c:if>
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
        <li class="breadcrumb-item"><a href='<c:url value="/admin/film/show?id=${film.id}"/>'>${film.name}</a>
        </li>
        <c:if test="${not empty item.id}">
            <li class="breadcrumb-item active" aria-current="page"><fmt:message key="label.update"
                                                                                bundle="${lang}"/></li>
        </c:if>
        <c:if test="${empty item.id}">
            <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
        </c:if>
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
    <div class="" style="margin-bottom: 20px">
        <c:forEach items="${film.episodes}" var="episode">
            <a href="<c:url value="/admin/film/${film.code}-${film.id}/tap-${episode.episodeCode}-${episode.id}"/>"
               class="btn btn-primary">${episode.episodeCode}</a>
        </c:forEach>
        <a href="<c:url value="/admin/film/${film.code}-${film.id}"/>" class="btn btn-primary">+</a>
    </div>
    <div class="card">
        <div class="card-header">
            <strong>
                <c:if test="${not empty item.id}">
                    <fmt:message bundle="${lang}" key="label.episode.update"/>
                </c:if>
                <c:if test="${empty item.id}">
                    <fmt:message bundle="${lang}" key="label.episode.add"/>
                </c:if>
            </strong>
        </div>

        <div class="card-body card-block">

            <form method="post" action="<c:url value="/api/admin/film/episode"/>" class="form-horizontal"
                  id="formEpisode" modelAttribute="item" enctype="multipart/form-data">
                <div class="row form-group">
                    <div class="col col-md-3">
                        <label for="name" class=" form-control-label">
                            <fmt:message bundle="${lang}" key="label.episode.chapter"/>
                        </label>
                    </div>
                    <div class="col-12 col-md-9">
                        <input type="number" id="episodeCode" name="episodeCode" placeholder="Tự động thêm khi để trống"
                               value="${item.episodeCode}"
                               class="form-control">
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col col-md-3">
                        <label for="name" class=" form-control-label">
                            <fmt:message bundle="${lang}" key="label.episode.name"/>
                        </label>
                    </div>
                    <div class="col-12 col-md-9">
                        <input type="text" id="name" name="name" value="${item.name}" class="form-control">
                    </div>
                </div>
                <div class="row form-group">
                    <div class="col-12">
                        <c:if test="${not empty item.episodeId}">
                            <c:set value="https://drive.google.com/uc?export=view&id=${item.episodeId}"
                                   var="videoUrl"/>
                        </c:if>
                        <div class="row">
                            <div class="col-12">
                                <video width="100%" controls>
                                    <source src="${videoUrl}" id="episode-video">
                                </video>
                            </div>
                        </div>
                        <input type="file" name="video" id="video" onchange="readVideo(this,'episode-video')"
                               accept="video/*">
                        <input type="hidden" value="${film.id}" name="film.id">
                        <input type="hidden" value="1" name="status">
                        <c:if test="${not empty item.id}">
                            <input type="hidden" name="id" value="${item.id}">
                        </c:if>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer">
            <c:if test="${not empty item.id}">
                <button type="button" class="btn btn-primary btn-sm" id="btnAddOrUpdate">
                    <i class="fas fa-check"></i> <fmt:message key="label.episode.update" bundle="${lang}"/>
                </button>
            </c:if>
            <c:if test="${empty item.id}">
                <button type="button" class="btn btn-primary btn-sm" id="btnAddOrUpdate">
                    <i class="fas fa-check"></i> <fmt:message bundle="${lang}" key="label.episode.add"/>
                </button>
            </c:if>

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

    function updateEpisodeVideo(a) {
        showAlertLoading();
        var form = $('#formEpisode')[0];
        var data = new FormData(form);
        $.ajax({
            type: "PUT",
            url: $('#formEpisode').attr('action'),
            data: data,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            method: 'PUT',
            success: function (res) {
                showAlertAfterSuccess(function () {
                    window.location.href = "${episodeUrl}/tap-${item.episodeCode}-${item.id}";
                });
            },
            error: function (res) {
                console.log(res);
            }
        });
    }

    function addEpisodeVideo(a) {
        showAlertLoading();
        var form = $('#formEpisode')[0];
        var data = new FormData(form);
        $.ajax({
            type: "POST",
            url: $('#formEpisode').attr('action'),
            data: data,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            method: 'POST',
            success: function (res) {
                if (res == null) {
                    window.location.href = "${episodeUrl}";
                } else {
                    showAlertAfterSuccess(function () {
                        window.location.href = "${episodeUrl}/tap-" + res.episodeCode + "-" + res.id;
                    });
                }
            },
            error: function (res) {
                window.location.href = "${episodeUrl}?message=redirect_error";
            }
        });
    }

    $('#btnAddOrUpdate').click(function () {
        $(this).prop('disabled', true);
        var id = "${item.id}";
        if (id == "") {
            addEpisodeVideo(function () {
            });
        } else {
            updateEpisodeVideo(function () {
            });
        }
    });
</script>
</body>
</html>
