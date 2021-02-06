<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Login Admin</title>
    <link rel="stylesheet" href="<c:url value="/template/login/style.css"/>">
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-5">
            <div class="card shadow-lg border-0 rounded-lg mt-5">
                <div class="card-header"><h3 class="text-center my-4"><fmt:message key="label.login"
                                                                                   bundle="${lang}"/></h3></div>
                <div class="card-body">
                    <c:if test="${param.incorrectAccount !=null}">
                        <div class="alert alert-danger">
                            Username or password incorrect
                        </div>
                    </c:if>
                    <c:if test="${param.sessionTimeout !=null}">
                        <div class="alert alert-danger">
                            Thời gian đăng nhập đã hết
                        </div>
                    </c:if>
                    <c:if test="${param.accessDenied !=null}">
                        <div class="alert alert-danger">
                            You not authorize
                        </div>
                    </c:if>
                    <form action="/admin/j_spring_security_check" id="formLogin" method="post">
                        <div class="form-group">
                            <label class="small mb-1" for="inputUserNameAddress"><fmt:message bundle="${lang}"
                                                                                              key="label.username"/></label>
                            <input class="form-control py-4" id="inputUserNameAddress" type="text" name="j_username"
                                   placeholder="Enter username"/>
                        </div>
                        <div class="form-group">
                            <label class="small mb-1" for="inputPassword"><fmt:message bundle="${lang}"
                                                                                       key="label.password"/> </label>
                            <input class="form-control py-4" id="inputPassword" type="password" name="j_password"
                                   placeholder="Enter password"/>
                        </div>
                        <div class="form-group">
                            <div class="custom-control custom-checkbox">
                                <input class="custom-control-input" id="rememberPasswordCheck"
                                       type="checkbox"/>
                                <label class="custom-control-label" for="rememberPasswordCheck"><fmt:message
                                        bundle="${lang}" key="label.remember.password"/></label>
                            </div>
                        </div>
                        <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                            <a class="small" href="#"><fmt:message bundle="${lang}" key="label.forgot.password"/></a>
                            <button class="btn btn-primary"><fmt:message bundle="${lang}" key="label.login"/></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
