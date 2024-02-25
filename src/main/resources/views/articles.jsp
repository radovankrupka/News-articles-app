<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/css/bootstrap.min.css" integrity="sha512-usVBAd66/NpVNfBge19gws2j6JZinnca12rAe2l+d+QkLU9fiG02O1X8Q6hepIpr/EYKZvKx/I9WsnujJuOmBA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <title>CRUD App</title>
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
                        alt="RK Logo"
                        loading="lazy"
                />
            </a>
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="/">Home</a>
                </li>
                <sec:authorize access="isAuthenticated()">
                    <li class="nav-item px-2">
                        <a class="nav-link btn btn-outline-primary" href="/article/new">Add article</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasRole('ADMIN')">
                    <div class="btn-group">
                         <a href="/admin" class="btn btn-outline-danger">Admin panel</a>
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
            <div class="d-flex align-items-center">

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
                                    src="${currentUser.img_link}"
                                    class="rounded-circle"
                                    height="45"
                                    alt="profile photo"
                                    loading="lazy"

                            />
                        </div>

                        <ul class="dropdown-menu" aria-labelledby="dropstartMenuButton" >
                            <li><h6 class="dropdown-header">User actions</h6></li>

                            <li><a class="dropdown-item" href="/user/${currentUser.userId}">My profile</a></li>
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

<div class="container container-fluid my-5 ">
    <div class="container container-fluid"></div>
    <h1 class="text-center txt-color">Articles</h1>
    <div class="container col-offset-2 col-8">
        <h5 class="text-center mt-4 mb-5 txt-color main-heading">
            There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in form. Lorem ipsum dolor sit
            amet, cons ectetuer adipiscing elit.
        </h5>
    </div>
    <div class="container container-fluid">
        <div class="row">
            <c:forEach items="${articles}" var="article">
                <div class="col-sm-12 col-md-6 col-xl-4 txt-color">
                    <div class="card mb-3 rounded-3 position-relative" style="height: 500px;">
                        <div class="d-flex justify-content-center align-items-center img-div mt-3" style="position: relative;">
                            <img class="img-content img-fluid"
                                 src="${article.img_link}" alt="Card image cap"
                                 style="max-width: 300px; max-height: 230px;">
                            <a href="/article/${article.articleId}" class="stretched-link"></a>
                        </div>
                        <div class="card-body txt-color p-4 ">
                            <div style="transform: rotate(0);">
                            <p class="card-date fw-300 mt-2 mb-1">
                                <fmt:formatDate value="${article.date}" type="both"/>
                            </p>
                            <h5 class="card-title mb-3">${article.name}</h5>
                            <p class="card-text fw-300">${fn:length(article.text) gt 100 ? fn:substring(article.text, 0, 100).concat('...') :article.text}</p>
                            <footer class="blockquote-footer mt-2">${article.author_first_name} ${article.author_last_name}</footer>
                            <a href="/article/${article.articleId}" class="stretched-link"></a>
                            </div>
                            <sec:authorize access="isAuthenticated()">
                                <c:if test="${currentUser != null && currentUser.userId == article.author_id }">
                                    <div>
                                        <a class="card-link link-warning" style="position: relative;" href="/article/edit/${article.articleId}">Edit</a>
                                        <a class="card-link link-danger" style="position: relative;" href="/article/delete/${article.articleId}"
                                           onclick="return confirmDelete();">Delete</a>
                                    </div>
                                </c:if>
                            </sec:authorize>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="container container-fluid">
        <div class="d-flex justify-content-center">
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage gt 1}">
                    <li class="page-item"><a class="page-link" href="?page=0">First</a></li>
                    <li class="page-item"><a class="page-link" href="?page=${currentPage - 2}">Previous</a></li>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <c:choose>
                        <c:when test="${currentPage eq i}">
                            <li class="page-item active"><a class="page-link" href="?page=${i-1}">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="?page=${i-1}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${currentPage lt totalPages}">
                    <li class="page-item"><a class="page-link" href="?page=${currentPage}">Next</a></li>
                    <li class="page-item"><a class="page-link" href="?page=${totalPages - 1}">Last</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</div>

<script src="<core:url value="/res/js/bootstrap.bundle.min.js" />"></script>
<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this article?");
    }
</script>

</body>
</html>