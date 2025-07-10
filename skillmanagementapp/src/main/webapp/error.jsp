<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Error</h1>
        <p>Sorry, an error occurred while processing your request.</p>
        <p>Error details: <%= exception != null ? exception.getMessage() : "Unknown error" %></p>
        <a href="login.jsp" class="btn">Go to Login</a>
    </div>
</body>
</html>
