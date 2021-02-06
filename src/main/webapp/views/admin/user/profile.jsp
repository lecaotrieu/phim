<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title><fmt:message bundle="${lang}" key="label.user.info"/></title>
    <link rel="stylesheet" href="<c:url value="/template/admin/user/profile.css"/>">
</head>
<body>
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href='<c:url value="/admin/trang-chu"/>'><i class="fa fa-home"></i>Trang chủ</a>
        </li>
        <li class="breadcrumb-item"><a href='<c:url value="/admin/user/list"/>'><fmt:message
                bundle="${lang}"
                key="label.user.list"/> </a>
        </li>
        <li class="breadcrumb-item active" aria-current="page">${item.userName}</li>
    </ol>
</nav>
<div class="col-12 mx-auto content-user-profile">
    <div class="row">
        <div class="col-6 info">
            <div class="row">
                <div class="col-5">
                    <c:if test="${not empty item.photo}">
                        <img class="d-block"
                             src="https://drive.google.com/uc?export=view&id=${item.photo}"
                             alt="Card image cap" style="width: 100%; height: auto; min-height: 200px;"
                             id="avatarUser">
                    </c:if>
                    <c:if test="${empty item.photo}">
                        <img class="d-block"
                             src="<c:url value="/template/image/avatar_default.jpg"/>"
                             alt="Card image cap" style="width: 100%; height: auto; min-height: 200px;"
                             id="avatarUser">
                    </c:if>
                </div>
                <div class="col-7">
                    <div class="row">
                        <div class="full-name col-8">
                            <h3>${item.firstName} ${item.lastName}</h3>
                        </div>
                        <div class="col-4">
                            <a href="<c:url value="/admin/user/edit?id=${item.id}"/>"
                               class="btn btn-outline-dark float-right"><fmt:message key="label.update"
                                                                                     bundle="${lang}"/></a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="username col-12">
                            <h3><fmt:message key="label.username" bundle="${lang}"/>: ${item.userName}</h3>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.birth.date" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.birthDate}</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.email" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.email}</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.phone" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.phone}</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.address" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.address}</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.status" bundle="${lang}"/></label>
                </div>

                <div class="col-7"><c:if test="${item.status==0}">Không </c:if>Hoạt động</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.create.date" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.createdDate}</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.people.create" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.createdBy}</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.modified.date" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.modifiedDate}</div>
            </div>
            <div class="row">
                <div class="col-5">
                    <label><fmt:message key="label.people.modified" bundle="${lang}"/></label>
                </div>
                <div class="col-7">${item.modifiedBy}</div>
            </div>
        </div>
        <div class="col-6 film-info">
            <div class="col-12">
                <nav>
                    <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <a class="col-4 nav-item nav-link active" id="nav-like-tab" data-toggle="tab" href="#nav-like"
                           role="tab" aria-controls="nav-like" aria-selected="true"><fmt:message key="label.like"
                                                                                                 bundle="${lang}"/></a>
                        <a class="col-4 nav-item nav-link" id="nav-follow-tab" data-toggle="tab" href="#nav-follow"
                           role="tab" aria-controls="nav-follow" aria-selected="false"><fmt:message key="label.follow"
                                                                                                    bundle="${lang}"/> </a>
                        <a class="col-4 nav-item nav-link" id="nav-watching-tab" data-toggle="tab" href="#nav-watching"
                           role="tab" aria-controls="nav-watching" aria-selected="false"><fmt:message
                                key="label.film.watching" bundle="${lang}"/> </a>
                    </div>
                </nav>
                <div class="tab-content" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-like" role="tabpanel" aria-labelledby="nav-like-tab">
                        <hr>
                        <div class="col-12">
                            <c:forEach items="${item.evaluates}" var="evaluate">
                                <c:if test="${evaluate.liked == 1}">
                                    <div class="row" style="margin: 20px 0px;">
                                        <div class="col-4"><a
                                                href="<c:url value="/admin/film/show?id=${evaluate.film.id}"/>">${evaluate.film.name}</a>
                                        </div>
                                        <div class="col-4"
                                             style="text-align: center;">${evaluate.watched}/${evaluate.film.episodesCount}</div>
                                        <div class="col-4">
                                            <button class="btn btn-outline-primary float-right">Bỏ thích</button>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="nav-follow" role="tabpanel" aria-labelledby="nav-follow-tab">
                        <hr>
                        <div class="col-12">
                            <c:forEach items="${item.evaluates}" var="evaluate">
                                <c:if test="${evaluate.follow == 1}">
                                    <div class="row" style="margin: 20px 0px;">
                                        <div class="col-4"><a
                                                href="<c:url value="/admin/film/show?id=${evaluate.film.id}"/>">${evaluate.film.name}</a>
                                        </div>
                                        <div class="col-4"
                                             style="text-align: center;">${evaluate.watched}/${evaluate.film.episodesCount}</div>
                                        <div class="col-4">
                                            <button class="btn btn-outline-danger float-right">Bỏ theo dõi</button>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="nav-watching" role="tabpanel" aria-labelledby="nav-watching-tab">
                        <hr>
                        <div class="col-12">
                            <c:forEach items="${item.evaluates}" var="evaluate">
                                <c:if test="${evaluate.watched > 0}">
                                    <div class="row" style="margin: 20px 0px;">
                                        <div class="col-4"><a
                                                href="<c:url value="/admin/film/show?id=${evaluate.film.id}"/>">${evaluate.film.name}</a>
                                        </div>
                                        <div class="col-4"
                                             style="text-align: center;">${evaluate.watched}/${evaluate.film.episodesCount}</div>
                                        <div class="col-4">
                                            <a class="float-right" style="cursor: pointer;"><i class="fas fa-times"></i></a>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>