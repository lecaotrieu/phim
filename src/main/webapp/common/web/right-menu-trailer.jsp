<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ include file="/common/taglib.jsp" %>
<div class="movies-trailer">
    <h2>
        <i class="fas fa-star"></i><span><fmt:message key="label.film.new.trailer" bundle="${lang}"/></span>
    </h2>
    <div class="right-box-content">
        <div class="scrollDiv">
            <ul class="list-scroll">
                <c:forEach var="film" items="${new_film_have_trailer}">
                    <li class="list-scroll-items ">
                        <a class="row" href="<c:url value="/film/${film.code}-${film.id}"/>">
                            <div class="thumbnail-right col-sm-5">
                                <c:if test="${empty film.image}">
                                    <img src="<c:url value="/template/image/default_poster.jpg"/>" alt="">
                                </c:if>
                                <c:if test="${not empty film.image}">
                                    <img class="thumbnail"
                                         src="https://drive.google.com/uc?export=view&id=${film.image}"
                                         alt="">
                                </c:if>
                            </div>
                            <div class="list-scroll-items-info col-sm-7">
                                <p class="list-top-movie-item-vn">${film.name}</p>
                                <p class="list-top-movie-item-en">${film.director.name}</p>
                                <p class="list-top-movie-item-view">Mức phổ biến: ${film.scores} điểm</p>
                                <p class="rate-vote rate-vote-10">
                                    <span class="fas fa-star"></span>
                                    <span class="fas fa-star"></span>
                                    <span class="fas fa-star"></span>
                                    <span class="fas fa-star"></span>
                                    <span class="fas fa-star"></span>
                                </p>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>