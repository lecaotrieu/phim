<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<option value="">Chọn Xã / Phường</option>
<c:forEach var="commune" items="${communes}">
    <option value="${commune.id}">${commune.name}</option>
</c:forEach>
