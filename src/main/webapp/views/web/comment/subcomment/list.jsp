<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<security:authorize access="hasRole('USER')">
    <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"></c:set>
</security:authorize>
<c:forEach items="${items.listResult}" var="subComment">
    <div class="sub-comment" id="comment_${subComment.id}">
        <div class="row content-cmt">
            <div class="col-md-1">
                <c:if test="${not empty subComment.user.photo}">
                    <c:set value="https://drive.google.com/uc?export=view&id=${subComment.user.photo}"
                           var="userPhoto"/>
                </c:if>
                <c:if test="${empty subComment.user.photo}">
                    <c:url value="/template/image/avatar_default.jpg" var="userPhoto"/>
                </c:if>
                <img id="avatar${subComment.id}" class="avatar" src="${userPhoto}" alt="">
            </div>
            <div class="col-md-11">
                <b class="name">${subComment.user.firstName} ${subComment.user.lastName}</b>
                <p class="cmt">${subComment.content}</p>
                <span class="action">
                    <c:if test="${user.id == subComment.user.id}">
                        <a class="action" onclick="warningBeforeDelete(${subComment.id})"><i
                                class="far fa-trash-alt"></i></a>
                    </c:if>
                    <security:authorize access="hasRole('USER')">
                        <a class="action <c:if test="${subComment.like == 1}">active</c:if>"
                           id="comment_like_${subComment.id}" onclick="likeComment(${subComment.id})"
                           style="cursor: pointer;">Like</a>
                        <input type="hidden" name="comment_like_${subComment.id}" value="${subComment.like}">
                    </security:authorize>
                     <security:authorize access="!hasRole('USER')">
                         <a class="action" id="comment_like_${subComment.id}"
                            style="cursor: pointer;">Like</a>
                     </security:authorize>
                     <span>${subComment.thoiGianDang}</span>
                        </span>
            </div>
        </div>
    </div>
</c:forEach>
<input type="hidden" id="sub-cm_next_${items.commentId}" value="${items.nextCountItem}">
