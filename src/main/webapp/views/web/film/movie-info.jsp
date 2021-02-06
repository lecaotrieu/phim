<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/ajax/comment/edit" var="commentEditAjaxUrl">
    <c:param name="filmId" value="${film.id}"/>
</c:url>
<c:url value="/ajax/comment/list" var="commentListAjaxUrl">
    <c:param name="filmId" value="${film.id}"/>
    <c:param name="sortDirection" value="0"/>
    <c:param name="limit" value="10"/>
</c:url>
<html>
<head>
    <title>Phim ${film.name}</title>
    <link rel="stylesheet" href="<c:url value="/template/web/css/movie-info.css"/>">
</head>
<body>
<section>
    <div class="container">
        <div class="title-link">
            <p class="link">
                <a href="<c:url value="/phim/${film.filmType.code}"/>"><span>${film.filmType.name}   / </span></a>
                <a href="<c:url value="/phim/the-loai/${film.categories.get(0).code}"/> ">
                    <span>${film.categories.get(0).name} / </span></a>
                <span>${film.name}</span>
            </p>
        </div>
    </div>
</section>
<section>
    <div class="container">
        <div class="row">
            <div class="col-8">
                <div class="movie-info">
                    <div class="block-movie-info movie-info-box">
                        <div class="row">
                            <div class="col-6 movie-image">
                                <div class="movie-l-img">
                                    <c:if test="${empty film.image}">
                                        <img alt="${film.name}"
                                             src="<c:url value="/template/image/default_poster.jpg"/>">
                                    </c:if>
                                    <c:if test="${not empty film.image}">
                                        <img alt="${film.name}"
                                             src="https://drive.google.com/uc?export=view&id=${film.image}">
                                    </c:if>
                                    <ul class="btn-block">
                                        <li class="item">
                                            <c:if test="${evaluate.follow == '1'}">
                                                <button id="btn-follow" onclick="btnFollowClick()"
                                                        class="btn btn-outline-primary">Đã theo dõi
                                                </button>
                                            </c:if>
                                            <c:if test="${evaluate.follow != '1'}">
                                                <button id="btn-follow" onclick="btnFollowClick()"
                                                        title="Xem phim ${film.name}" class="btn btn-primary">Theo dõi
                                                </button>
                                            </c:if>
                                        </li>
                                        <li class="item"><a id="btn-film-download" class="btn btn-success btn"
                                                            title="Download phim ${film.name}"
                                                            href="#">Download</a>
                                        </li>
                                        <li class="item"><a id="btn-film-watch" class="btn btn-danger"
                                                            title="Xem phim ${film.name}"
                                                            href="<c:url value="/film/${film.code}-${film.id}/1"/>">Xem
                                            phim</a></li>

                                    </ul>
                                </div><!-- Bookmark-->
                                <div class="tools-box">
                                    <div class="tools-box-bookmark normal" data-filmid="9271" style="display: block;"
                                         data-added="false"><span class="bookmark-status"></span><span
                                            class="bookmark-action"></span></div>
                                </div><!-- // Bookmark-->
                                <div class="action" style="display:none">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-a dropdown-toggle" data-toggle="dropdown">
                                            <span class="caret"></span></button>
                                        <ul class="dropdown-menu" role="menu"></ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 movie-detail">
                                <h1 class="movie-title">
                                    <span class="title-1">
                                    <a class="title-1"
                                       href="#">${film.name}</a>
                                    </span>
                                    <span class="title-2">${film.name}</span>
                                    <span class="title-year"> (2020)</span></h1>
                                <div class="slimScrollDiv"
                                     style="position: relative; overflow: hidden; width: auto; height: 270px;">
                                    <div class="movie-meta-info" style="overflow: hidden; width: auto; height: 270px;">
                                        <dl class="movie-dl">
                                            <dt class="movie-dt">Trạng thái:</dt>
                                            <c:if test="${film.status == 0}">
                                                <dd class="movie-dd status">Không hoạt động</dd>
                                            </c:if>
                                            <c:if test="${film.status == 1}">
                                                <dd class="movie-dd status">Hoạt động</dd>
                                            </c:if>
                                            <br>
                                            <dt class="movie-dt">Đạo diễn:</dt>
                                            <dd class="movie-dd dd-director">
                                                <span>
                                                    <a class="director" href="#"
                                                       title="Kazuaki Imai">${film.director.name}</a>
                                                </span>,
                                            </dd>
                                            <br>
                                            <dt class="movie-dt">Quốc gia:</dt>
                                            <dd class="movie-dd dd-country">
                                                <a class="country"
                                                   href="<c:url value="/phim/quoc-gia/${film.country.code}"/>"
                                                   title="Phim Nhật Bản">${film.country.name}</a>,
                                            </dd>
                                            <br>
                                            <dt class="movie-dt">Năm:</dt>
                                            <dd class="movie-dd"><a title="Phim mới ${film.year}"
                                                                    href="<c:url value="/phim/nam-${film.year}"/>">${film.year}</a>
                                            </dd>
                                            <br>
                                            <dt class="movie-dt">Thời lượng:</dt>
                                            <dd class="movie-dd">${film.time} phút</dd>
                                            <br>
                                            <dt class="movie-dt">Chất lượng:</dt>
                                            <dd class="movie-dd">${film.quality}</dd>
                                            <br>
                                            <dt class="movie-dt">Ngôn ngữ:</dt>
                                            <dd class="movie-dd">${film.language}</dd>
                                            <br>
                                            <dt class="movie-dt">Thể loại:</dt>
                                            <dd class="movie-dd dd-cat">
                                                <c:forEach var="category" items="${film.categories}">
                                                    <a class="category"
                                                       href="<c:url value="/phim/the-loai/${category.code}"/>"
                                                       title="Phim ${category.name}">Phim ${category.name}</a>,
                                                </c:forEach>
                                            </dd>
                                            <br>
                                            <dt class="movie-dt">Công ty SX:</dt>
                                            <dd class="movie-dd">${film.employee.firstName} ${film.employee.lastName}</dd>
                                            <br>
                                        </dl>
                                        <div class="clear"></div>
                                    </div>
                                    <div class="slimScrollBar ui-draggable"
                                         style="background: rgb(85, 85, 85); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: block; border-radius: 7px; z-index: 99; right: 1px; height: 209.483px;"></div>
                                    <div class="slimScrollRail"
                                         style="width: 7px; height: 100%; position: absolute; top: 0px; display: block; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div>
                                </div>
                                <div class="box-rating vote" data-itemscope="" data-itemtype="https://schema.org/Movie">
                                    <p>Đánh giá phim <!-- span class="num-rating">(15077 lượt)</span --></p>
                                    <input type="hidden" name="vote" value="" id="vote-ip">
                                    <i class="far fa-star star-vote" data-value="1"></i>
                                    <i class="far fa-star star-vote" data-value="2"></i>
                                    <i class="far fa-star star-vote" data-value="3"></i>
                                    <i class="far fa-star star-vote" data-value="4"></i>
                                    <i class="far fa-star star-vote" data-value="5"></i>
                                    <i class="far fa-star star-vote" data-value="6"></i>
                                    <i class="far fa-star star-vote" data-value="7"></i>
                                    <i class="far fa-star star-vote" data-value="8"></i>
                                    <i class="far fa-star star-vote" data-value="9"></i>
                                    <i class="far fa-star star-vote" data-value="10"></i>
                                    <button class="btn btn-primary" id="vote-btn">Đánh giá</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <article class="block-movie-content" id="film-content-wrapper">
                    <h2 class="movie-detail-h2">Nội dung phim</h2>
                    <div class="content" id="film-content" style="max-height: 800px;"><p></p>
                        <div>
                            <div>
                                <div>
                                    <div style="text-align: justify;">${film.description}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <p></p></div>
                </article>
                <c:if test="${not empty film.trailer}">
                    <div class="block-movie-content">
                        <h2 class="movie-detail-h2">Trailer</h2>
                        <video class="video" controls id="video-trailer">
                            <source src=https://drive.google.com/uc?export=view&id=${film.trailer}" type="video/mp4">
                        </video>
                    </div>
                </c:if>
                <div class="comments">
                    <h2 class="movie-detail-h2">Bình luận về phim</h2>
                    <div class="comments-title">
                        <div class="comment-form">

                        </div>
                        <div class="comment-list">

                        </div>
                        <input type="hidden" name="page" value="0" id="page">
                        <div class="row">
                            <button class="btn btn-primary col-11 mx-auto" id="comment-next">Xem thêm</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <security:authorize access="hasRole('USER')">
                    <%@ include file="/common/web/film-follow.jsp" %>
                </security:authorize>
                <%@ include file="/common/web/right-menu-trailer.jsp" %>
                <%@ include file="/common/web/right-menu-series_film.jsp" %>
            </div>
        </div>
        <security:authorize access="hasRole('USER')">
            <form action="<c:url  value="/api/evaluate"/>" id="form-evaluate" method="post">
                <input type="hidden" value="${evaluate.id}" name="id" id="evaluateId">
                <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"></c:set>
                <input type="hidden" name="user.id" value="${user.id}">
                <input type="hidden" name="film.id" value="${film.id}">
                <input type="hidden" id="ip-like" value="${evaluate.liked}" name="liked">
                <input type="hidden" id="ip-follow" value="${evaluate.follow}" name="follow">
                <input type="hidden" id="ip-watched" value="${evaluate.watched}" name="watched">
                <input type="hidden" id="ip-scores" value="${evaluate.scores}" name="scores">
                <input type="hidden" id="ip-status" value="1" name="status">
            </form>
        </security:authorize>
    </div>
