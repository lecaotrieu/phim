<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title><dec:title/></title>
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/template/web/img/logo.png"/> " >
    <link rel="stylesheet" href="<c:url value="/template/fontawesome-5.12.1/css/fontawesome.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/template/fontawesome-5.12.1/css/all.css"/>">
    <link rel="stylesheet" href="<c:url value="/template/bootstrap-4.5.2-dist/css/bootstrap.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/template/admin/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/template/admin/css/side-navigation.css"/>">
    <link href="<c:url value="/template/selectize.js-master/dist/css/select2.css"/>" rel="stylesheet">
    <script src="<c:url value="/template/selectize.js-master/dist/css/selectize.bootstrap3.css"/>"></script>
    <!-- jQuery -->
    <script src="<c:url value="/template/admin/jquery/jquery.min.js"/>"></script>
    <link href="<c:url value="/template/admin/css/pagination-custom.css"/>" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="<c:url value="/template/selectize.js-master/dist/js/select2.js"/>"></script>
    <script src="<c:url value="/template/selectize.js-master/dist/js/standalone/selectize.js"/>"></script>
    <!-- sweetalert -->
    <link rel="stylesheet" href="<c:url value="/template/admin/sweetalert2/sweetalert2.min.css"/>">
    <dec:head/>
    <script type='text/javascript' src='<c:url value="/template/admin/sweetalert2/sweetalert2.min.js"/>'></script>
    <script src="<c:url value='/template/paging/jquery.twbsPagination.js'/>"></script>
    <script src="<c:url value="/template/ckeditor/ckeditor.js"/>"></script>
</head>
<body>
<%@include file="/common/admin/header.jsp" %>
<div class="container-fluid" style="margin-top: 56px">
    <%@include file="/common/admin/menu.jsp" %>
    <div id="main" class="active" style="margin-bottom: 80px;">
        <dec:body/>
    </div>
    <footer class="fixed-bottom navbar bg-dark align-content-center" style="height: 70px;color: white">
        <span style="width: fit-content" class="mx-auto">Welcome Admin page</span>
    </footer>
</div>
<script src='<c:url value="/template/fontawesome-5.12.1/js/fontawesome.min.js"/>'></script>
<script src="<c:url value="/template/bootstrap-4.5.2-dist/js/bootstrap.min.js"/>"></script>
<script src='<c:url value="/template/admin/js/side-navigation.js"/>'></script>
<script src='<c:url value="/template/admin/js/convert-json.js"/>'></script>
<script>
    function closeAndOpenNav() {
        if ($('#mySidenav').hasClass("active")) {
            closeNav();
        } else {
            openNav();
        }
    }

    function showAlertAfterSuccess(x) {
        swal("Thành công!", "Cập nhật thành công", "success").then(function (isConfirm) {
            if (isConfirm) {
                if (x != undefined) {
                    x();
                }
            }
        });
    }

    function showAlertBeforeDelete(callback) {
        swal({
            title: "Xác nhận xóa",
            text: "Bạn có chắc muốn xóa những dữ liệu đã chọn !",
            type: "warning",
            showCancelButton: true,
            confirmButtonText: "Xác nhận",
            cancelButtonText: "Hủy bỏ",
            confirmButtonClass: "btn btn-success",
            cancelButtonClass: "btn btn-danger"
        }).then(function (isConfirm) {
            if (isConfirm) {
                callback();
            }
        })
    }
    function showAlertLoading() {
        swal({
            title: "Đang cập nhật...",
            text: "Làm ơn chờ một lát",
            imageUrl: "<c:url value="/template/image/loading.gif"/>",
            showConfirmButton: false,
            allowOutsideClick: false,
        });
    }

    function readURL(input, imageId) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageId).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    function readVideo(input, videoId) {
        if (input.files && input.files[0]) {
            var $source = $('#' + videoId);
            $source[0].src = URL.createObjectURL(input.files[0]);
            $source.parent()[0].load();
        }
    }
</script>
</body>
</html>
