<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/api/film/comment" var="apiComment"></c:url>
<c:url value="/api/film/comment/like" var="apiCommentLike"></c:url>
<c:url value="/ajax/admin/subComment/list" var="subCommentListAjaxUrl"></c:url>
<security:authorize access="hasRole('USER')">
    <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"></c:set>
</security:authorize>
<p class="total-comment">${items.totalItems} bình luận</p>
<c:forEach items="${items.listResult}" var="comment">
    <div class="row content-cmt" id="comment_${comment.id}">
        <div class="col-md-1">
            <c:if test="${not empty comment.user.photo}">
                <c:set value="https://drive.google.com/uc?export=view&id=${comment.user.photo}"
                       var="userPhoto"/>
            </c:if>
            <c:if test="${empty comment.user.photo}">
                <c:url value="/template/image/avatar_default.jpg" var="userPhoto"/>
            </c:if>
            <img id="avatar${comment.id}" class="avatar" src="${userPhoto}" alt="">
        </div>
        <div class="col-md-11">
            <a href="<c:url value="/admin/user/profile?id=${comment.user.id}"/>"
               class="name">${comment.user.firstName} ${comment.user.lastName}</a>
            <p class="cmt">${comment.content}</p>
            <span class="like">
            <a class="action" style="cursor: pointer;" onclick="warningBeforeDelete(${comment.id})">
                <i class="far fa-trash-alt"></i>
            </a>
            <span style="color: #0e1d49;">${comment.totalLike} Like</span>
                <span>${comment.thoiGianDang}</span>
            </span>
        </div>
    </div>
    <div id="sub-cm_${comment.id}" class="sub-comment-list">

    </div>
    <c:if test="${not empty comment.subCommentCount && comment.subCommentCount>0}">
        <c:if test="${comment.subCommentCount>10}">
            <p class="sub-comment-count" id="sub-cm-nx-${comment.id}" style="cursor: pointer;"
               onclick="loadSubComment(${comment.id},${items.filmId})">
                Xem thêm 10 bình luận</p>
        </c:if>
        <c:if test="${comment.subCommentCount<=10}">
            <p class="sub-comment-count" id="sub-cm-nx-${comment.id}" style="cursor: pointer;"
               onclick="loadSubComment(${comment.id},${items.filmId})">
                Xem thêm ${comment.subCommentCount} bình luận</p>
        </c:if>
    </c:if>
    </div>
    <input type="hidden" id="sub_page_${comment.id}" value="0">
</c:forEach>
<c:url value="/ajax/admin/comment/list" var="commentListUrl">
    <c:param name="page" value="${items.page}"/>
    <c:param name="limit" value="10"/>
    <c:param name="filmId" value="${items.filmId}"/>
    <c:param name="sortExpression" value="createdDate"/>
    <c:param name="sortDirection" value="0"/>
</c:url>
<script>
    $(document).ready(function () {
        pagingComment();
    });

    function pagingComment() {
        var totalPages = ${items.totalPage};
        var currentPage = ${items.page};
        $(function () {
            window.pagObj = $('#pagination').twbsPagination({
                totalPages: totalPages,
                visiblePages: 5,
                startPage: currentPage,
                onPageClick: function (event, page) {
                    if (currentPage != page) {
                        $("#comment-li").load("${commentListUrl}");
                    }
                }
            });
        });
    }

    function warningBeforeDelete(x) {
        if (x != null) {
            showAlertBeforeDelete(function () {
                deleteComment([x]);
            });
        } else {
            showAlertBeforeDelete(function () {
                var ids = $('tbody input[type=checkbox]:checked').map(function () {
                    return $(this).val();
                }).get();
                deleteComment(ids);
            });
        }
    }

    function loadSubComment(commentId, filmId) {
        var pageId = "#sub_page_" + commentId;
        var page = Number($(pageId).val());
        var subCmListId = "#sub-cm_" + commentId;
        var subCmNextId = "#sub-cm_next_" + commentId;
        var sub_cm_nx_id = "#sub-cm-nx-" + commentId;
        page += 1;
        var url = "${subCommentListAjaxUrl}?page=" + page + "&commentId=" + commentId + "&filmId=" + filmId;
        $.ajax({
            url: url,
            type: "GET",
            contentType: 'html',
            success: function (html) {
                $(subCmListId).append(html);
                $(pageId).val(page);
                if ($(subCmNextId).val() <= 0) {
                    $(sub_cm_nx_id).remove();
                } else {
                    var txt = "Xem thêm " + $(subCmNextId).val() + " bình luận";
                    $(sub_cm_nx_id).text(txt);
                }
            },
            error: function (error) {
            }
        });
    }

    function deleteComment(data) {
        $.ajax({
            url: '${apiComment}',
            type: 'DELETE',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function (result) {
                data.forEach(function (item, index) {
                    var commentId = "#comment_" + item;
                    var subCmListId = "#sub-cm_" + item;
                    var subCmNext = "#sub-cm-nx-" + item;
                    $(commentId).remove();
                    $(subCmNext).remove();
                    $(subCmListId).remove();
                });
            },
            error: function (result) {
            }
        });
    }

    $('form.sub-cm-form').submit(function (e) {
        e.preventDefault();
        var userId = "${user.id}";
        if (userId != undefined) {
            var formData = $(this).serializeArray();
            var data = convertToJson(formData);
            var filmId = data.film.id;
            var commentId = data.comment.id;
            var url = $(this).attr("action");
            var subCmListId = "#sub-cm_" + commentId;
            var subCmNextId = "#sub-cm_next_" + commentId;
            var sub_cm_nx_id = "#sub-cm-nx-" + commentId;
            var pageId = "#sub_page_" + commentId;
            var ipContentId = "#ip-content_" + commentId;
            $(ipContentId).val('');
            commentApi(data, url, "post", function () {
                $(subCmListId).load("<c:url value="/ajax/subComment/list?limit=10&sortDirection=0&page=1"/>" + "&filmId=" + filmId + "&commentId=" + commentId, function () {
                    $(pageId).val(page);
                    if ($(subCmNextId).val() <= 0) {
                        $(sub_cm_nx_id).remove();
                    } else {
                        var txt = "Xem thêm " + $(subCmNextId).val() + " bình luận";
                        $(sub_cm_nx_id).text(txt);
                    }
                });
            });
        }
    });

</script>
