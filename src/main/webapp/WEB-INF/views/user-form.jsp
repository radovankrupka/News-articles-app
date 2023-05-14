<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <!-- Navbar content -->
</nav>

<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-sm-9 col-md-6 main">
            <h1 class="page-header">User management</h1>

            <form action="/user/edit/${currentUser.userId}" method="post" enctype="multipart/form-data" class="form-group">
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label for="first_name">First Name</label>
                            <input type="text" class="form-control" id="first_name" name="first_name" value="${currentUser.first_name}">
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label for="last_name">Last Name</label>
                            <input type="text" class="form-control" id="last_name" name="last_name" value="${currentUser.last_name}">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="about">About</label>
                    <textarea class="form-control" id="about" name="about" rows="5">${currentUser.about}</textarea>
                </div>
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" class="form-control" id="city" name="city" value="${currentUser.city}">
                </div>
                <div class="form-group text-center">
                    <button type="submit" class="btn btn-primary mt-4">Update</button>
                </div>
            </form>

        </div>
    </div>
</div>

</body>
</html>
