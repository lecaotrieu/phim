<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/admin/employee/list" var="employeeListUrl"/>
<c:set value="<%=SecurityUtils.getPrincipal().getId()%>" var="SessionID"/>
<c:if test="${SessionID == item.id}">
    <c:url value="/api/admin/personal/photo" var="urlSubmit"></c:url>
</c:if>
<c:if test="${SessionID != item.id}">
    <c:url value="/api/admin/employee/photo" var="urlSubmit"></c:url>
</c:if>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title><fmt:message key="label.edit.avatar.change" bundle="${lang}"/></title>
    <link rel="stylesheet" href="<c:url value="/template/admin/css/avatar-custom.css"/>">
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
        <li class="breadcrumb-item active" aria-current="page"><fmt:message bundle="${lang}"
                                                                            key="label.edit.avatar.change"/></li>
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
                <fmt:message bundle="${lang}" key="label.edit.avatar.change"/>
            </strong>
        </div>
        <div class="card-body card-block">
            <form action="${urlSubmit}" method="post" class="col-8" id="form-avatar"
                  enctype="multipart/form-data">
                <div class="col-10 mx-auto">
                    <label class=" form-control-label">
                        <b><fmt:message bundle="${lang}" key="label.username"/>:</b>
                    </label>
                    <label class=" form-control-label">${item.userName}</label>
                    <c:if test="${not empty item.photo}">
                        <c:set value="https://drive.google.com/uc?export=view&id=${item.photo}"
                               var="imgUrl"/>
                    </c:if>
                    <c:if test="${empty item.photo}">
                        <c:url value="/template/image/avatar_default.jpg" var="imgUrl"/>
                    </c:if>
                    <img class="d-block"
                         src="${imgUrl} " alt="Card image cap"
                         id="avatarUser">
                    <input type="file" name="img" id="img" accept="image/*" onchange="readURL(this,'avatarUser')">
                </div>
                <input type="hidden" value="${item.id}" name="id">

            </form>
        </div>
        <div class="card-footer">
            <button class="btn btn-primary btn-sm" id="btn-update">
                <i class="fas fa-check"></i><fmt:message key="label.update" bundle="${lang}"/>
            </button>
            <button class="btn btn-success btn-sm float-right" id="btn-ignore">
                <fmt:message key="label.ignore" bundle="${lang}"/>
            </button>
        </div>
    </div>
</div>

<script>
    $('#btn-update').click(function () {
        $('#form-avatar').submit();
    });

    $('#btn-ignore').click(function () {
        window.location.href = "${employeeListUrl}";
    })
</script>
</body>
</html>