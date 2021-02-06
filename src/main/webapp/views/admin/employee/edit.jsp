<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<%@ page import="com.movie.web.utils.SecurityUtils" %>
<c:url value="/api/admin/employee" var="apiUrl">
</c:url>
<c:url var="editEmployeeUrl" value="/admin/employee/edit">
</c:url>
<c:url var="employeeListURL" value="/admin/employee/list">
</c:url>
<c:url var="changAvatarUrl" value="/admin/employee/photo/edit">
</c:url>
<c:url var="apiUpdatePasswordUrl" value="/api/admin/employee/password">
</c:url>
<html>
<head>
    <c:if test="${not empty item.id}">
        <title><fmt:message bundle="${lang}" key="label.employee.update"/></title>
    </c:if>
    <c:if test="${empty item.id}">
        <title><fmt:message bundle="${lang}" key="label.employee.add"/></title>
    </c:if>
</head>
<body>
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href='<c:url value="/admin/trang-chu"/>'><i class="fa fa-home"></i>Trang chủ</a>
        </li>
        <li class="breadcrumb-item"><a href='<c:url value="/admin/employee/list"/>'><fmt:message
                bundle="${lang}"
                key="label.employee.list"/> </a>
        </li>
        <c:if test="${not empty item.id}">
            <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa</li>
        </c:if>
        <c:if test="${empty item.id}">
            <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
        </c:if>
    </ol>
