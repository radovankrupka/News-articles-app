<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
    <title>${article.name}</title>
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

                <sec:authorize access="isAuthenticated()">
                    <c:if test="${currentUser != null && currentUser.userId == article.author_id}">
                        <li class="nav-item px-2">
                            <a class="nav-link btn btn-outline-warning" href="/article/edit/${article.articleId}">Edit article</a>
                        </li>
                    </c:if>
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

<div class="container">
    <h1 class="my-4">${article.name}</h1>
    <div class="row">

        <div class="col-md-8">
            <img class="img-content img-fluid"
                 src="${article.img_link}" alt="Card image cap"
                 style="max-width: 750px; max-height: 500px;">
        </div>

        <div class="col-md-4">
            <h3 class="my-3">Article Description</h3>
            <p>${article.text}</p>
            <h3 class="my-3">Article Details</h3>
            <ul>
                <li>Author: ${article.author_first_name} ${article.author_last_name}</li>
                <li>Date: ${article.date}</li>
            </ul>
            <h5 class="my-3">Category</h5>
            <ul>
                <c:forEach var="category" items="${article.category}">
                    <li>${category}</li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <h3 class="my-4">Related articles for this category:</h3>


    <div class="row">
        <c:forEach var="article" items="${relatedArticles}">
            <div class="col-sm-3">
                <div class="card mb-3 rounded-3 position-relative" style="height: 400px;">
                    <div class="d-flex justify-content-center align-items-center img-div mt-3" style="position: relative;">
                        <img class="img-content img-fluid" src="${article.img_link}" alt="Card image cap"
                             style="max-width: 180px; max-height: 150px;">
                        <a href="/article/${article.articleId}" class="stretched-link"></a>
                    </div>
                    <div class="card-body txt-color p-4">
                        <div style="transform: rotate(0);">
                            <p class="card-date fw-300 mt-2 mb-1">
                                <fmt:formatDate value="${article.date}" type="both"/>
                            </p>
                            <h5 class="card-title mb-3 small">${article.name}</h5>
                            <p class="card-text fw-300 small">${fn:length(article.text) gt 75 ? fn:substring(article.text, 0, 75).concat('...') :
                            article.text}</p>
                            <footer class="blockquote-footer mt-2">${article.author_first_name} ${article.author_last_name}</footer>
                            <a href="/article/${article.articleId}" class="stretched-link"></a>
                        </div>
                        <sec:authorize access="isAuthenticated()">
                            <c:if test="${currentUser != null && currentUser.userId == article.author_id}">
                                <div>
                                    <a class="card-link link-warning" style="position: relative;" href="/article/edit/${article.articleId}">Edit</a>
                                    <a class="card-link link-danger" style="position: relative;" href="/article/delete/${article.articleId}" onclick="return confirmDelete();">Delete</a>
                                </div>
                            </c:if>
                        </sec:authorize>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>



</div>

<div class="container mt-5">
    <div class="d-flex justify-content-center row">
        <div class="col-md-8">
            <div class="d-flex flex-column comment-section">
                <h3>Comments</h3>
                <c:forEach var="comment" items="${article.comments}">
                    <div class="bg-white p-2">
                        <div class="d-flex flex-row user-info">
                            <img class="rounded-circle mr-2" src="https://i.imgur.com/RpzrMR2.jpg" width="40">
                            <div class="d-flex flex-column justify-content-start ml-2">
                                <span class="d-block font-weight-bold name">${comment.author_first_name} ${comment.author_last_name}</span>
                                <span class="date text-black-50">
                                    <fmt:formatDate value="${comment.date}" type="both"/>
                                </span>
                            </div>
                        </div>
                        <div class="mt-2">
                            <p class="comment-text">${comment.comment_text}</p>
                        </div>
                    </div>
                </c:forEach>

                <sec:authorize access="isAuthenticated()">
                    <div class="bg-light p-2">
                        <div class="d-flex flex-row align-items-start">
                            <img class="rounded-circle" src="${currentUser.img_link}" width="40">
                            <form method="post" action="/article/comment" class="col">
                                <textarea class="form-control ml-1 shadow-none textarea" name="commentText"></textarea>
                                <input type="hidden" name="articleId" value="${article.articleId}">
                                <button class="btn btn-primary btn-sm shadow-none" type="submit">Post comment</button>
                                <button class="btn btn-outline-primary btn-sm ml-1 shadow-none" type="button">Cancel</button>
                            </form>
                        </div>
                    </div>
                </sec:authorize>

                <sec:authorize access="!isAuthenticated()">
                <div class="bg-light p-2">
                        <div class="d-flex flex-row">
                            <p class="mr-3">To post comments, please login ->  </p>
                            <a class="btn btn-primary " href="/login">Login</a>
                        </div>
                    </div>
                </sec:authorize>
            </div>
        </div>
    </div>
</div>
<script src="<core:url value="/res/js/bootstrap.bundle.min.js" />"></script>
</body>
</html>
