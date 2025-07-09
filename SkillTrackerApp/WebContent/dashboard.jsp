<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Skill Tracker</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="skills">My Skills</a>
                <a class="nav-link" href="logout">Logout</a>
            </div>
        </div>
    </nav>
    
    <div class="container mt-5">
        <h2>Welcome, !</h2>
        <p class="lead">Manage your skills and profile.</p>
        
        <div class="card mt-4">
            <div class="card-header">
                Quick Actions
            </div>
            <div class="card-body">
                <a href="skills" class="btn btn-primary">Update Skills</a>
            </div>
        </div>
    </div>
</body>
</html>
