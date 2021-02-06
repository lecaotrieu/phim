<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Đổi mật khẩu</title>
    <link rel="stylesheet" href="<c:url value="/template/web/css/user_info.css"/>">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-4">
            <h4 class="menu-header"><i class="fas fa-star"></i> Menu</h4>
            <div class="menu">
                <div class="vertical-menu">
                    <a href="<c:url value="/chinh-sua-trang-ca-nhan/cap-nhat-thong-tin"/>">Cập nhật thông tin cá
                        nhân</a>
                    <a href="<c:url value="/chinh-sua-trang-ca-nhan/doi-avatar"/>">Thay đổi ảnh đại diện</a>
                    <a href="<c:url value="/chinh-sua-trang-ca-nhan/doi-mat-khau"/>">Đổi mật khẩu</a>
                </div>
            </div>
        </div>
        <div class="col-8">
            <div class="user-st">
                <div class="row">
                    <div class="col-8 mx-auto">
                        <h4 class="content-header">Đổi mật khẩu</h4>
                        <form action="" id="formChangePass" method="post">
                            <div class="form-group">
                                <label class="small mb-1" for="ip-oldPass"><fmt:message bundle="${lang}"
                                                                                        key="label.password.old"/></label>
                                <input class="form-control py-4" id="ip-oldPass" type="password"
                                       name="password"
                                       placeholder="Nhập mật khẩu cũ"/>
                            </div>
                            <div class="form-group">
                                <label class="small mb-1" for="ip-newPass"><fmt:message bundle="${lang}"
                                                                                        key="label.password.new"/> </label>
                                <input class="form-control py-4" id="ip-newPass" type="password"
                                       name="newPassword"
                                       placeholder="Nhập mật khẩu mới"/>
                            </div>
                            <div class="form-group">
                                <label class="small mb-1" for="ip-newPassCf"><fmt:message bundle="${lang}"
                                                                                          key="label.password.new"/> </label>
                                <input class="form-control py-4" id="ip-newPassCf" type="password"
                                       name="confirmPassword"
                                       placeholder="Nhập lại mật khẩu mới"/>
                            </div>
                            <div class="form-group d-flex align-items-center justify-content-between">
                                <button class="btn btn-primary" id="btn-change-pass"><fmt:message bundle="${lang}"
                                                                                                  key="label.change.password"/></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    <c:url value="/api/user/password" var="apiChangePassUrl"/>

    function changePassword(data) {
        $.ajax({
            url: '${apiChangePassUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "/dang-nhap?change_password_success";
            },
            error: function (error) {
                window.location.href = "/chinh-sua-trang-ca-nhan/doi-mat-khau/?change_password_error";
            }
        });
    }

    $('#btn-change-pass').click(function (e) {
        e.preventDefault();
        var formData = $('#formChangePass').serializeArray();
        var data = convertToJson(formData);
        changePassword(data);
    });
</script>
</body>
</html>
