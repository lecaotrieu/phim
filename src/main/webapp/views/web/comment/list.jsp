<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/api/film/comment" var="apiComment"></c:url>
<c:url value="/api/film/comment/like" var="apiCommentLike"></c:url>
<c:url value="/ajax/subComment/list" var="subCommentListAjaxUrl"></c:url>
<security:authorize access="hasRole('USER')">
    <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"></c:set>
</security:authorize>
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
            <b class="name">${comment.user.firstName} ${comment.user.lastName}</b>
            <p class="cmt">${comment.content}</p>
            <span class="like">
                <c:if test="${user.id == comment.user.id}">
                                           <a class="action" style="cursor: pointer;"
                                              onclick="warningBeforeDelete(${comment.id})"><i
                                                   class="far fa-trash-alt"></i></a>
                </c:if>
                <a class="action" onclick="showSubCmForm(${comment.id})" style="cursor: pointer; color: #05c405">Phản hồi</a>
                <security:authorize access="hasRole('USER')">
                    <a class="action <c:if test="${comment.like == 1}">active</c:if>" id="comment_like_${comment.id}"
                       onclick="likeComment(${comment.id})"
                       style="cursor: pointer;">Like</a>
                    <input type="hidden" name="comment_like_${comment.id}" id="ip-content_${comment.id}"
                           value="${comment.like}">
                </security:authorize>
                <security:authorize access="!hasRole('USER')">
                    <a class="action" id="comment_like_${comment.id}"
                       style="cursor: pointer;">Like</a>
                </security:authorize>
                <span>${comment.thoiGianDang}</span>
            </span>

            <form action="<c:url value="/api/film/comment"/> " class="row sub-cm-form" id="sub-cm-form_${comment.id}"
                  style="margin-top: 10px;" method="post">
                <div class="col-10">
                    <input class="form-control" style="border: 1px solid #505050;" type="text" name="content"
                           placeholder="Nhập bình luận">
                </div>
                <div class="col-2">
                    <button class="btn btn-primary">Gửi</button>
                </div>
                <input type="hidden" name="comment.id" value="${comment.id}">
                <input type="hidden" name="film.id" value="${items.filmId}">
                <input type="hidden" name="user.id" value="${user.id}">
            </form>
        </div>
    </div>
    <div id="sub-cm_${comment.id}" class="sub-comment-list">

    </div>
    <c:if test="${not empty comment.subCommentCount && comment.subCommentCount>0}">
        <c:if test="${comment.subCommentCount>10}">
            <p class="sub-comment-count" id="sub-cm-nx-${comment.id}"
               onclick="loadSubComment(${comment.id},${items.filmId})">
                Xem thêm 10 bình luận</p>
        </c:if>
        <c:if test="${comment.subCommentCount<=10}">
            <p class="sub-comment-count" id="sub-cm-nx-${comment.id}"
               onclick="loadSubComment(${comment.id},${items.filmId})">
                Xem thêm ${comment.subCommentCount} bình luận</p>
        </c:if>
    </c:if>
    </div>
    <input type="hidden" id="sub_page_${comment.id}" value="0">
</c:forEach>
<script>
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

    function showSubCmForm(id) {
        hiddenSubCmForm();
        var subCmFormId = "#sub-cm-form_" + id;
        $(subCmFormId).addClass("show");
    }

    function hiddenSubCmForm() {
        $('.sub-cm-form').removeClass("show");
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


    function likeComment(comment_id) {
        var name = "input[name='comment_like_" + comment_id + "']";
        var like = $(name).val();
        var data = {};
        var commentId = "#comment_like_" + comment_id;
        if (like == "1") {
            data["status"] = 0;
            $(name).val(0);
            $(commentId).removeClass("active");
        } else {
            data["status"] = 1;
            $(name).val(1);
            $(commentId).addClass("active");
        }
        data["user"] = {id: '${user.id}'};
        data["comment"] = {id: comment_id};
        $.ajax({
            url: '${apiCommentLike}',
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json',
            success: function (result) {

            },
            error: function (result) {
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
