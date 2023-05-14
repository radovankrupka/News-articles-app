<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
                <sec:authorize access="isAuthenticated()">
                    <c:if test="${currentUser != null && currentUser.userId == article.author_id}">
                        <li class="nav-item px-2">
                            <a class="nav-link btn btn-outline-warning" href="/article/edit/${article.articleId}">Edit article</a>
                        </li>
                    </c:if>
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

<div class="container">
    <h1 class="my-4">${article.name}</h1>
    <div class="row">

        <div class="col-md-8">
            <img class="img-fluid" src="https://via.placeholder.com/750x500" alt="">
        </div>

        <div class="col-md-4">
            <h3 class="my-3">Article Description</h3>
            <p>${article.text}</p>
            <h3 class="my-3">Article Details</h3>
            <ul>
                <li>Author: ${article.author_first_name} ${article.author_last_name}</li>
                <li>Date: ${article.date}</li>
            </ul>
        </div>

    </div>
    //TODO: related articles podla kategorie - 4 ks
    <h3 class="my-4">Related articles for this category:</h3>

    <div class="row">
        <div class="col-md-3 col-sm-6 mb-4">
            <a href="#">
                <img class="img-fluid" src="https://via.placeholder.com/500x300" alt="">
            </a>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
            <a href="#">
                <img class="img-fluid" src="https://via.placeholder.com/500x300" alt="">
            </a>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
            <a href="#">
                <img class="img-fluid" src="https://via.placeholder.com/500x300" alt="">
            </a>
        </div>
        <div class="col-md-3 col-sm-6 mb-4">
            <a href="#">
                <img class="img-fluid" src="https://via.placeholder.com/500x300" alt="">
            </a>
        </div>
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
                            <img class="rounded-circle" src="https://i.imgur.com/RpzrMR2.jpg" width="40">
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
                            <img class="rounded-circle" src="https://i.imgur.com/RpzrMR2.jpg" width="40">
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
