<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!doctype html>
<html>
<head>
    <title><dec:title/></title>
    <link rel="stylesheet" href="<c:url value="/template/fontawesome-5.12.1/css/all.css"/>">
    <link rel="stylesheet" href="<c:url value="/template/bootstrap-4.5.2-dist/css/bootstrap.min.css"/>">
    <dec:head/>
</head>
<body class="bg-primary">
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <dec:body/>
        </main>
    </div>
    <footer class="py-4 bg-light mt-auto fixed-bottom">
        <div class="container-fluid">
            <div class="d-flex align-items-center justify-content-between small">
                <div class="text-muted">Copyright &copy; Your Website 2020</div>
                <div>
                    <a href="#">Privacy Policy</a>
                    &middot;
                    <a href="#">Terms &amp; Conditions</a>
                </div>
            </div>
        </div>
    </footer>
</div>
<script src='<c:url value="/template/fontawesome-5.12.1/js/fontawesome.min.js"/>'></script>
<script src="<c:url value="/template/jquery/jquery-3.3.1.js"/>"></script>
<script src="<c:url value="/template/jquery/jquery-3.5.1.min.js"/>"></script>
<script src="<c:url value="/template/bootstrap-4.5.2-dist/js/bootstrap.min.js"/>"></script>
</body>
</html>