</nav>
<div class="col-12 mx-auto">
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
                    <fmt:message bundle="${lang}" key="label.employee.update"/>
                </c:if>
                <c:if test="${empty item.id}">
                    <fmt:message bundle="${lang}" key="label.employee.add"/>
                </c:if>
            </strong>
            <c:if test="${not empty item.id}">
                <a href="<c:url value="/admin/employee/profile?id=${item.id}"/>" class="float-right"><fmt:message
                        key="label.employee.profile" bundle="${lang}"/></a>
            </c:if>
        </div>

        <div class="card-body card-block">
            <form:form method="post" class="form-horizontal" id="formSubmit" modelAttribute="item">
                <div class="row">
                    <div class="col-6">
                        <c:if test="${not empty item.id}">
                            <div class="row form-group">
                                <div class="col col-md-3">
                                    <c:if test="${not empty item.photo}">
                                        <img class="d-block"
                                             src="https://drive.google.com/uc?export=view&id=${item.photo}"
                                             alt="Card image cap" style="width: 150px; height: 150px"
                                             id="avatarUser">
                                    </c:if>
                                    <c:if test="${empty item.photo}">
                                        <img class="d-block"
                                             src="<c:url value="/template/image/avatar_default.jpg"/>"
                                             alt="Card image cap" style="width: 150px; height: 150px"
                                             id="avatarUser">
                                    </c:if>
                                    <form:input path="photo" type="hidden"/>
                                </div>
                                <c:set value="<%=SecurityUtils.getPrincipal().getId()%>" var="SessionID"/>
                                <div class="col-12 col-md-9">
                                    <c:if test="${SessionID == item.id}">
                                        <a href="<c:url value="/admin/personal/photo"/>"
                                           class="d-block btn btn-outline-info">
                                            <fmt:message key="label.edit.avatar.change" bundle="${lang}"/>
                                        </a>
                                    </c:if>
                                    <c:if test="${SessionID != item.id}">
                                        <a href="<c:url value="/admin/employee/photo/edit?id=${item.id}"/>"
                                           class="d-block btn btn-outline-info">
                                            <fmt:message key="label.edit.avatar.change" bundle="${lang}"/>
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>
                        <div class="row form-group">
                            <div class="col col-md-3"><label for="username" class=" form-control-label"><fmt:message
                                    bundle="${lang}" key="label.username"/> </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <form:input path="userName" cssClass="form-control" id="username"/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col col-md-3"><label for="password" class=" form-control-label"><fmt:message
                                    bundle="${lang}" key="label.password"/> </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <c:if test="${not empty item.id}">
                                    <a type="button" id="password" class="d-block btn btn-outline-primary"
                                       data-toggle="modal" data-target="#edit-password">
                                        <fmt:message bundle="${lang}" key="label.change.password"/>
                                    </a>
                                </c:if>
                                <c:if test="${empty item.id}">
                                    <input name="password" type="password" id="password" class="form-control"></input>
                                </c:if>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col col-md-3">
                                <label for="firstName" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.full.name"/>
                                </label>
                            </div>
                            <div class="col-4 col-md-4">
                                <form:input path="firstName" id="firstName" cssClass="form-control"
                                            placeholder="Họ và tên lót"/>
                            </div>
                            <div class="col-1 col-md-1"><b>-</b></div>
                            <div class="col-4 col-md-4">
                                <form:input path="lastName" id="lastName" cssClass="form-control" placeholder="Tên"/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="email" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.email"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <form:input path="email" cssClass="form-control" type="email" id="email"/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="phone" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.phone"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <form:input path="phone" type="number" cssClass="form-control" id="phone"/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="role" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.role"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <select name="roles.id" multiple class="form-control role-select2" id="role">
                                    <c:forEach items="${roles}" var="role">
                                        <option value="${role.id}"
                                                <c:forEach items="${item.roles}" var="roleSelected">
                                                    <c:if test="${role.id == roleSelected.id}">
                                                        selected
                                                    </c:if>
                                                </c:forEach>
                                        >${role.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="status" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.status"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <form:select path="status" cssClass="form-control" id="status">
                                    <form:option value="1" label="Hoạt động"/>
                                    <form:option value="0" label="Không hoạt động"/>
                                </form:select>
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="birthDate" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.birth.date"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <form:input path="birthDate" type="date" id="birthDate" cssClass="form-control"/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="address" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.address"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <form:input path="address" cssClass="form-control" id="address"/>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="country" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.country"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
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
                            <div class=" col col-md-3">
                                <label for="city" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.city"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <select id="city" name="city.id" class="form-control">
                                    <option value="">Chọn Tỉnh / Thành phố</option>
                                </select>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="district" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.district"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <select id="district" name="district.id" class="form-control">
                                    <option value="">Chọn Quận / Huyện</option>
                                </select>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class=" col col-md-3">
                                <label for="commune" class=" form-control-label">
                                    <fmt:message bundle="${lang}" key="label.commune"/>
                                </label>
                            </div>
                            <div class="col-12 col-md-9">
                                <select name="commune.id" id="commune" class="form-control">
                                    <option value="">Chọn xã / phường</option>
                                </select>
                            </div>
                        </div>

                    </div>
                </div>
                <form:input path="id" type="hidden" id="id"/>
            </form:form>
        </div>
        <div class="card-footer">
            <c:if test="${not empty item.id}">
                <button type="button" class="btn btn-primary btn-sm" id="btnAddOrUpdate">
                    <i class="fas fa-check"></i> <fmt:message key="label.employee.update" bundle="${lang}"/>
                </button>
            </c:if>
            <c:if test="${empty item.id}">
                <button type="button" class="btn btn-primary btn-sm" id="btnAddOrUpdate">
                    <i class="fas fa-check"></i> <fmt:message bundle="${lang}" key="label.employee.add"/>
                </button>
            </c:if>

            <button type="reset" class="btn btn-danger btn-sm">
                <i class="fa fa-ban"></i> Reset
            </button>
        </div>
        <div class="modal fade" id="edit-password" style="display: none; padding-right: 17px;" aria-modal="true">
            <div class="modal-dialog modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title"><fmt:message key="label.change.password"
                                                             bundle="${lang}"/></h3>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <!-- form start -->
                        <form method="POST" id="editPasswordForm">
                            <div class="form-group">
                                <label class=" form-control-label"><fmt:message key="label.password"
                                                                                bundle="${lang}"/></label>
                                <input type="password" name="password" placeholder="<fmt:message key="label.new.password"
                                                bundle="${lang}"/>" class="form-control">
                            </div>
                            <input type="hidden" name="id" value="${item.id}"/>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-outline-primary" id="btnSave"><fmt:message bundle="${lang}"
                                                                                                        key="label.update"/></button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        addressChange();
        if ($('#country').val() != "") {
            var countryValue = $('#country').val();
            var url = '<c:url value="/ajax/city/list?countryId="/>' + countryValue + "";
            $('#city').load(url, function () {
                $('#city option[value="${item.city.id}"]').attr('selected', 'selected');
                var cityValue = $('#city').val();
                var url = '<c:url value="/ajax/district/list?cityId="/>' + cityValue + "";
                $('#district').load(url, function () {
                    $('#district option[value="${item.district.id}"]').attr('selected', 'selected');
                    var districtValue = $('#district').val();
                    var url = '<c:url value="/ajax/commune/list?districtId="/>' + districtValue + "";
                    $('#commune').load(url, function () {
                        $('#commune option[value="${item.commune.id}"]').attr('selected', 'selected');
                    });
                });
            });
        }
        // $('#role-select2').on('select2:select');
    })
    $('.role-select2').select2();


    // update address on change
    function addressChange() {
        $('#country').on("change", function () {
            var countryValue = $('#country').val();
            var url = '<c:url value="/ajax/city/list?countryId="/>' + countryValue + "";
            $('#city').load(url);
            $('#district').load('<c:url value="/ajax/district/list?cityId="/>');
            $('#commune').load('<c:url value="/ajax/commune/list?districtId="/>');
        });

        $('#city').on("change", function () {
            var cityValue = $('#city').val();
            var url = '<c:url value="/ajax/district/list?cityId="/>' + cityValue + "";
            $('#district').load(url);
            $('#commune').load('<c:url value="/ajax/commune/list?districtId="/>');
        });

        $('#district').on("change", function () {
            var districtValue = $('#district').val();
            var url = '<c:url value="/ajax/commune/list?districtId="/>' + districtValue + "";
            $('#commune').load(url);
        });
    }

    //update password
    $('#btnSave').click(function (e) {
        e.preventDefault();
        var formData = $('#editPasswordForm').serializeArray();
        var data = convertToJson(formData);
        updatePassword(data);
    });

    function updatePassword(data) {
        $.ajax({
            url: '${apiUpdatePasswordUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${editEmployeeUrl}?id=" + ${item.id} +"&message=redirect_update";
            },
            error: function (error) {
                window.location.href = "${editEmployeeUrl}?id=" + ${item.id} +"&message=redirect_error";
            }
        });
    }

    // update and add new employee
    $('#btnAddOrUpdate').click(function (e) {
        e.preventDefault();
        var id = $('#id').val();
        var formData = $('#formSubmit').serializeArray();
        var data = convertToJson(formData);
        console.log(data);
        if (id != "") {
            updateEmployee(data);
        } else {
            addEmployee(data);
        }
    });

    // get data form convert to json


    //ajax add employee
    function addEmployee(data) {
        $.ajax({
            url: '${apiUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${changAvatarUrl}?id=" + result.id;
            },
            error: function (error) {
                window.location.href = "${employeeListURL}?message=redirect_error";
            }
        });
    }

    //ajax update employee
    function updateEmployee(data) {
        $.ajax({
            url: '${apiUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${editEmployeeUrl}?id=" + result + "&message=redirect_update";
            },
            error: function (error) {
                window.location.href = "${editEmployeeUrl}?id=" + ${item.id} +"&message=redirect_error";
            }
        });
    }

</script>
</body>
</html>
