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
                <a href="<c:url value="/admin/user/profile?id=${subComment.user.id}"/>"
                   class="name">${subComment.user.firstName} ${subComment.user.lastName}</a>
                <p class="cmt">${subComment.content}</p>
                <span class="like">
                    <a class="action" style="cursor: pointer;" onclick="warningBeforeDelete(${subComment.id})">
                        <i class="far fa-trash-alt"></i>
                    </a>
                    <span style="color: #0e1d49;">${subComment.totalLike} Like</span>
                    <span>${subComment.thoiGianDang}</span>
                </span>
            </div>
        </div>
    </div>
</c:forEach>
<input type="hidden" id="sub-cm_next_${items.commentId}" value="${items.nextCountItem}">
