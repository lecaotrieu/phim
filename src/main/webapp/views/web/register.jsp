<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<c:url value="/api/user/register" var="apiUrl">
</c:url>
<html>
<head>
    <title><fmt:message key="label.register" bundle="${lang}"/></title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-sm-8">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card shadow-lg border-0 rounded-lg mt-5 bg-light">
                        <div class="card-header"><h3 class="text-center my-4"><fmt:message key="label.register"
                                                                                           bundle="${lang}"/></h3></div>
                        <div class="card-body">
                            <c:if test="${param.register_error!=null}">
                                <div class="alert alert-block alert-danger">
                                    <button type="button" class="close" data-dismiss="alert">
                                        <i class="ace-icon fa fa-times"></i>
                                    </button>
                                    Đăng ký thất bại !
                                </div>
                            </c:if>
                            <form action="" id="formRegister" method="post">
                                <div class="form-group">
                                    <label class="small mb-1" for="inputUserNameAddress"><fmt:message bundle="${lang}"
                                                                                                      key="label.username"/></label>
                                    <input class="form-control py-4" id="inputUserNameAddress" type="text"
                                           name="userName"
                                           placeholder="Enter username"/>
                                </div>
                                <div class="form-group">
                                    <label class="small mb-1" for="inputPassword"><fmt:message bundle="${lang}"
                                                                                               key="label.password"/> </label>
                                    <input class="form-control py-4" id="inputPassword" type="password" name="password"
                                           placeholder="Nhập mật khẩu"/>
                                </div>
                                <div class="form-group">
                                    <label class="small mb-1" for="inputCfPassword"><fmt:message bundle="${lang}"
                                                                                                 key="label.confirm.password"/> </label>
                                    <input class="form-control py-4" id="inputCfPassword" type="password"
                                           name="confirmPassword"
                                           placeholder="Nhập lại mật khẩu"/>
                                </div>
                                <div class="form-group">
                                    <label class="small mb-1" for="inputFirstName"><fmt:message bundle="${lang}"
                                                                                                key="label.full.name"/> </label>
                                    <div class="row m-0">
                                        <input class="form-control py-4 col-6" id="inputFirstName" type="text"
                                               name="firstName"
                                               placeholder="Nhập họ và tên lót"/>
                                        <p class="col-1 text-center">-</p>
                                        <input class="form-control col-5 py-4" id="inputLastName" type="text"
                                               name="lastName"
                                               placeholder="Nhập tên"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="small mb-1" for="inputEmail"><fmt:message bundle="${lang}"
                                                                                            key="label.email"/> </label>
                                    <input class="form-control py-4" id="inputEmail" type="email" name="email"
                                           placeholder="Nhập email"/>
                                </div>
                                <input type="hidden" value="1" name="status">
                                <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                                    <button class="btn btn-primary" id="btnRegister"><fmt:message bundle="${lang}"
                                                                                                  key="label.register"/></button>
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
<script>
    function register(data) {
        $.ajax({
            url: '${apiUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "/dang-nhap?register_success";
            },
            error: function (error) {
                window.location.href = "/dang-ky?register_error";
            }
        });
    }

    $('#btnRegister').click(function (e) {
        e.preventDefault();
        var formData = $('#formRegister').serializeArray();
        var data = convertToJson(formData);
        register(data);
    });
</script>
</body>
</html>
