<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/ajax/comment/edit" var="commentEditAjaxUrl">
    <c:param name="filmId" value="${item.filmId}"/>
</c:url>
<div class="row title-cmt">
    <div class="col-md-7">
        <span> ${item.totalItems} bình luận</span>
    </div>
    <div class="col-md-5" id="select">
        <label for="sort">Sắp xếp theo</label>
        <select name="sort" id="sort">
            <option value="1">Mới nhất</option>
            <option value="2">Cũ nhất</option>
        </select>
    </div>
</div>
<security:authorize access="hasRole('USER')">
    <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"></c:set>
    <form action="" id="form-comment" method="post">
        <div class="row content-cmt">
            <div class="col-md-1">
                <c:if test="${not empty user.photo}">
                    <c:set value="https://drive.google.com/uc?export=view&id=${user.photo}"
                           var="avatarUser"/>
                </c:if>
                <c:if test="${empty user.photo}">
                    <c:url value="/template/image/avatar_default.jpg" var="avatarUser"/>
                </c:if>
                <img id="avatar" class="avatar"
                     src="${avatarUser}"
                     alt="">
            </div>
            <div class="col-md-11">
                <textarea name="content" id="content" cols="65" rows="3"></textarea>
                <div class="submit">
                    <button>Đăng</button>
                </div>
            </div>
            <input type="hidden" value="${item.filmId}" name="film.id">
            <input type="hidden" value="${user.id}" name="user.id">
        </div>
    </form>
</security:authorize>
<script>

    $('#sort').change(function () {
        var sort = $('#sort').val();
        $('.comment-list').load("<c:url value="/ajax/comment/list?limit=5&page=1&filmId=${item.filmId}"/>" + "&sortDirection=" + sort);
    });

    $('#form-comment').submit(function (e) {
        e.preventDefault();
        var formData = $('#form-comment').serializeArray();
        var data = convertToJson(formData);
        var url = "<c:url value="/api/film/comment"/>";
        commentApi(data, url, "post", function () {
            $('.comment-list').load("<c:url value="/ajax/comment/list?limit=10&sortDirection=0&page=1&filmId=${item.filmId}"/>");
            $('#page').val(1);
            $('.comment-form').load("${commentEditAjaxUrl}");
        });
    });

    function commentApi(data, url, method, action) {
        $.ajax({
            url: url,
            type: method,
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                action();
            },
            error: function (error) {
                action();
            }
        });
    }
</script>
