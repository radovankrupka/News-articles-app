<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
            <div class="d-flex align-items-center" >
                <div class="nav-item">
                    <a
                            class="d-flex align-items-center"
                            href="/user"
                            id="navbarDropdownMenuAvatar"
                            role="button"
                            data-mdb-toggle="dropdown"
                            aria-expanded="false"
                    >
                        <span class="me-3" >My profile</span>
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
<section class="h-100 gradient-custom-2">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-lg-9 col-xl-7">
                <div class="card">
                    <div class="rounded-top text-white d-flex flex-row" style="background-color: #000; height:200px;">
                        <div class="ms-4 mt-5 d-flex flex-column" style="width: 150px;">
                            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-profiles/avatar-1.webp"
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
                                <%--TODO: zobraz realne pocty ?--%>
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


                        <%--TODO: ?? pridaj grafy so statistikami (Stlpcovy graf - pocet clankov tohto usera oproti ostatnym)--%>

                        <div class="row">
                            <c:forEach var="article" items="${articles}">
                                <div class="col-sm-6">
                                    <div class="card mb-3 rounded-3 position-relative" style="height: 350px;">
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
                </div>

            </div>

        </div>
    </div>
</section>


</body>
</html>
