<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/ajax/admin/film/list" var="episodeListUrl">
    <c:param name="filmId" value="${item.id}"></c:param>
</c:url>
<c:url value="/api/admin/film/episode" var="apiDeleteUrl"></c:url>
<c:url value="/ajax/admin/comment/list" var="commentListUrl">
    <c:param name="page" value="1"/>
    <c:param name="limit" value="10"/>
    <c:param name="filmId" value="${item.id}"/>
    <c:param name="sortExpression" value="createdDate"/>
    <c:param name="sortDirection" value="0"/>
</c:url>
<html>
<head>
    <title><fmt:message bundle="${lang}" key="label.film.info"/></title>
    <link rel="stylesheet" href="<c:url value="/template/admin/css/profile.css"/>">
</head>
<body>
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href='<c:url value="/admin/trang-chu"/>'><i class="fa fa-home"></i>Trang chủ</a>
        </li>
        <li class="breadcrumb-item"><a href='<c:url value="/admin/film/list"/>'>
            <fmt:message bundle="${lang}"
                         key="label.film.list"/> </a>
        </li>
        <li class="breadcrumb-item active" aria-current="page">${item.name}</li>

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
    <div class="col-11 mx-auto emp-profile">
        <form method="post">
            <div class="row">
                <div class="col-md-4">
                    <div class="profile-img">
                        <c:if test="${not empty item.image}">
                            <img src="https://drive.google.com/uc?export=view&id=${item.image}" alt=""/>
                        </c:if>
                        <c:if test="${empty item.image}">
                            <img src="<c:url value="/template/image/default_poster.jpg"/>" alt=""/>
                        </c:if>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-9">
                            <div class="profile-head">
                                <h5>
                                    ${item.name}
                                </h5>
                                <div>
                                    <c:forEach items="${item.categories}" var="category">
                                        <span class="category-film">${category.name}</span>
                                    </c:forEach>
                                </div>
                                <div>
                                    <c:forEach items="${item.actors}" var="actor">
                                        <span class="film-actor">${actor.name}</span>
                                    </c:forEach>
                                </div>
                                <p class="proile-rating">RANKINGS : <span>${item.scores}/10</span></p>
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home"
                                           role="tab"
                                           aria-controls="home" aria-selected="true">About</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="description-tab" data-toggle="tab" href="#description"
                                           role="tab"
                                           aria-controls="profile" aria-selected="false">Tóm tắt</a>
                                    </li>
                                    <li class="nav-item" id="episode-list">
                                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile"
                                           role="tab"
                                           aria-controls="profile" aria-selected="false">Tập phim</a>
                                    </li>
                                    <li class="nav-item" id="comment-list">
                                        <a class="nav-link" id="comment-tab" data-toggle="tab" href="#comment"
                                           role="tab"
                                           aria-controls="profile" aria-selected="false">Bình luận</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="<c:url value="/admin/film/edit?id=${item.id}"/>"
                               class="profile-edit-btn btn btn-primary" style="margin-bottom: 20px;">Edit Film</a>
                            <a href="<c:url value="/admin/film/trailer?id=${item.id}"/>"
                               class="profile-edit-btn btn btn-danger" style="margin-bottom: 20px;">Chỉnh sửa
                                trailer</a>
                            <a href="<c:url value="/admin/film/${item.code}-${item.id}"/>"
                               class="profile-edit-btn btn btn-success">Thêm Tập Phim</a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tab-content profile-tab" id="myTabContent">
                                <div class="tab-pane fade show active" id="home" role="tabpanel"
                                     aria-labelledby="home-tab">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Film Id</label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.id}</p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Name</label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.name}</p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Code</label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.code}</p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Thời lượng</label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.time}</p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label><fmt:message bundle="${lang}" key="label.language"/></label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.language}</p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Country</label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.country.name}</p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label>Chất lượng</label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.quality}</p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label><fmt:message bundle="${lang}" key="label.status"/></label>
                                        </div>
                                        <div class="col-md-6">
                                            <c:if test="${item.status ==1}"><p>Hoạt động</p></c:if>
                                            <c:if test="${item.status ==0}"><p>Không hoạt động</p></c:if>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label><fmt:message bundle="${lang}" key="label.film.type"/></label>
                                        </div>
                                        <div class="col-md-6">
                                            <p>${item.filmType.name}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="description" role="tabpanel"
                                     aria-labelledby="profile-tab">
                                    <div class="row">
                                        <div class="col-md-12">${item.description}</div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                </div>
                                <div class="tab-pane fade" id="comment" role="tabpanel" aria-labelledby="comment-tab">
                                    <div id="comment-li">

                                    </div>
                                    <ul class="pagination" id="pagination"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script>

    $('#episode-list').click(function () {
        $('#profile').load('${episodeListUrl}');
    });
    $('#comment-list').click(function () {
        $('#comment-li').load('${commentListUrl}');
    });

    function deleteEpisode(id) {
        var data = [id];
        $.ajax({
            url: '${apiDeleteUrl}',
            type: 'DELETE',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function (result) {
                $('#profile').load('${episodeListUrl}');
            },
            error: function (result) {
            }
        });
    }
</script>
</body>
</html>
