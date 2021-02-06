<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<section class="header">
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="<c:url value="/trang-chu"/>">
            <img src="<c:url value="/template/web/img/phimhay.png"/>" height="40" alt="">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <form class="form-inline search" action="<c:url value="/phim/tim-kiem"/>" method="get">
            <input id="search-input" class="form-control" name="search" type="text" value="${items.search}"
                   placeholder="Tìm: tên phim, đạo diễn, diễn viên">
            <div class="input-group-append button">
                <button class="input-group-text">
                    <i class="fas fa-search text-white"></i>
                </button>
            </div>
        </form>
        <div class="collapse navbar-collapse " id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto login-manager">
                <li class="nav-item dropdown">
                    <security:authorize access="hasRole('USER')">
                        <c:set var="user" value="<%=SecurityUtils.getUserPrincipal()%>"/>
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Xin chào <%=SecurityUtils.getUserPrincipal().getUsername()%>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <c:if test="${not empty user.id}">
                                <a class="dropdown-item" href="<c:url value="/chinh-sua-trang-ca-nhan/cap-nhat-thong-tin"/> ">Cài đặt trang cá nhân</a>
                                <a class="dropdown-item" href="<c:url value="/chinh-sua-trang-ca-nhan/doi-mat-khau"/> "><fmt:message key="label.change.password" bundle="${lang}"/> </a>
                                <a class="dropdown-item" href="<c:url value="/chinh-sua-trang-ca-nhan/doi-avatar"/> "><fmt:message key="label.edit.avatar.change" bundle="${lang}"/> </a>
                            </c:if>
                            <a class="dropdown-item" href='<c:url value="/logout"/>'><fmt:message
                                    key="label.logout"
                                    bundle="${lang}"/></a>
                        </div>
                    </security:authorize>
                    <security:authorize access="!hasRole('USER')">
                        <a href="<c:url value="/dang-nhap"/>" class="btn btn-primary float-right"><fmt:message
                                key="label.login"
                                bundle="${lang}"/></a>
                        <a href="<c:url value="/dang-ky"/>" class="btn btn-primary float-right"><fmt:message
                                key="label.register"
                                bundle="${lang}"/></a>
                    </security:authorize>
                </li>
            </ul>
        </div>
    </nav>
    <div class="clear"></div>
    <hr style="border: solid 1px #e8e800;">
    <nav id="menu">
        <ul>
            <li><a href="<c:url value="/phim?sort=view"/>">Phim Hay</a></li>
            <li>
                <a>Thể loại</a>
                <ul class="sub-menu">
                    <c:forEach items="${category_list}" var="category">
                        <li><a href="<c:url value="/phim/the-loai/${category.code}"/>">Phim ${category.name}</a></li>
                    </c:forEach>
                </ul>
            </li>
            <li>
                <a>Quốc gia</a>
                <ul class="sub-menu">
                    <c:forEach var="country" items="${country_list}">
                        <li><a href="<c:url value="/phim/quoc-gia/${country.code}"/>">${country.name}</a></li>
                    </c:forEach>
                </ul>
            </li>
            <c:forEach items="${film_type_list}" var="filmType">
                <li>
                    <a href="<c:url value="/phim/${filmType.code}"/>">${filmType.name}</a>
                    <c:if test="${filmType.code == 'phim-bo'}">
                        <ul class="sub-menu">
                            <c:forEach var="country" items="${country_list}">
                                <li><a href="<c:url value="/phim/${filmType.code}/nuoc-${country.code}"/>">Phim bộ ${country.name}</a></li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${filmType.code == 'phim-le'}">
                        <ul class="sub-menu">
                            <c:forEach items="${years}" var="year">
                                <li><a href="<c:url value="/phim/${filmType.code}/nam-${year}"/>">Phim lẻ ${year}</a></li>
                            </c:forEach>
                            <li><a href="#">Phim lẻ trước ${years[4]-1}</a></li>
                        </ul>
                    </c:if>
                </li>
            </c:forEach>
            <li><a href="#">Trailer</a></li>
        </ul>
    </nav>
</section>