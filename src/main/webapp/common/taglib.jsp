<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="dec" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<c:choose>
    <c:when test="${param.lang eq 'en'}">
        <fmt:setBundle basename="ApplicationEnResource" var="lang"/>
    </c:when>
    <c:otherwise>
        <fmt:setBundle basename="ApplicationResource" var="lang"/>
    </c:otherwise>
</c:choose>
