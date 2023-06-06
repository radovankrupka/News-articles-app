<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Page</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

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
                                    src="${currentUser.img_link}"
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
<section class="h-100 gradient-custom-2">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-lg-9 col-xl-7">
                <div class="card">
                    <div class="rounded-top text-white d-flex flex-row" style="background-color: #000; height:200px;">
                        <div class="ms-4 mt-5 d-flex flex-column" style="width: 150px;">
                            <img src="${currentUser.img_link}"
                                 alt="Generic placeholder image" class="img-fluid img-thumbnail mt-4 mb-2"
                                 style="width: 150px; z-index: 1">
                            <button type="button" onclick="location.href='/user/edit/${currentUser.userId}'" class="btn btn-outline-dark"
                            data-mdb-ripple-color="dark" style="z-index: 1;">
                                Edit profile
                            </button>
                        </div>
                        <div class="ms-3" style="margin-top: 130px;">
                            <h5 >${currentUser.first_name} ${currentUser.last_name}</h5>
                            <p>${currentUser.city}</p>
                        </div>
                    </div>
                    <div class="p-4 text-black" style="background-color: #f8f9fa;">
                        <div class="d-flex justify-content-end text-center py-1">
                            <div>
                                <p class="mb-1 h5">25</p>
                                <p class="small text-muted mb-0">Articles</p>
                            </div>
                            <div class="px-3">
                                <p class="mb-1 h5">17</p>
                                <p class="small text-muted mb-0">Comments</p>
                            </div>
                            <div>
                                <p class="mb-1 h5">48</p>
                                <p class="small text-muted mb-0">Likes</p>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-4 text-black">
                        <div class="mb-5">
                            <p class="lead fw-normal mb-1">About</p>
                            <div class="p-4" style="background-color: #f8f9fa;">
                                <p class="font-italic mb-0">${currentUser.about}</p>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <p class="lead fw-normal mb-0">Recent articles</p>
                        </div>

                        <div class="row">
                            <c:forEach var="article" items="${articles}">
                                <div class="col-sm-6">
                                    <div class="card mb-3 rounded-3 position-relative" style="height: 420px;">
                                        <div class="d-flex justify-content-center align-items-center img-div mt-3" style="position: relative;">
                                            <img class="img-content img-fluid" src="${article.img_link}" alt="Card image cap"
                                                         style="max-width: 180px; max-height: 150px;">
                                            <a href="/article/${article.articleId}" class="stretched-link"></a>
                                        </div>
                                        <div class="card-body txt-color p-4 ">
                                            <div style="transform: rotate(0);">
                                                <p class="card-date fw-300 mt-2 mb-1">
                                                    <fmt:formatDate value="${article.date}" type="both"/>
                                                </p>
                                                <h6 class="card-title mb-3 ">${article.name}</h6>
                                                <p class="card-text fw-light">${fn:length(article.text) gt 100 ?
                                                fn:substring(article.text, 0, 100).concat('...') :article.text}</p>
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
                </div>

            </div>

        </div>
    </div>
</section>

<script src="<core:url value="/res/js/bootstrap.bundle.min.js" />"></script>
</body>
</html>
