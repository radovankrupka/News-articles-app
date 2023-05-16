<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Article management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

</head>
<body>
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
            </ul>
        </div>
        <sec:authorize access="isAuthenticated()">
            <div class="d-flex align-items-center" >
                <div class="nav-item ">
                    <div class="dropstart">
                        <div id="dropstartMenuButton dropdown-toggle" aria-expanded="false" data-bs-toggle="dropdown">
                            <img
                                    src="<core:url value="/res/png/6086462.png"/>"
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

<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-sm-9 col-md-6 main">
            <h1 class="page-header">Article management</h1>

            <form action="/article" method="post" enctype="multipart/form-data" class="form-group">

                    <input type="hidden" class="form-control" name="articleId" value="${article.articleId != null ? article.articleId :
                    '645e96a2e5eb568e2c40fb67'}">

                <div class="form-group">
                    <label for="name">Title</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Title" value="${article.name}">
                </div>
                <div class="form-group">
                    <label for="text">Text</label>
                    <textarea class="form-control" id="text" name="text" rows="5" placeholder="Text">${article.text}</textarea>
                </div>
                <div class="form-group">
                    <label for="category">Category</label>
                    <div class="row">
                        <c:forEach var="category" items="${categories}" varStatus="status">
                            <div class="col-md-6">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="category" value="${category}" ${article.category.contains(category) ? 'checked' : ''}>
                                                ${category}
                                        </label>
                                    </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Publish</button>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="<core:url value="/res/js/bootstrap.bundle.min.js" />"></script>

</body>
</html>