<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<option value="">Chọn Quận / Huyện</option>
<c:forEach var="district" items="${districts}">
    <option value="${district.id}">${district.name}</option>
</c:forEach>
