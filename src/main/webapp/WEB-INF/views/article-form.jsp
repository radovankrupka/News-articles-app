<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%--
<html>
<head>
    <title>Add New Article</title>
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

<h1>Article management</h1>
<form method="post" action="/article/new">

    <label>Title:</label>
    <input type="text" name="name" required><br>


    <label>Text:</label>
    <textarea name="text" required></textarea><br>


    <label>Categories (separated by commas):</label>
    <input type="text" name="category" required><br>

    <input type="submit" value="Add Article">
</form>
</body>
</html>
--%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Article Front-End Bootstrap Template</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" href="http://getbootstrap.com/examples/dashboard/dashboard.css">
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script src="http://cdn.ckeditor.com/4.4.7/full/ckeditor.js"></script>
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function(){
            $('#nav').load('elements/nav.html');
        });
    </script>
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
<%--
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-sm-9 col-md-8 main">
            <h1 class="page-header">Add new Article</h1>

            <form action="" method="post" enctype="multipart/form-data" class="form-group">
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" class="form-control col-xs-4 col-md-3" id="title" placeholder="Title">
                </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-7 col-md-9">
                        <div class="form-group">
                            <textarea name="content" id="text"></textarea>
                            <script>CKEDITOR.replace('content');</script>
                        </div>
                    </div>
                    <div class="col-xs-5 col-md-3">
                        <div class="form-group">
                            <label for="">Category</label>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="">
                                    Category 1
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" value="" disabled>
                                    Category 2
                                </label>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">Publish</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>--%>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-sm-9 col-md-6 main">
            <h1 class="page-header">Article management</h1>

            <form action="/article" method="post" enctype="multipart/form-data" class="form-group">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Name" value="${article.name}">
                </div>
                <div class="form-group">
                    <label for="text">Text</label>
                    <textarea class="form-control" id="text" name="text" rows="5" placeholder="Text">${article.text}</textarea>
                </div>
                <div class="form-group">
                    <label for="category">Category</label>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="category" value="Category 1" ${article.category.contains('Category') ?'checked' : ''}>
                            Category 1
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="category" value="Self-Improvement"
                                ${article.category.contains('Self-Improvement') ?'checked' : ''}>
                            Self-Improvement
                        </label>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="category" value="Psychology"
                                ${article.category.contains('Psychology') ?'checked' : ''}>
                            Psychology
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Publish</button>
                </div>
            </form>
        </div>
    </div>
</div>



</body>
</html>