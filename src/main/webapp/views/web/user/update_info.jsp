<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Cập nhật thông tin</title>
    <link rel="stylesheet" href="<c:url value="/template/web/css/user_info.css"/>">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-4">
            <h4 class="menu-header"><i class="fas fa-star"></i> Menu</h4>
            <div class="menu">
                <div class="vertical-menu">
                    <a href="<c:url value="/chinh-sua-trang-ca-nhan/cap-nhat-thong-tin"/>">Cập nhật thông tin cá nhân</a>
                    <a href="<c:url value="/chinh-sua-trang-ca-nhan/doi-avatar"/>">Thay đổi ảnh đại diện</a>
                    <a href="<c:url value="/chinh-sua-trang-ca-nhan/doi-mat-khau"/>">Đổi mật khẩu</a>
                </div>
            </div>
        </div>
        <div class="col-8">
            <div class="user-st">
                <div class="row">
                    <div class="col-8 mx-auto">
                        <h4 class="content-header">Cập nhật thông tin</h4>
                        <form action="<c:url value="/api/admin/user"/>" id="form-user" method="put">
                            <div class="form-group">
                                <label class="small mb-1" for="ip-phone"><fmt:message bundle="${lang}"
                                                                                      key="label.full.name"/> </label>
                                <div class="row" style="margin: 0; color: #fff;">
                                    <input class="form-control py-4 col-6" id="inputFirstName" type="text" value="${item.firstName}"
                                           name="firstName"
                                           placeholder="Nhập họ và tên lót"/>
                                    <p class="col-1 text-center">-</p>
                                    <input class="form-control col-5 py-4" id="inputLastName" value="${item.lastName}" type="text"
                                           name="lastName"
                                           placeholder="Nhập tên"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="small mb-1" for="ip-email"><fmt:message bundle="${lang}"
                                                                                        key="label.email"/></label>
                                <input class="form-control py-4" id="ip-email" type="email" value="${item.email}"
                                       name="email"
                                       placeholder="Nhập mật email"/>
                            </div>
                            <div class="form-group">
                                <label class="small mb-1" for="ip-phone"><fmt:message bundle="${lang}"
                                                                                        key="label.phone"/> </label>
                                <input class="form-control py-4" id="ip-phone" type="number" value="${item.phone}"
                                       name="phone"
                                       placeholder="Nhập số điện thoại"/>
                            </div>
                            <div class="form-group">
                                <label class="small mb-1" for="ip-address"><fmt:message bundle="${lang}"
                                                                                          key="label.address"/> </label>
                                <input class="form-control py-4" id="ip-address" type="text" value="${item.address}"
                                       name="address"
                                       placeholder="Nhập địa chỉ"/>
                            </div>
                            <div class="form-group">
                                <label class="small mb-1" for="ip-birthDate"><fmt:message bundle="${lang}"
                                                                                        key="label.birth.date"/> </label>
                                <input class="form-control py-4" id="ip-birthDate" type="date" value="${item.birthDate}"
                                       name="birthDate"/>
                            </div>
                            <div class="form-group d-flex align-items-center justify-content-between">
                                <button class="btn btn-primary" id="btn-submit"><fmt:message bundle="${lang}"
                                                                                                  key="label.update"/></button>
                            </div>
                            <input type="hidden" name="status" value="${item.status}">
                            <input type="hidden" name="userName" value="${item.userName}">
                            <input type="hidden" name="photo" value="${item.photo}">
                            <input type="hidden" name="id" value="${item.id}">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<c:url value="/api/user" var="apiUrl"/>
<script>
    function updateUser(data) {
        $.ajax({
            url: '${apiUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "/chinh-sua-trang-ca-nhan/cap-nhat-thong-tin?register_success";
            },
            error: function (error) {
                window.location.href = "/chinh-sua-trang-ca-nhan/cap-nhat-thong-tin?register_error";
            }
        });
    }

    $('#btn-submit').click(function (e) {
        e.preventDefault();
        var formData = $('#form-user').serializeArray();
        var data = convertToJson(formData);
        updateUser(data);
    });
</script>
</body>
</html>
