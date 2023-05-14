<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <title>CRUD App</title>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <a class="navbar-brand mt-2 mt-lg-0" href="#">
                <img
                        src="https://mdbcdn.b-cdn.net/img/logo/mdb-transaprent-noshadows.webp"
                        height="15"
                        alt="MDB Logo"
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
            </ul>
        </div>
        <sec:authorize access="isAuthenticated()">
            <div class="d-flex align-items-center">
                <div class="nav-item">
                    <a
                            class="d-flex align-items-center"
                            href="/user"
                            id="navbarDropdownMenuAvatar"
                            role="button"
                            data-mdb-toggle="dropdown"
                            aria-expanded="false"
                    >
                        <span class="me-3">My profile</span>
                        <img
                                src="https://mdbcdn.b-cdn.net/img/new/avatars/2.webp"
                                class="rounded-circle"
                                height="45"
                                alt="Black and White Portrait of a Man"
                                loading="lazy"
                        />
                    </a>
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
                    <div class="card mb-3 rounded-3 position-relative" style="height: 450px;">
                        <div class="d-flex justify-content-center align-items-center img-div" style="position: relative;">
                                <%--TODO: pre kazdy article pridat link k relevantnemu obrazku--%>
                            <img class="img-content" src="https://i.ibb.co/Y7ZNfbJ/placeholder.png" alt="Card image cap" >
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
                                <c:if test="${currentUser != null && currentUser.userId == article.author_id}">
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

<%--
TODO: ?? pridaj grafy so statistikami (kolacovy graf - pocet clankov podla kategorie)
--%>
<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this article?");
    }
</script>
</body>
</html>