</section>
<script>
    $(document).ready(function () {
        var i = "${evaluate.liked}";
        if (i == "1") {
            $('#btn-like').addClass("liked");
        }
        loadComment();
        voteInit();
    });
    $('#comment-next').click(function () {
        loadListComment();
    });

    function loadListComment() {
        var page = Number($('#page').val());
        page += 1;
        var url = "${commentListAjaxUrl}&page=" + page;
        $.ajax({
            url: url,
            type: "GET",
            contentType: 'html',
            success: function (html) {
                $('.comment-list').append(html);
                $('#page').val(page);
            },
            error: function (error) {
            }
        });
    }

    function loadComment() {
        $('.comment-form').load("${commentEditAjaxUrl}");
        loadListComment();
    }

    function voteInit() {
        $('.vote').contents().filter(function () {
            return this.nodeType === 3;
        }).remove();
        $('.vote').attr('unselectable', 'on').css({
            '-moz-user-select': '-moz-none',
            '-moz-user-select': 'none',
            '-o-user-select': 'none',
            '-khtml-user-select': 'none',
            '-webkit-user-select': 'none',
            '-ms-user-select': 'none',
            'user-select': 'none'
        }).bind('selectstart', function () {
            return false;
        });
        <c:if test="${not empty evaluate.scores}">
        var scores = ${evaluate.scores};
        if (scores > 0 && scores <= 10) {
            voteFilmValue(scores);
        }
        </c:if>
    }

    $('#vote-btn').click(function () {
        var id = "${user.id}";
        if (id != "") {
            var url = "<c:url value="/api/evaluate/scores"/>";
            formSubmit(url);
        }
    });

    $('.vote .star-vote').click(function () {
        var value = $(this).attr("data-value");
        voteFilmValue(value);
        $('#ip-scores').val(value);
    });

    $('.vote .star-vote').mouseup(function () {
        var value = $(this).attr("data-value");
        voteFilmValue(value);
        $('#ip-scores').val(value);
    });

    function voteFilmValue(value) {
        for (var i = 0; i <= value; i++) {
            var a = ".vote .star-vote[data-value=" + i + "]";
            $(a).removeClass("far");
            $(a).addClass("fas");
        }
        var n = $('.vote .star-vote').length;
        for (var i = n; i > value; i--) {
            var a = ".vote .star-vote[data-value=" + i + "]";
            $(a).removeClass("fas");
            $(a).addClass("far");
        }
    }

    function btnFollowClick() {
        var id = "${user.id}";
        if (id != "") {
            var follow = $('#ip-follow').val();
            var url = $('#form-evaluate').attr("action");
            if (follow == "1") {
                $('#ip-follow').val("0");
                $('#btn-follow').removeClass("btn-outline-primary");
                $('#btn-follow').addClass("btn-primary");
                $('#btn-follow').html('Theo dõi');
                formSubmit(url);
            } else {
                $('#ip-follow').val("1");
                $('#btn-follow').addClass("btn-outline-primary");
                $('#btn-follow').removeClass("btn-primary");
                $('#btn-follow').html('Đã theo dõi');
                formSubmit(url);
            }
        }
    }


    function formSubmit(url) {
        if ($('#form-evaluate').val() != undefined) {
            var formData = $('#form-evaluate').serializeArray();
            var data = convertToJson(formData);
            var method;
            if (data.id == "") {
                method = "post";
            } else {
                method = "put";
            }
            evaluateApi(data, url, method);
        }
    }

    <c:url value="/api/evaluate" var="apiEvaluateLike"></c:url>

    function evaluateApi(data, url, method) {
        $.ajax({
            url: url,
            type: method,
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                $('#evaluateId').val(result);
            },
            error: function (error) {
            }
        });
    }
</script>
</body>
</html>
