<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <a class="navbar-brand ps-3 d-flex align-items-center" href="/admin">
        <span style="font-family: 'Georgia', serif; font-weight: bold; font-size: 1.2rem;">
            ✿ Hoa hòe hoa hoẹt ✿
        </span>
    </a>

    <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
        <span class="text-white">
            Xin chào, <strong><c:out value="${sessionScope.username}" /></strong>
        </span>
    </form>
</nav>
