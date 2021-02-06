<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<c:url value="/template/web/css/fim-list.css"/>">
</head>
<body>
<div class="container">
    <div class="row form-search">
        <div class="col-2">
            <div class="row title"><p>Sắp xếp</p></div>
            <div class="row">
                <form action="" method="get" id="form-search">
                    <select class="form-control select-form" name="sort">
                        <option value="modifiedDate"
                                <c:if test="${items.sortExpression == 'modifiedDate'}">selected</c:if> >
                            Thời gian cập nhật
                        </option>
                        <option value="createdDate"
                                <c:if test="${items.sortExpression == 'createdDate'}">selected</c:if> >
                            Thời gian đăng
                        </option>
                        <option value="view"
                                <c:if test="${items.sortExpression == 'view'}">selected</c:if> >
                            Lượt xem
                        </option>
                    </select>
                    <input type="hidden" id="page" value="${items.page}" name="page">
                </form>
            </div>
        </div>
        <div class="col-2">
            <div class="row title"><p>Hình thức</p></div>
            <div class="row">
                <select class="form-control select-form" id="select-filmType">
                    <option value="">Tất cả</option>
                    <c:forEach var="filmType" items="${film_type_list}">
                        <option value="${filmType.code}"
                                <c:if test="${items.filmType == filmType.code}">selected</c:if> >
                                ${filmType.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="col-2">
            <div class="row title"><p>Thể loại</p></div>
            <div class="row">
                <select class="form-control select-form" id="select-category">
                    <option value="">Tất cả</option>
                    <c:forEach var="category" items="${category_list}">
                        <option value="${category.code}"
                                <c:if test="${items.category == category.code}">selected</c:if> >
                                ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="col-2">
            <div class="row title"><p>Quốc gia</p></div>
            <div class="row">
                <select class="form-control select-form" id="select-country">
                    <option value="">Tất cả</option>
                    <c:forEach var="country" items="${country_list}">
                        <option value="${country.code}"
                                <c:if test="${items.country == country.code}">selected</c:if> >
                                ${country.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="col-2">
            <div class="row title"><p>Năm</p></div>
            <div class="row">
                <select class="form-control select-form" id="select-year">
                    <option value="">Tất cả</option>
                    <c:forEach var="year" items="${years}">
                        <option value="${year}"
                                <c:if test="${items.year == year}">selected</c:if> >${year}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="col-2">
            <button class="btn btn-danger" id="btn-search">Duyệt</button>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-sm-8">
            <div class="content-title">
                <div class="row">
                    <h2 class="col-sm-9" id="title-search">phim chiếu </h2>
                </div>
            </div>
            <div class="main-content">
                <div class="list-movies">
                    <ul class="row">
                        <c:forEach items="${items.listResult}" var="film">
                            <li class="col-sm-4">
                                <a href="<c:url value="/film/${film.code}-${film.id}"/>">
                                    <div class="list-movies-items">
                                        <div class="image-film">
                                            <c:if test="${empty film.image}">
                                                <c:url value="/template/image/default_poster.jpg" var="defaultPoster"/>
                                                <c:set var="imageFilmUrl" value='${defaultPoster}'/>
                                            </c:if>
                                            <c:if test="${not empty film.image}">
                                                <c:set var="imageFilmUrl"
                                                       value='https://drive.google.com/uc?export=view&id=${film.image}'/>
                                            </c:if>
                                            <img class="thumbnail" src="${imageFilmUrl}" alt="">
                                        </div>
                                        <div class="phim-item-title">
                                            <h3 class="movies-name-1">${film.name}</h3>
                                            <h4 class="movies-name-2">${film.name}</h4>
                                            <p>${film.time} phút</p>
                                        </div>
                                        <span class="ribbon">${film.quality}</span>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <ul class="pagination" id="pagination"></ul>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <%@ include file="/common/web/right-menu-trailer.jsp" %>
            <%@ include file="/common/web/right-menu-series_film.jsp" %>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        loadTitle();
        pagingFilm();
    });

    function pagingFilm(){
        var totalPage = ${items.totalPage};
        var currentPage = ${items.page};
        $(function () {
            window.pagObj = $('#pagination').twbsPagination({
                totalPages: totalPage,
                startPage: currentPage,
                visiblePages: 10,
                onPageClick: function (event, page) {
                    if (currentPage != page) {
                        $('#page').val(page);
                        $('#form-search').submit();
                    }
                }
            })
        });
    }
    $('#btn-search').click(function () {
        var filmType = $('#select-filmType').val();
        var category = $('#select-category').val();
        var country = $('#select-country').val();
        var year = $('#select-year').val();
        var url = getUrl(filmType, category, country, year);
        $('#form-search').attr("action", url);
        $('#form-search').submit();
    });

    function loadTitle() {
        var filmType = $('#select-filmType option:selected').text();
        var category = $('#select-category option:selected').text();
        var country = $('#select-country option:selected').text();
        var year = $('#select-year option:selected').text();
        var title = "";
        if (filmType != "" && $('#select-filmType').val() != "") {
            title = title + filmType + "/";
        }
        if (category != "" && $('#select-category').val() != "") {
            title = title + category + "/";
        }
        if (country != "" && $('#select-country').val() != "") {
            title = title + country + "/";
        }
        if (year != "" && $('#select-year').val() != "") {
            title = title + year + "/";
        }
        if (title != "") {
            title = title.substr(0, title.length - 1);
        }
        $('#title-search').text(title);
        $('title').text(title);
    }

    function getUrl(filmType, category, country, year) {
        var url = "/phim";
        if (filmType != "") {
            url = url + "/" + filmType;
            if (category != "") {
                url = url + "/" + category;
                if (country != "") {
                    url = url + "/" + country;
                    if (year != "") {
                        url = url + "/" + year;
                    }
                } else if (year != "") {
                    url = url + "/nam-" + year;
                }
            } else if (country != "") {
                url = url + "/nuoc-" + country;
                if (year != "") {
                    url = url + "/" + year;
                }
            } else if (year != "") {
                url = url + "/nam-" + year;
            }
        } else if (category != "") {
            url = url + "/the-loai/" + category;
            if (country != "") {
                url = url + "/" + country;
                if (year != "") {
                    url = url + "/" + year;
                }
            } else if (year != "")
                url = url + "/nam-" + year;
        } else if (country != "") {
            url = url + "/quoc-gia/" + country;
            if (year != "") {
                url = url + "/" + year;
            }
        } else if (year != "") {
            url = url + "/nam-" + year;
        }
        return url;
    }
</script>
</body>
</html>
