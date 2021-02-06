<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Cài đặt trang cá nhân</title>
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
                    <img src="/repository/1" alt="">
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
