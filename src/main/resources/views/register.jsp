<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
          integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>


<section class="vh-100 bg-image"
         style="background-image: url('https://mdbcdn.b-cdn.net/img/Photos/new-templates/search-box/img4.webp');">
    <div class="mask d-flex align-items-center h-100 gradient-custom-3">
        <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card" style="border-radius: 15px;">
                        <div class="card-body p-5">
                            <h2 class="text-uppercase text-center mb-5">Create an account</h2>

                            <c:forEach items="${errors}" var="error">
                                <p style="color: red">${error.defaultMessage}</p>
                            </c:forEach>

                            <form action="/register" th:object="${user}" method="post">

                                <div class="form-outline mb-4">
                                    <input type="text" name="firstName" id="form3Example1cg" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="form3Example1cg">First Name</label>
<%--
                                    <p th:each="error: ${#fields.errors('firstName')}" th:text="${error}">Validation error</p>
--%>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="text" name="lastName" id="form3Example2cg" class="form-control form-control-lg" required />
                                    <label class="form-label" for="form3Example1cg">Last Name</label>
<%--
                                    <p th:each="error : ${#fields.errors('lastName')}"  th:text="${error}">Validation error</p>
--%>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="text" name="username" id="form3Example3cg" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="form3Example3cg">Username</label>
<%--
                                    <p th:each="error : ${#fields.errors('username')}" th:text="${error}">Validation error</p>
--%>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="password" name="password" id="form3Example4cg" class="form-control form-control-lg" required/>
                                    <label class="form-label" for="form3Example4cg">Password</label>
<%--
                                    <p th:each="error : ${#fields.errors('password')}" th:text="${error}">Validation error</p>
--%>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="password" name="matchingPassword" id="form3Example5cg" class="form-control form-control-lg"
                                           th:field="*{matchingPassword}"/>
                                    <label class="form-label" for="form3Example5cg" >Confirm password</label>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <button type="submit"
                                            class="btn btn-success btn-block btn-lg gradient-custom-4 text-body">Register</button>
                                </div>

                                <p class="text-center text-muted mt-5 mb-0">Already have an account? <a href="/login"
                                                                                                        class="fw-bold text-body"><u>Login here</u></a></p>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>