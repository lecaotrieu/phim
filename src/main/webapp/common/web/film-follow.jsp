<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="/common/taglib.jsp" %>
<div class="right-box bookmark-box movies-trailer" id="bookmark-box" style="display: block;">
    <h2>
        <i class="fas fa-star"></i><span>Phim đã theo dõi</span>
    </h2>
    <div class="right-box-content" id="bookmark-list-box" style="">
        <ul class="list-top-movie slim-scroll" id="list-bookmark-film">
            <c:forEach items="${film_followed}" var="film">
                <li class="list-top-movie-item" id="bookmark-item-${film.id}">
                    <a class="list-top-movie-link" title="${film.name}"
                       href="<c:url value="/film/${film.code}-${film.id}"/>">
                        <div class="list-top-movie-item-thumb">
                            <c:if test="${not empty film.image}">
                                <img class="thumbnail"
                                     src="https://drive.google.com/uc?export=view&amp;id=${film.image}" alt=""
                                     style=" height: auto; max-height: 128px;">
                            </c:if>
                            <c:if test="${empty film.image}">
                                <img class="thumbnail" src="<c:url value="/template/image/default_poster.jpg"/>" alt=""
                                     style="height: auto; max-height: 128px;">
                            </c:if>
                        </div>
                        <div class="list-top-movie-item-info">
                            <span class="list-top-movie-item-vn">${film.name}</span>
                            <span class="list-top-movie-item-en">${film.name}</span>
                            <span class="list-top-movie-item-view">Trạng thái:
                            <c:if test="${film.status == 1}">
                                Hoạt động
                            </c:if>
                            <c:if test="${film.status == 0}">
                                Không hoạt động
                            </c:if>
                        </span>
                            <span class="rate-vote rate-vote-7">${film.scores}/10</span>
                        </div>
                    </a>
                    <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"></c:set>
                    <span class="bookmark-btn-remove" data-filmid="2504"
                          onclick="clickRemoveFilmFollow(${user.id},${film.id})">Xóa</span>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<script>
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

    function clickRemoveFilmFollow(userId, filmId) {
        var data = {user: {id: userId}, film: {id: filmId}, follow: 0}
        var url = '<c:url value="/api/evaluate/follow"/>';
        var method = 'PUT';
        evaluateApi(data, url, method);
        var li_id = "#bookmark-item-" + filmId;
        $(li_id).remove();
    }
</script>