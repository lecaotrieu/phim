<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<security:authorize access="hasRole('USER')">
    <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"></c:set>
</security:authorize>
<html>
<head>
    <title>Đổi ảnh đại diện</title>
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
                    <div class="col-12">
                        <c:if test="${param.change_success!=null}">
                            <div class="alert alert-block alert-success">
                                <button type="button" class="close" data-dismiss="alert">
                                    <i class="ace-icon fa fa-times"></i>
                                </button>
                                Chỉnh sửa thành công !
                            </div>
                        </c:if>
                        <c:if test="${param.change_error!=null}">
                            <div class="alert alert-block alert-success">
                                <button type="button" class="close" data-dismiss="alert">
                                    <i class="ace-icon fa fa-times"></i>
                                </button>
                                Chỉnh sửa thất bại !
                            </div>
                        </c:if>
                    </div>
                    <div class="col-8 mx-auto">

                        <form action="<c:url value="/api/user/photo"/>" method="post" enctype="multipart/form-data">
                            <div class="avatar">
                                <c:if test="${not empty user.photo}">
                                    <img src="https://drive.google.com/uc?export=view&id=${user.photo}" id="avatar-img"
                                         alt="" height="400px">
                                </c:if>
                                <c:if test="${empty user.photo}">
                                    <img src="<c:url value="/template/image/avatar_default.jpg"/>" id="avatar-img"
                                         alt="" height="400px">
                                </c:if>
                            </div>
                            <input type="file" name="img" id="img" accept="image/*"
                                   onchange="readURL(this,'avatar-img')" style="color: #fff">
                            <button class="btn btn-primary">Thay đổi</button>
                            <input type="hidden" value="${user.id}" name="id">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
