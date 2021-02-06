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
    <title>${film.name}</title>
</head>
<body>
<section>
    <div class="container">
        <div class="banner">
        </div>
        <div class="title-link">
            <p class="link">
                <a href="<c:url value="/phim/${film.filmType.code}"/>"><span>${film.filmType.name}   / </span></a>
                <a href="<c:url value="/phim/the-loai/${film.categories.get(0).code}"/> ">
                    <span>${film.categories.get(0).name} / </span></a>
                <a href="<c:url value="/film/${film.code}-${film.id}"/>"> <span>${film.name}  / </span></a>
                <span>XEM PHIM  </span>
            </p>

        </div>
    </div>
</section>
<section>
    <div class="container">
        <div class="row">
            <div class="col-sm-8">
                <div class="list ">
                    <div class="row" href="#">
                        <div class="col-sm-3 thumb">
                            <div class="image-film">
                                <c:if test="${empty film.image}">
                                    <img src="<c:url value="/template/image/default_poster.jpg"/>"
                                         alt="">
                                </c:if>
                                <c:if test="${not empty film.image}">
                                    <img src="https://drive.google.com/uc?export=view&id=${film.image}"
                                         alt="">
                                </c:if>
                            </div>
                            <div class="noidung">
                                <a href="<c:url value="/film/${film.code}-${film.id}"/>">
                                    <h3>Xem trailer</h3>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <p class="list-top-movie-item-vn1">${film.name}</p>
                            <p class="list-top-movie-item-en1">${film.director.name}</p>
                            <div class="movies-content">
                                <p>
                                    ${film.description}
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <c:if test="${not empty episode.id}">
                                <c:set value="https://drive.google.com/uc?export=view&id=${episode.episodeId}"
                                       var="videoUrl"/>
                            </c:if>
                            <video class="video" controls id="video-ep">
                                <source src="${videoUrl}" type="video/mp4">
                            </video>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 button">
                            <c:forEach var="episodex" items="${film.episodes}">
                                <a href="<c:url value="/film/${film.code}-${film.id}/${episodex.episodeCode}"/>"
                                   class="btn btn-danger <c:if test="${episode.id == episodex.id}">active</c:if>">
                                        ${episodex.episodeCode}
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 button">
                            <div id="btn-like">
                                <button class="btn" onclick="btnLikeClick()"><i class="fas fa-thumbs-up"></i>LIKE
                                </button>
                            </div>
                            <div>
                                <c:if test="${evaluate.follow == '1'}">
                                    <button id="btn-follow" onclick="btnFollowClick()" class="btn btn-success"> Đã thêm
                                        vào tủ phim
                                    </button>
                                </c:if>
                                <c:if test="${evaluate.follow != '1'}">
                                    <button id="btn-follow" onclick="btnFollowClick()" class="btn"><i
                                            class="fas fa-plus"></i> Thêm vào tủ phim
                                    </button>
                                </c:if>
                            </div>
                            <div>
                                <button class="btn"><i class="fas fa-download"></i> Download</button>
                            </div>
                            <div>
                                <button id="btn-fullScreen" class="btn"><i class="fas fa-expand"></i> Phóng to</button>
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
                    <div class="rate vote">
                        <h4>Đánh giá phim <span>(${film.totalVote} lượt)</span></h4>
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
                    <div class="comments">
                        <h4>Bình luận về phim</h4>
                        <div class="comments-title">
                            <div class="comment-form">

                            </div>
                            <div class="comment-list">

                            </div>
                            <input type="hidden" name="page" value="${items.page}" id="page">
                            <div class="row">
                                <button class="btn btn-primary col-11 mx-auto" id="comment-next">Xem thêm</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="banner">
                    <img src="<c:url value="/template/web/img/fb.PNG"/>" alt="">
                </div>
                <%@ include file="/common/web/right-menu-trailer.jsp" %>
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
                        <h2 class="col-sm-9">Phim liên quan</h2>
                        <a class="col-sm-3" href="">
                            <span>Xem tất cả</span><i class="fas fa-caret-right"></i>
                        </a>
                    </div>
                </div>
                <div class="main-content">
                    <div class="list-movies">
                        <ul class="row">
                            <c:forEach var="relatedFilm" items="${relatedFilms}">
                                <li class="col-sm-3">
                                    <a href="<c:url value="/film/${relatedFilm.code}-${relatedFilm.id}"/>">
                                        <div class="list-movies-items">
                                            <c:if test="${empty relatedFilm.image}">
                                                <img class="thumbnail"
                                                     src="<c:url value="/template/image/default_poster.jpg"/>"
                                                     alt="">
                                            </c:if>
                                            <c:if test="${not empty relatedFilm.image}">
                                                <img class="thumbnail"
                                                     src="https://drive.google.com/uc?export=view&id=${relatedFilm.image}"
                                                     alt="">
                                            </c:if>

                                            <div class="phim-item-title">
                                                <h3 class="movies-name-1">${relatedFilm.name}</h3>
                                                <h4 class="movies-name-2">${relatedFilm.name}</h4>
                                                <p>${relatedFilm.time} phút</p>
                                            </div>
                                            <span class="ribbon">HD-VietSub</span>
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
                                    <a class="tag-link" href="">
                                        tội phạm
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        tình yêu
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        phim ma
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        marvel
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        cảnh sát
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        ma cà rồng
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoombie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        xác sống
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        siêu anh hùng
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
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
                                    <a class="tag-link" href="">
                                        trinh thám
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        giết người
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        hành động 2 người
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoobie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoobie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoobie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoobie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoobie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoobie
                                    </a>
                                    <span class="tag-end">&nbsp;</span>
                                </li>
                                <li class="tag-items ">
                                    <a class="tag-link" href="">
                                        zoobie
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
<script>

    $(document).ready(function () {
        var i = "${evaluate.liked}";
        if (i == "1") {
            $('#btn-like').addClass("liked");
        }
        voteInit();
        loadComment();
        increaseView();
    });


    function increaseView() {
        var vid = document.getElementById("video-ep");
        vid.onloadedmetadata = function () {
            var d = Number(this.duration);
            var timeOut = d * 60 / 100;
            var i = 0;
            var timer = setInterval(function () {
                if (!vid.paused) {
                    i++;
                }
                if (i >= timeOut) {
                    var id = "${filmId}";
                    var data = id;
                    var url = "<c:url value='/api/film/view'/>";
                    $.ajax({
                        url: url,
                        type: "PUT",
                        contentType: 'application/json',
                        data: JSON.stringify(data),
                        dataType: 'json',
                        success: function (result) {
                        },
                        error: function (error) {
                        }
                    });
                    clearInterval(timer);
                }
            }, 1000);
        };


    }

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

    $('#btn-fullScreen').click(function () {
        var elem = document.getElementById("video-ep");
        if (elem.requestFullscreen) {
            elem.requestFullscreen();
        }
    });

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
        if (id != ""){
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

    function btnLikeClick() {
        var id = "${user.id}";
        if (id != ""){
            var like = $('#ip-like').val();
            var url = $('#form-evaluate').attr("action");
            if (like == "1") {
                $('#ip-like').val("0");
                $('#btn-like').removeClass("liked");
                formSubmit(url);
            } else {
                $('#ip-like').val("1");
                $('#btn-like').addClass("liked");
                formSubmit(url);
            }
        }


    }

    function btnFollowClick() {
        var id = "${user.id}";
        if (id != ""){
            var follow = $('#ip-follow').val();
            var url = $('#form-evaluate').attr("action");
            if (follow == "1") {
                $('#ip-follow').val("0");
                $('#btn-follow').removeClass("btn-success");
                $('#btn-follow').html('<i class="fas fa-plus"></i> Thêm vào tủ phim');
                formSubmit(url);
            } else {
                $('#ip-follow').val("1");
                $('#btn-follow').addClass("btn-success");
                $('#btn-follow').html(' Đã thêm vào tủ phim');
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
