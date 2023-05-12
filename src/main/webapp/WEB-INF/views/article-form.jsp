<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Article</title>
</head>
<body>
<h1>Add New Article</h1>
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
