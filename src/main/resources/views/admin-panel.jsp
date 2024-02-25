<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
    <title>ADMIN PANEL</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <a class="navbar-brand mt-2 mt-lg-0" href="/">
                <img
                        src="/res/img/icon.png"
                        height="15"
                        alt="MDB Logo"
                        loading="lazy"
                />
            </a>
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="/">Home</a>
                </li>
                <sec:authorize access="hasRole('ADMIN')">
                    <div class="btn-group">
                        <button type="button" class="btn btn-outline-danger" href="/admin">Admin panel</button>
                        <div class="btn-group">
                            <button type="button" class="btn btn-outline-danger dropdown-toggle" data-bs-toggle="dropdown"></button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/admin?page=1&display=articles">Articles</a></li>
                                <li><a class="dropdown-item" href="/admin?page=1&display=users">Users</a></li>
                            </ul>
                        </div>
                    </div>
                </sec:authorize>
            </ul>
        </div>
        <sec:authorize access="isAuthenticated()">
            <div class="d-flex align-items-center" >
                <div class="nav-item ">
                    <div class="dropstart">
                        <div id="dropstartMenuButton dropdown-toggle" aria-expanded="false" data-bs-toggle="dropdown">
                            <img
                                    src="<core:url value="/res/img/6086462.png"/>"
                                    class="rounded-circle "
                                    height="25"
                                    loading="lazy"
                            />
                            <img
                                    src="https://mdbcdn.b-cdn.net/img/new/avatars/2.webp"
                                    class="rounded-circle"
                                    height="45"
                                    alt="Black and White Portrait of a Man"
                                    loading="lazy"

                            />
                        </div>

                        <ul class="dropdown-menu" aria-labelledby="dropstartMenuButton" >
                            <li><h6 class="dropdown-header">User actions</h6></li>

                            <li><a class="dropdown-item" href="/user">My profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/logout">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </sec:authorize>
        <sec:authorize access="!isAuthenticated()">
            <a href="/login" class="btn btn-primary px-4">Login</a>
        </sec:authorize>

    </div>
</nav>

<div class="admin-panel text-center">
    <h1>Admin panel</h1>
    <p>Here you can manage objects of both users and articles, all at one place</p>
</div>


<div class="container">

    <c:if test="${display eq 'users'}">
        <h2 class="">Users</h2>

        <table class="table">
            <thead>
            <tr>
                <th>First name</th>
                <th>Last name</th>
                <th>Roles</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.first_name}</td>
                    <td>${user.last_name}</td>
                    <td>${user.roles}</td>
                    <td>
                        <a class="btn btn-primary" href="/user/${user.userId}">View</a>
                        <a class="btn btn-warning" href="/user/edit/${user.userId}">Update</a>
                        <a class="btn btn-danger" href="/user/delete/${user.userId}">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:forEach var="page" begin="1" end="${totalPages}">
                    <li class="page-item${page eq currentPage ? ' active' : ''}">
                        <a class="page-link" href="?page=${page}&display=users">${page}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>

    <c:if test="${display eq 'articles'}">
        <h2>Articles</h2>
        <table class="table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="article" items="${articles}">
                <tr>
                    <td>${article.name}</td>
                    <td>${article.author_first_name} ${article.author_last_name}</td>
                    <td>${article.date}</td>
                    <td>
                        <a class="btn btn-primary" href="/article/${article.articleId}">View</a>
                        <a class="btn btn-warning" href="/article/edit/${article.articleId}">Update</a>
                        <a class="btn btn-danger" href="/article/delete/${article.articleId}">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:forEach var="page" begin="1" end="${totalPages}">
                    <li class="page-item${page eq currentPage ? ' active' : ''}">
                        <a class="page-link" href="?page=${page}&display=articles">${page}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </c:if>
</div>


<script src="<core:url value="/res/js/bootstrap.bundle.min.js" />"></script>
</body>
</html>
