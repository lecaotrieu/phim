<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<option value="">Chọn Tỉnh / Thành phố</option>
<c:forEach var="city" items="${cities}">
    <option value="${city.id}">${city.name}</option>
</c:forEach>
