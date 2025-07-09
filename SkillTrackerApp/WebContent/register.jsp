<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5" style="max-width: 400px;">
        <h2 class="mb-4">Register</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"> 

 
This site https://dev.mysql.com/get/Downloads/Connector-Net/mysql-connector-net-8.0.33.zip is experiencing technical difficulty. We are aware of the issue and are working as quick as possible to correct the issue. 

We apologize for any inconvenience this may have caused. 

To speak with an Oracle sales representative: 1.800.ORACLE1.

To contact Oracle Corporate Headquarters from anywhere in the world: 1.650.506.7000.

To get technical support in the United States: 1.800.633.0738. 
 

 
Incident Number: 18.be3b4017.1751990588.1e7a5cfe Cannot bind parameter 'Path' to the target. Exception setting "Path": "Cannot find path 'C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0\Assemblies\v4.5.2\MySql.Data.dll' because it does not exist." Cannot find type [MySql.Data.MySqlClient.MySqlConnection]: verify that the assembly containing this type is loaded. The specified module 'SqlServer' was not loaded because no valid module file was found in any module directory. Cannot find path 'C:\Users\konda.r.nagireddy\C' because it does not exist.</div>
        <% } %>
        
        <form action="register" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
            <a href="login.jsp" class="btn btn-link">Login</a>
        </form>
    </div>
</body>
</html>
