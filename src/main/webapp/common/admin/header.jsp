<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.movie.web.utils.SecurityUtils" %>
<%@include file="/common/taglib.jsp" %>
<nav class="cs-navbar navbar navbar-dark bg-secondary navbar-expand fixed-top">
    <a class="navbar-brand " href="<c:url value="/admin/home-page"/>"><fmt:message key="label.admin.page"
                                                                                   bundle="${lang}"/></a>

    <div class="collapse navbar-collapse" id="navbarColor01">
        <div class="btn btn-outline-light" onclick="closeAndOpenNav()"><i class="fas fa-bars"></i></div>
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="<c:url value="/trang-chu"/>"><fmt:message key="label.home.page"
                                                                                    bundle="${lang}"/>
                    <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Features</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Pricing</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">About</a>
            </li>
        </ul>
        <form class="form-inline" style="margin-bottom: auto;">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-light my-2 my-sm-0" type="submit"><fmt:message key="label.search"
                                                                                          bundle="${lang}"/></button>
        </form>
        <!-- Navbar-->
        <security:authorize access="hasAnyRole('ADMIN','POSTER','MANAGER')">
            <div class="navbar-nav">
                <a class="nav-link" href="#">Welcome <%=SecurityUtils.getPrincipal().getUsername()%>
                </a>
            </div>
        </security:authorize>
        <ul class="navbar-nav ml-auto ml-md-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                    <a class="dropdown-item" href="<c:url value="/admin/personal/information"/>">Cài đặt trang cá
                        nhân</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href='<c:url value="/account/logout-admin"/>'><fmt:message
                            key="label.logout" bundle="${lang}"/></a>
                </div>
            </li>
        </ul>
    </div>
</nav>
<script>

</script>