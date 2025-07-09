<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Skills</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Skill Tracker</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                <a class="nav-link" href="logout">Logout</a>
            </div>
        </div>
    </nav>
    
    <div class="container mt-5">
        <h2>My Skills</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success mt-3">Skills updated successfully!</div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger mt-3"> 

 
This site https://dev.mysql.com/get/Downloads/Connector-Net/mysql-connector-net-8.0.33.zip is experiencing technical difficulty. We are aware of the issue and are working as quick as possible to correct the issue. 

We apologize for any inconvenience this may have caused. 

To speak with an Oracle sales representative: 1.800.ORACLE1.

To contact Oracle Corporate Headquarters from anywhere in the world: 1.650.506.7000.

To get technical support in the United States: 1.800.633.0738. 
 

 
Incident Number: 18.be3b4017.1751990588.1e7a5cfe Cannot bind parameter 'Path' to the target. Exception setting "Path": "Cannot find path 'C:\Program Files (x86)\MySQL\MySQL Connector Net 8.0\Assemblies\v4.5.2\MySql.Data.dll' because it does not exist." Cannot find type [MySql.Data.MySqlClient.MySqlConnection]: verify that the assembly containing this type is loaded. The specified module 'SqlServer' was not loaded because no valid module file was found in any module directory. Cannot find path 'C:\Users\konda.r.nagireddy\C' because it does not exist.</div>
        <% } %>
        
        <form action="skills" method="post">
            <table class="table table-bordered mt-4">
                <thead class="table-dark">
                    <tr>
                        <th>Skill</th>
                        <th>Proficiency (1-10)</th>
                        <th>Select</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="skill" items="">
                        <tr>
                            <td></td>
                            <td>
                                <input type="number" name="proficiency" min="1" max="10" class="form-control" value="5">
                            </td>
                            <td>
                                <input type="checkbox" name="skills" value="" class="form-check-input">
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button type="submit" class="btn btn-primary">Save Skills</button>
        </form>
        
        <h3 class="mt-5">Your Current Skills</h3>
        <c:choose>
            <c:when test="">
                <table class="table table-bordered mt-3">
                    <thead class="table-dark">
                        <tr>
                            <th>Skill</th>
                            <th>Proficiency</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="skill" items="">
                            <tr>
                                <td></td>
                                <td>/10</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info mt-3">You haven't added any skills yet.</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
