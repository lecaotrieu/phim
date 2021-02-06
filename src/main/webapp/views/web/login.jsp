<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<head>
    <title><fmt:message key="label.login" bundle="${lang}"/></title>
</head>
<body>
<div class="container">
<%--    <img src="<c:url value="/repository/film/1-8kaduH69hDWr4qCh20itgQ-7Yr9Ojb8"/>" alt="" style=" height: 90px; width: 100px;">--%>
    <div class="row">
        <div class="col-sm-8">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card shadow-lg border-0 rounded-lg mt-5 bg-light">
                        <div class="card-header"><h3 class="text-center my-4"><fmt:message key="label.login"
                                                                                           bundle="${lang}"/></h3></div>
                        <div class="card-body">
                            <c:if test="${param.incorrectAccount!=null}">
                                <div class="alert alert-block alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">
                                        <i class="ace-icon fa fa-times"></i>
                                    </button>
                                    Sai tài khoản hoặc mật khẩu !
                                </div>
                            </c:if>
                            <c:if test="${param.change_password_success!=null}">
                                <div class="alert alert-block alert-success">
                                    <button type="button" class="close" data-dismiss="alert">
                                        <i class="ace-icon fa fa-times"></i>
                                    </button>
                                    Thay đổi mật khẩu thành công !
                                </div>
                            </c:if>
                            <c:if test="${param.register_success!=null}">
                                <div class="alert alert-block alert-success">
                                    <button type="button" class="close" data-dismiss="alert">
                                        <i class="ace-icon fa fa-times"></i>
                                    </button>
                                    Đăng ký thành công !
                                </div>
                            </c:if>
                            <form action="/j_spring_security_check_user" id="formLogin" method="post">
                                <div class="form-group">
                                    <label class="small mb-1" for="inputUserNameAddress"><fmt:message bundle="${lang}"
                                                                                                      key="label.username"/></label>
                                    <input class="form-control py-4" id="inputUserNameAddress" type="text"
                                           name="j_username_user"
                                           placeholder="Enter username"/>
                                </div>
                                <div class="form-group">
                                    <label class="small mb-1" for="inputPassword"><fmt:message bundle="${lang}"
                                                                                               key="label.password"/> </label>
                                    <input class="form-control py-4" id="inputPassword" type="password"
                                           name="j_password_user"
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
                                    <a class="small" href="#"><fmt:message bundle="${lang}"
                                                                           key="label.forgot.password"/></a>
                                    <button class="btn btn-primary"><fmt:message bundle="${lang}"
                                                                                 key="label.login"/></button>
                                </div>
                                <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=https://localhost:8443/dang-nhap/google&response_type=code&client_id=407542163363-isark35ln0fngv9jimhf8amp9a0k7i8e.apps.googleusercontent.com&approval_prompt=force"
                                       class="btn btn-lg btn-danger"><i class="fab fa-google"></i> Login Google</a>
                                    <a class="btn btn-lg btn-primary"
                                       href="https://www.facebook.com/dialog/oauth?client_id=129090429044237&redirect_uri=https://localhost:8443/AccessFacebook/login-facebook"><i
                                            class="fab fa-facebook-f"></i> Login Facebook</a>
                                </div>

                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <%@ include file="/common/web/right-menu-series_film.jsp" %>
            <%@ include file="/common/web/right-menu-trailer.jsp" %>
        </div>
    </div>
</div>
</body>
</html>
