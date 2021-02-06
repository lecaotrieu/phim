<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<%@ page import="com.movie.web.utils.SecurityUtils" %>
<c:url var="apiUrl" value="/api/admin/film"></c:url>
<c:url var="apiActorUrl" value="/api/admin/actor"></c:url>
<c:url var="apiDirectorUrl" value="/api/admin/director"></c:url>
<c:url var="filmListUrl" value="/admin/film/list"></c:url>
<c:url var="filmEditUrl" value="/admin/film/edit"></c:url>
<html>
<head>
    <c:if test="${not empty item.id}">
        <title><fmt:message bundle="${lang}" key="label.film.update"/></title>
    </c:if>
    <c:if test="${empty item.id}">
        <title><fmt:message bundle="${lang}" key="label.film.add"/></title>
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
        <c:if test="${not empty item.id}">
            <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa</li>
        </c:if>
        <c:if test="${empty item.id}">
            <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
        </c:if>
    </ol>
</nav>
<div class="col-11 mx-auto">
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
                <c:if test="${not empty item.id}">
                    <fmt:message bundle="${lang}" key="label.film.update"/>
                </c:if>
                <c:if test="${empty item.id}">
                    <fmt:message bundle="${lang}" key="label.film.add"/>
                </c:if>
            </strong>
            <c:if test="${not empty item.id}">
                <a href="<c:url value="/admin/film/show?id=${item.id}"/>" class="float-right">Xem thông tin</a>
            </c:if>
        </div>
        <div class="card-body card-block">
            <div class="row">
                <div class="col-4">
                    <div class="row form-group">
                        <div class="col-10 col-md-10 mx-auto">
                            <form action="<c:url value="/api/admin/film/image"/>" method="post" id="form-image-film"
                                  enctype="multipart/form-data">
                                <c:if test="${not empty item.image}">
                                    <img class="d-block"
                                         src="https://drive.google.com/uc?export=view&id=${item.image}"
                                         alt="Card image cap"
                                         id="imageFilm">
                                </c:if>
                                <c:if test="${empty item.image}">
                                    <img class="d-block"
                                         src="<c:url value="/template/image/default_poster.jpg"/>"
                                         alt="Card image cap"
                                         id="imageFilm">
                                </c:if>
                                <input type="file" name="img" id="img" accept="image/*"
                                       onchange="readURL(this,'imageFilm')">
                                <input type="hidden" name="id" value="${item.id}" id="filmId">
                            </form>
                        </div>
                    </div>
                    <div class="row" style="height: 50px;">
                        <c:if test="${not empty item.id}">
                            <button type="button" id="img-save" class="btn btn-info"
                                    disabled="disabled">
                                <fmt:message key="label.film.image.change" bundle="${lang}"/>
                            </button>
                            <img src="<c:url value="/template/image/loading.gif"/>" alt="" hidden id="loading-img">
                        </c:if>
                    </div>
                </div>
                <form:form method="post" class="form-horizontal col-8" id="formSubmit" modelAttribute="item">
                    <div class="row form-group">
                        <div class="col col-md-2"><label for="name" class=" form-control-label"><fmt:message
                                bundle="${lang}" key="label.film.name"/> </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <form:input path="name" cssClass="form-control" id="name"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label for="actor" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.actor"/>
                            </label>
                        </div>
                        <div class="col-10 col-md-8">
                            <select name="actors.id" multiple class="form-control role-select2" id="actor">
                                <c:forEach items="${actors}" var="actor">
                                    <option value="${actor.id}"
                                            <c:forEach items="${item.actors}" var="actorSelected">
                                                <c:if test="${actor.id == actorSelected.id}">
                                                    selected
                                                </c:if>
                                            </c:forEach>
                                    >${actor.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <a type="button" id="btn-actor" class="d-block btn btn-outline-primary"
                               data-toggle="modal" data-target="#edit-actor">
                                <fmt:message bundle="${lang}" key="label.add.actor"/>
                            </a>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label for="director" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.director"/>
                            </label>
                        </div>
                        <div class="col-10 col-md-8">
                            <select name="director.id" id="director" class="form-control">
                                <option value="">Đạo diễn</option>
                                <c:forEach var="director" items="${directors}">
                                    <option value="${director.id}"
                                            <c:if test="${director.id == item.director.id}">selected</c:if>>
                                            ${director.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <a type="button" class="d-block btn btn-outline-primary"
                               data-toggle="modal" id="btn-director" data-target="#edit-director">
                                <fmt:message bundle="${lang}" key="label.add.director"/>
                            </a>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label for="language" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.language"/>
                            </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <form:input path="language" id="language" cssClass="form-control"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label for="year" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.year"/>
                            </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <form:input path="year" type="number" cssClass="form-control" id="year"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label for="time" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.time"/>
                            </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <form:input path="time" type="number" cssClass="form-control" id="time"/>
                        </div>
                    </div>

                    <security:authorize access="hasAnyRole('ADMIN')">
                        <div class="row form-group">
                            <div class=" col col-md-2">
                                <label for="status" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.status"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-10">
                                <form:select path="status" cssClass="form-control" id="status">
                                    <form:option value="1" label="Hoạt động"/>
                                    <form:option value="0" label="Không hoạt động"/>
                                </form:select>
                            </div>
                        </div>
                    </security:authorize>
                    <security:authorize access="!hasAnyRole('ADMIN')">
                        <input type="hidden" name="status" value="1">
                    </security:authorize>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label for="country" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.country"/>
                            </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <select name="country.id" id="country" class="form-control">
                                <option value="">Chọn Quốc gia</option>
                                <c:forEach var="country" items="${countries}">
                                    <option value="${country.id}"
                                            <c:if test="${country.id == item.country.id}">selected</c:if>>
                                            ${country.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label for="filmType" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.film.type"/>
                            </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <select name="filmType.id" id="filmType" class="form-control">
                                <option value="">Chọn loại film</option>
                                <c:forEach var="filmType" items="${filmTypes}">
                                    <option value="${filmType.id}"
                                            <c:if test="${filmType.id == item.filmType.id}">selected</c:if>>
                                            ${filmType.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col col-md-2">
                            <label for="quality" class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.quality"/>
                            </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <form:select path="quality" cssClass="form-control" id="quality">
                                <form:option value="" label="Chọn chất lượng"/>
                                <form:option value="240p" label="240p"/>
                                <form:option value="360p" label="360p"/>
                                <form:option value="480p" label="480p"/>
                                <form:option value="720p" label="720p"/>
                                <form:option value="1080p" label="1080p"/>
                                <form:option value="1440p" label="1440p"/>
                                <form:option value="2160p" label="2160p"/>
                            </form:select>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class=" col col-md-2">
                            <label class=" form-control-label">
                                <fmt:message bundle="${lang}" key="label.category"/>
                            </label>
                        </div>
                        <div class="col-12 col-md-10">
                            <c:forEach items="${categories}" var="category">
                                <div class="custom-control custom-checkbox float-left"
                                     style="width:120px; margin-right: 15px;">
                                    <input name="categories.id" type="checkbox" class="custom-control-input"
                                    <c:forEach items="${item.categories}" var="categoryChecked">
                                    <c:if test="${category.id == categoryChecked.id}">
                                           checked
                                    </c:if>
                                    </c:forEach>
                                           id="checkbox_${category.id}" value="${category.id}">
                                    <label class="custom-control-label"
                                           for="checkbox_${category.id}">${category.name}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <form:input path="id" type="hidden" id="id"/>
                    <input name="employee.id" value="<%=SecurityUtils.getPrincipal().getId()%>" type="hidden"/>
                </form:form>
            </div>
            <div class="row">
                <label for="description" class="col-sm-12">Nội dung</label>
                <div class="col-sm-12">
                    <textarea form="formSubmit" class="form-control" name="description" id="description"
                              rows="20">${item.description}</textarea>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <c:if test="${not empty item.id}">
                <button type="button" class="btn btn-primary btn-sm" id="btnAddOrUpdate"
                        style="float: right; margin-left: 5px;">
                    <i class="fas fa-check"></i> <fmt:message key="label.film.update" bundle="${lang}"/>
                </button>
            </c:if>
            <c:if test="${empty item.id}">
                <button type="button" class="btn btn-primary btn-sm" id="btnAddOrUpdate"
                        style="float: right; margin-left: 5px;">
                    <i class="fas fa-check"></i> <fmt:message bundle="${lang}" key="label.film.add"/>
                </button>
            </c:if>

            <button type="reset" class="btn btn-danger btn-sm" style="float: right;">
                <i class="fa fa-ban"></i> Reset
            </button>
        </div>
        <div class="modal fade" id="edit-director" style="display: none; padding-right: 17px;" aria-modal="true">
            <div class="modal-dialog modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title"><fmt:message key="label.add.director"
                                                             bundle="${lang}"/></h3>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <!-- form start -->
                        <form id="editDirectorForm">
                            <div class="form-group">
                                <label class=" form-control-label"><fmt:message key="label.director"
                                                                                bundle="${lang}"/></label>
                                <input type="text" name="name" id="ip-director-name" placeholder="<fmt:message key="label.director.name"
                                                bundle="${lang}"/>" class="form-control">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-outline-primary" id="btnDirectorSave"><fmt:message
                                bundle="${lang}"
                                key="label.add"/></button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <div class="modal fade" id="edit-actor" style="display: none; padding-right: 17px;" aria-modal="true">
            <div class="modal-dialog modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title"><fmt:message key="label.add.actor"
                                                             bundle="${lang}"/></h3>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <!-- form start -->
                        <form id="editActorForm">
                            <div class="form-group">
                                <label class=" form-control-label"><fmt:message key="label.actor"
                                                                                bundle="${lang}"/></label>
                                <input type="text" name="name" id="ip-actor-name" placeholder="<fmt:message key="label.actor.name"
                                                bundle="${lang}"/>" class="form-control">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-outline-primary" id="btnActorSave"><fmt:message
                                bundle="${lang}"
                                key="label.add"/></button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </div>
</div>
<script>
    $('.role-select2').select2();

    $(document).ready(function () {
        var editor = CKEDITOR.replace('description', {
            width: ['100%'], height: ['300px']
        });
    });


    $('#btnActorSave').click(function (e) {
        e.preventDefault();
        var formData = $('#editActorForm').serializeArray();
        var data = convertToJson(formData);
        if (Object.keys(data).length != 0) {
            addActor(data);
            $('#edit-actor').modal("hide")
            $('#ip-actor-name').val("");
        }
    });

    function addActor(data) {
        $.ajax({
            url: '${apiActorUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                var newOption = new Option(result.name, result.id, false, false);
                $('#actor').append(newOption).trigger('change');
            },
            error: function (error) {
                console.log("lỗi");
            }
        });
    }

    $('#btnDirectorSave').click(function (e) {
        e.preventDefault();
        var formData = $('#editDirectorForm').serializeArray();
        var data = convertToJson(formData);
        if (Object.keys(data).length != 0) {
            addDirector(data);
            $('#edit-director').modal("hide")
            $('#ip-director-name').val("");
        }
    });

    function addDirector(data) {
        $.ajax({
            url: '${apiDirectorUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                var newOption = new Option(result.name, result.id, false, false);
                $('#director').append(newOption).trigger('change');
            },
            error: function (error) {
                console.log("lỗi");
            }
        });
    }

    $('input#img').change(function () {
        if ($(this).val() != "") {
            $('#img-save').prop("disabled", false);
        } else {
            $('#img-save').prop("disabled", true);
        }
    });
    $('#btnAddOrUpdate').click(function (e) {
        e.preventDefault();
        var id = $('#id').val();
        var desc = CKEDITOR.instances['description'].getData();
        $('#description').val(desc);
        var formData = $('#formSubmit').serializeArray();
        var data = convertToJson(formData);
        if (id != "") {
            updateFilm(data);
        } else {
            addFilm(data);
        }
    });

    $('#img-save').click(function () {
        $('#img-save').prop("disabled", true);
        updateFilmImage();
    });

    function updateFilm(data) {
        $.ajax({
            url: '${apiUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${filmEditUrl}?id=" + result + "&message=redirect_update";
            },
            error: function (error) {
                window.location.href = "${filmEditUrl}?id=" + ${item.id} +"&message=redirect_error";
            }
        });
    }

    function updateFilmImage(a) {
        if ($('#img').val() != "") {
            var form = $('#form-image-film')[0];
            $('#loading-img').prop("hidden", false);
            var data = new FormData(form);
            $.ajax({
                type: "POST",
                url: $('#form-image-film').attr('action'),
                data: data,
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                method: 'POST',
                success: function (res) {
                    $('#loading-img').prop("hidden", true);
                    showAlertAfterSuccess(a);
                },
                error: function (res) {
                    console.log(res);
                }
            });
        } else {
            window.location.href = "${filmEditUrl}?id=" + $('#filmId').val() + "&message=redirect_insert";
        }
    }


    function addFilm(data) {
        $.ajax({
            url: '${apiUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                $('#filmId').val(result.id);
                updateFilmImage(function () {
                    window.location.href = "${filmEditUrl}?id=" + result.id + "&message=redirect_insert";
                });
            },
            error: function (error) {
                window.location.href = "${filmEditUrl}?message=redirect_error";
            }
        });
    }
</script>
</body>
</html>
