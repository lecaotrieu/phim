<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<div id="mySidenav" class="sidenav active">
    <div class="left-menu">
        <a class="nav-link active sub-menu" href="#">
            <i class="fas fa-tachometer-alt"></i>
            <fmt:message key="label.dashboard" bundle="${lang}"/>
        </a>
        <div class="sidenav-menu-header sub-menu">
            <div class="header-sub-menu" style="width: max-content">
                <fmt:message key="label.manage" bundle="${lang}"/></div>
            <security:authorize access="hasAnyRole('ADMIN')">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse3"><i class="fas fa-users"></i><fmt:message
                                        key="label.employee" bundle="${lang}"/></a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/employee/list"/>"><i
                                        class="far fa-circle"></i><fmt:message key="label.list" bundle="${lang}"/></a>
                                </li>
                                <li class="sub-menu-li"><a href="<c:url value="/admin/employee/edit"/>"><i
                                        class="far fa-circle"></i><fmt:message
                                        key="label.employee.add" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse8"><i class="fas fa-dot-circle"></i>
                                    <fmt:message key="label.role" bundle="${lang}"/>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse8" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/role/list"/>"><i
                                        class="far fa-circle"></i>
                                    <fmt:message key="label.list" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </security:authorize>
            <security:authorize access="hasAnyRole('ADMIN','MANAGER')">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse1"><i class="fas fa-user"></i>
                                    <fmt:message key="label.user" bundle="${lang}"/>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/user/list"/>"><i
                                        class="far fa-circle"></i>
                                    <fmt:message key="label.list" bundle="${lang}"/></a></li>
                                <li class="sub-menu-li"><a href="<c:url value="/admin/user/edit"/>"><i
                                        class="far fa-circle"></i>
                                    <fmt:message key="label.user.add" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse4"><i class="fas fa-dot-circle"></i>
                                    <fmt:message key="label.category" bundle="${lang}"/>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse4" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/category/list"/>"><i
                                        class="far fa-circle"></i>
                                    <fmt:message key="label.list" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse5"><i class="far fa-dot-circle"></i>
                                    <fmt:message key="label.film.type" bundle="${lang}"/>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse5" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/film-type/list"/>"><i
                                        class="far fa-circle"></i>
                                    <fmt:message key="label.list" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse6"><i class="fab fa-autoprefixer"></i>
                                    <fmt:message key="label.actor" bundle="${lang}"/>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse6" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/actor/list"/>"><i
                                        class="far fa-circle"></i>
                                    <fmt:message key="label.list" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse7"><i class="fab fa-dyalog"></i></i>
                                    <fmt:message key="label.director" bundle="${lang}"/>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse7" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/director/list"/>"><i
                                        class="far fa-circle"></i>
                                    <fmt:message key="label.list" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </security:authorize>
            <security:authorize access="hasAnyRole('ADMIN','POSTER')">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse2"><i class="fas fa-film"></i><fmt:message
                                        key="label.film" bundle="${lang}"/></a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <ul class="collapse-sub-menu">
                                <li class="sub-menu-li"><a href="<c:url value="/admin/film/list"/>"><i
                                        class="far fa-circle"></i><fmt:message
                                        key="label.list" bundle="${lang}"/></a></li>
                                <li class="sub-menu-li"><a href="<c:url value="/admin/film/edit"/>"><i
                                        class="far fa-circle"></i><fmt:message
                                        key="label.film.add" bundle="${lang}"/></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </security:authorize>
        </div>
    </div>
</div>

<!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
