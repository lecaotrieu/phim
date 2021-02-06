<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Trang chủ</title>
</head>
<body>
<section>
    <div class="container">
        <div class="banner">
            <img src="<c:url value="/template/web/img/banner.jpg"/>" alt="">

        </div>
    </div>
</section>
<section>
    <div class="container">
        <div class="content">
            <div class="content-title">
                <h2>phim đề cử</h2>
            </div>
            <hr>
            <div class="top-movies">
                <ul class="list-items">
                    <div id="demo" class="carousel slide" data-ride="carousel">
                        <ul class="carousel-indicators">
                            <li data-target="#demo" data-slide-to="0" class="active"></li>
                            <li data-target="#demo" data-slide-to="1"></li>
                            <li data-target="#demo" data-slide-to="2"></li>
                        </ul>
                        <div class="carousel-inner" role="listbox">
                            <c:forEach begin="0" end="2" var="i">
                                <div class="carousel-item <c:if test="${i==1}">active</c:if>">
                                    <c:if test="${empty film_nominate[i].image}">
                                        <a href="<c:url value="/film/${film_nominate[i].code}-${film_nominate[i].id}"/>">
                                            <img src="<c:url value="/template/image/default_poster.jpg"/>"
                                                 alt="${film_nominate[i].name}">
                                        </a>
                                    </c:if>
                                    <c:if test="${not empty film_nominate[i].image}">
                                        <a href="<c:url value="/film/${film_nominate[i].code}-${film_nominate[i].id}"/>">
                                            <img src="https://drive.google.com/uc?export=view&id=${film_nominate[i].image}"
                                                 alt="${film_nominate[i].name}">
                                        </a>
                                    </c:if>
                                    <div class="carousel-caption">
                                        <h3>${film_nominate[i].name}</h3>
                                        <p></p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <a class="carousel-control-prev" href="#demo" data-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </a>
                        <a class="carousel-control-next" href="#demo" data-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </a>

                    </div>
                </ul>
            </div>
        </div>
    </div>
</section>
<section>
    <div class="container">
        <div class="row">
            <div class="col-sm-8">
                <div class="content-title">
                    <div class="row">
                        <h2 class="col-sm-9">phim chiếu rạp mới</h2>
                        <a class="col-sm-3" href="<c:url value="/phim/phim-chieu-rap"/>">
                            <span>Xem tất cả</span><i class="fas fa-caret-right"></i>
                        </a>
                    </div>
                </div>
                <div class="main-content">
                    <div class="list-movies">
                        <ul class="row">
                            <c:forEach var="film" items="${film_chieu_rap}">
                                <c:url value="/film/${film.code}-${film.id}" var="filmUrl"></c:url>
                                <li class="col-sm-3">
                                    <a href="${filmUrl}">
                                        <div class="list-movies-items">
                                            <c:if test="${empty film.image}">
                                                <img class="thumbnail"
                                                     src="<c:url value="/template/image/default_poster.jpg"/>"
                                                     alt="">
                                            </c:if>
                                            <c:if test="${not empty film.image}">
                                                <img class="thumbnail"
                                                     src="https://drive.google.com/uc?export=view&id=${film.image}"
                                                     alt="">
                                            </c:if>
                                            <div class="phim-item-title">
                                                <h3 class="movies-name-1">${film.name}</h3>
                                                <h4 class="movies-name-2">${film.name}</h4>
                                                <p>${film.time} phút</p>
                                            </div>
                                            <span class="ribbon">${film.quality}</span>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <security:authorize access="hasRole('USER')">
                    <%@ include file="/common/web/film-follow.jsp" %>
                </security:authorize>
                <%@ include file="/common/web/right-menu-series_film.jsp" %>
            </div>
        </div>
    </div>
</section>
<section>
    <div class="container">
        <div class="row">
            <div class="col-sm-8">
                <div class="content-title">
                    <div class="row">
                        <h2 class="col-sm-9">Phim lẻ mới cập nhật</h2>
                        <a class="col-sm-3" href="<c:url value="/phim/phim-le?sort=modifiedDate&page=1"/>">
                            <span>Xem tất cả</span><i class="fas fa-caret-right"></i>
                        </a>
                    </div>
                </div>
                <div class="main-content">
                    <div class="list-movies">
                        <ul class="row">
                            <c:forEach var="film" items="${odd_film_new_update}">
                                <c:url value="/film/${film.code}-${film.id}" var="filmUrl"></c:url>
                                <li class="col-sm-3">
                                    <a href="${filmUrl}">
                                        <div class="list-movies-items">
                                            <c:if test="${empty film.image}">
                                                <img class="thumbnail"
                                                     src="<c:url value="/template/image/default_poster.jpg"/>"
                                                     alt="">
                                            </c:if>
                                            <c:if test="${not empty film.image}">
                                                <img class="thumbnail"
                                                     src="https://drive.google.com/uc?export=view&id=${film.image}"
                                                     alt="">
                                            </c:if>
                                            <div class="phim-item-title">
                                                <h3 class="movies-name-1">${film.name}</h3>
                                                <h4 class="movies-name-2">${film.name}</h4>
                                                <p>${film.time} phút</p>
                                            </div>
                                            <span class="ribbon">${film.quality}</span>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="movies-trailer" style="margin-top:0px">
                    <h2>
                        <i class="fas fa-tag"></i><span>Từ khoá nỗi bật</span>
                    </h2>
                    <div class="tag-box-content">
                        <div class="scrollDiv">
                            <ul class="tag-box">
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=tội+phạm"/> ">
                                        tội phạm
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=tình+yêu"/>">
                                        tình yêu
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=phim+ma"/>">
                                        phim ma
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=marvel"/>">
                                        marvel
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=cảnh+sát"/>">
                                        cảnh sát
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=ma+cà+rồng"/>">
                                        ma cà rồng
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=zoombie"/>">
                                        zoombie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=xác+sống"/>">
                                        xác sống
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=siêu+anh+hùng"/>">
                                        siêu anh hùng
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=người+ngoài+hành+tinh"/>">
                                        người ngoài hành tinh
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        thảm hoạ
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=trinh+thám"/>">
                                        trinh thám
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="<c:url value="/phim/tim-kiem?search=giết+người"/>">
                                        giết người
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
