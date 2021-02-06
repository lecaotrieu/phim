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
    <link rel="stylesheet" href="<c:url value="/template/admin/employee/employee.css"/>">
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
        <li class="breadcrumb-item active" aria-current="page">${item.firstName} ${item.lastName}</li>
    </ol>
</nav>
<div class="col-12 mx-auto">
    <div class="container content">
        <div class="row">
            <div class="col-3">
                <c:if test="${not empty item.photo}">
                    <img class="d-block"
                         src="https://drive.google.com/uc?export=view&id=${item.photo}"
                         alt="Card image cap"
                         id="photo-employee">
                </c:if>
                <c:if test="${empty item.photo}">
                    <img class="d-block"
                         src="<c:url value="/template/image/avatar_default.jpg"/>"
                         alt="Card image cap"
                         id="photo-employee">
                </c:if>
            </div>
            <div class="col-7">
                <h3>${item.firstName} ${item.lastName}</h3>
                <p>${item.birthDate}</p>
                <p>${item.email}</p>
                <p>${item.phone}</p>
                <p>${item.country.name}</p>
            </div>
            <div class="col-2">
                <a href="<c:url value="/admin/employee/edit?id=${item.id}"/>"
                   class="btn btn-outline-secondary float-right"><fmt:message key="label.update" bundle="${lang}"/></a>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <p>
                    <c:forEach var="role" items="${item.roles}">
                        [${role.name}]
                    </c:forEach>
                </p>
                <p><b><fmt:message key="label.address" bundle="${lang}"/></b>: ${item.address}</p>
                <p><b><fmt:message key="label.commune" bundle="${lang}"/></b>: ${item.commune.name}</p>
                <p><b><fmt:message key="label.district" bundle="${lang}"/></b>: ${item.district.name}</p>
                <p><b><fmt:message key="label.city" bundle="${lang}"/></b>: ${item.city.name}</p>
                <p><b><fmt:message key="label.create.date" bundle="${lang}"/></b>: ${item.createdDate}</p>
                <p><b><fmt:message key="label.people.create" bundle="${lang}"/></b>: ${item.createdBy}</p>
                <p><b><fmt:message key="label.modified.date" bundle="${lang}"/></b>: ${item.modifiedDate}</p>
                <p><b><fmt:message key="label.people.modified" bundle="${lang}"/></b>: ${item.modifiedBy}</p>
                <p><b><fmt:message key="label.status" bundle="${lang}"/></b>: <c:if
                        test="${item.status == 1}">Hoạt động</c:if><c:if test="${item.status==0}">Không hoạt động</c:if>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
