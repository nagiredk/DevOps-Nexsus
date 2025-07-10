<#
.SYNOPSIS
    Creates a Maven-based Skill Management App project structure with all files and code.
.DESCRIPTION
    This script creates a complete Maven project structure for a Skill Management App
    with user registration and login functionality, including all Java classes, JSP files,
    CSS, configuration files, and pom.xml.
.NOTES
    File Name      : Create-SkillManagementMavenProject.ps1
    Prerequisites  : PowerShell 5.1 or later
#>

# Set the project name and root directory
$projectName = "skillmanagementapp"
$rootDir = Join-Path -Path $PWD.Path -ChildPath $projectName

Write-Host "Creating Maven-based Skill Management App project in: $rootDir" -ForegroundColor Cyan

# Create the root directory if it doesn't exist
if (-not (Test-Path -Path $rootDir)) {
    New-Item -ItemType Directory -Path $rootDir | Out-Null
}

# Create Maven standard directory structure
$srcMainJava = Join-Path -Path $rootDir -ChildPath "src\main\java"
$srcMainWebapp = Join-Path -Path $rootDir -ChildPath "src\main\webapp"
$srcMainWebappWEBINF = Join-Path -Path $srcMainWebapp -ChildPath "WEB-INF"
$srcMainResources = Join-Path -Path $rootDir -ChildPath "src\main\resources"
$srcTestJava = Join-Path -Path $rootDir -ChildPath "src\test\java"
$srcTestResources = Join-Path -Path $rootDir -ChildPath "src\test\resources"

# Create all Maven directories
@($srcMainJava, $srcMainWebapp, $srcMainWebappWEBINF, $srcMainResources, $srcTestJava, $srcTestResources) | ForEach-Object {
    if (-not (Test-Path -Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
    }
}

# Create package directories under src/main/java
$comDir = Join-Path -Path $srcMainJava -ChildPath "com"
$skillDir = Join-Path -Path $comDir -ChildPath "skillmanagementapp"
$daoDir = Join-Path -Path $skillDir -ChildPath "dao"
$modelDir = Join-Path -Path $skillDir -ChildPath "model"
$servletsDir = Join-Path -Path $skillDir -ChildPath "servlets"
$utilDir = Join-Path -Path $skillDir -ChildPath "util"

# Create all package directories
@($comDir, $skillDir, $daoDir, $modelDir, $servletsDir, $utilDir) | ForEach-Object {
    if (-not (Test-Path -Path $_)) {
        New-Item -ItemType Directory -Path $_ | Out-Null
    }
}

# Create webapp directories
$cssDir = Join-Path -Path $srcMainWebapp -ChildPath "css"
$jsDir = Join-Path -Path $srcMainWebapp -ChildPath "js"

# Create webapp directories
@($cssDir, $jsDir) | ForEach-Object {
    if (-not (Test-Path -Path $_)) {
        New-Item -ItemType Directory -Path $_ | Out-Null
    }
}

# Create pom.xml
$pomXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.skillmanagementapp</groupId>
    <artifactId>skillmanagementapp</artifactId>
    <version>1.0-SNAPSHOT</version>
    <packaging>war</packaging>

    <name>Skill Management App</name>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </properties>

    <dependencies>
        <!-- Servlet API -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>provided</scope>
        </dependency>

        <!-- JSTL -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jstl</artifactId>
            <version>1.2</version>
        </dependency>

        <!-- MySQL Connector -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.28</version>
        </dependency>

        <!-- Logging -->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>1.7.36</version>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>1.2.11</version>
        </dependency>
    </dependencies>

    <build>
        <finalName>skillmanagementapp</finalName>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.3.2</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
"@

Set-Content -Path (Join-Path -Path $rootDir -ChildPath "pom.xml") -Value $pomXml

# Create DatabaseConnection.java
$databaseConnectionCode = @"
package com.skillmanagementapp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static Connection connection = null;
    
    public static Connection getConnection() {
        if (connection != null) {
            return connection;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/skillmanagementapp", 
                "root", 
                "admin123");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        
        return connection;
    }
    
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
"@

Set-Content -Path (Join-Path -Path $daoDir -ChildPath "DatabaseConnection.java") -Value $databaseConnectionCode

# Create User.java
$userCode = @"
package com.skillmanagementapp.model;

public class User {
    private int id;
    private String username;
    private String email;
    private String password;
    
    // Constructors
    public User() {}
    
    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}
"@

Set-Content -Path (Join-Path -Path $modelDir -ChildPath "User.java") -Value $userCode

# Create PasswordUtil.java
$passwordUtilCode = @"
package com.skillmanagementapp.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {
    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(password.getBytes());
        byte[] mdArray = md.digest();
        StringBuilder sb = new StringBuilder(mdArray.length * 2);
        for (byte b : mdArray) {
            int v = b & 0xff;
            if (v < 16) {
                sb.append('0');
            }
            sb.append(Integer.toHexString(v));
        }
        return sb.toString();
    }
    
    public static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
}
"@

Set-Content -Path (Join-Path -Path $utilDir -ChildPath "PasswordUtil.java") -Value $passwordUtilCode

# Create UserDAO.java
$userDaoCode = @"
package com.skillmanagementapp.dao;

import com.skillmanagementapp.model.User;
import com.skillmanagementapp.util.PasswordUtil;
import java.sql.*;
import java.util.NoSuchElementException;

public class UserDAO {
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Hash the password before storing
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, hashedPassword);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User validateUser(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ?";
        User user = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String hashedInputPassword = PasswordUtil.hashPassword(password);
                
                if (storedPassword.equals(hashedInputPassword)) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }
    
    public boolean usernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
}
"@

Set-Content -Path (Join-Path -Path $daoDir -ChildPath "UserDAO.java") -Value $userDaoCode

# Create RegisterServlet.java
$registerServletCode = @"
package com.skillmanagementapp.servlets;

import com.skillmanagementapp.dao.UserDAO;
import com.skillmanagementapp.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao;
    
    public void init() {
        userDao = new UserDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (username == null || username.isEmpty() || 
            email == null || email.isEmpty() || 
            password == null || password.isEmpty()) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (userDao.usernameExists(username)) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        if (userDao.emailExists(email)) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        User user = new User(username, email, password);
        
        if (userDao.registerUser(user)) {
            request.setAttribute("success", "Registration successful! Please login.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
"@

Set-Content -Path (Join-Path -Path $servletsDir -ChildPath "RegisterServlet.java") -Value $registerServletCode

# Create LoginServlet.java
$loginServletCode = @"
package com.skillmanagementapp.servlets;

import com.skillmanagementapp.dao.UserDAO;
import com.skillmanagementapp.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao;
    
    public void init() {
        userDao = new UserDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = userDao.validateUser(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
"@

Set-Content -Path (Join-Path -Path $servletsDir -ChildPath "LoginServlet.java") -Value $loginServletCode

# Create LogoutServlet.java
$logoutServletCode = @"
package com.skillmanagementapp.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}
"@

Set-Content -Path (Join-Path -Path $servletsDir -ChildPath "LogoutServlet.java") -Value $logoutServletCode

# Create register.jsp
$registerJsp = @"
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skill Management App - Register</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Register</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form action="register" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            
            <button type="submit" class="btn">Register</button>
        </form>
        
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
"@

Set-Content -Path (Join-Path -Path $srcMainWebapp -ChildPath "register.jsp") -Value $registerJsp

# Create login.jsp
$loginJsp = @"
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skill Management App - Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn">Login</button>
        </form>
        
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>
"@

Set-Content -Path (Join-Path -Path $srcMainWebapp -ChildPath "login.jsp") -Value $loginJsp

# Create dashboard.jsp
$dashboardJsp = @"
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Skill Management App - Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Welcome, ${user.username}!</h1>
        <p>Email: ${user.email}</p>
        
        <a href="logout" class="btn">Logout</a>
    </div>
</body>
</html>
"@

Set-Content -Path (Join-Path -Path $srcMainWebapp -ChildPath "dashboard.jsp") -Value $dashboardJsp

# Create error.jsp
$errorJsp = @"
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
"@

Set-Content -Path (Join-Path -Path $srcMainWebapp -ChildPath "error.jsp") -Value $errorJsp

# Create style.css
$styleCss = @"
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container {
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    width: 300px;
    text-align: center;
}

h1 {
    margin-bottom: 20px;
    color: #333;
}

.form-group {
    margin-bottom: 15px;
    text-align: left;
}

label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

input {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.btn {
    background: #5cb85c;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 10px;
}

.btn:hover {
    background: #4cae4c;
}

.alert {
    padding: 10px;
    margin-bottom: 15px;
    border-radius: 4px;
}

.alert-danger {
    background: #f2dede;
    color: #a94442;
    border: 1px solid #ebccd1;
}

.alert-success {
    background: #dff0d8;
    color: #3c763d;
    border: 1px solid #d6e9c6;
}

a {
    color: #337ab7;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}
"@

Set-Content -Path (Join-Path -Path $cssDir -ChildPath "style.css") -Value $styleCss

# Create web.xml
$webXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee 
         http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    
    <display-name>Skill Management App</display-name>
    
    <welcome-file-list>
        <welcome-file>login.jsp</welcome-file>
    </welcome-file-list>
    
    <error-page>
        <error-code>404</error-code>
        <location>/error.jsp</location>
    </error-page>
    
    <error-page>
        <error-code>500</error-code>
        <location>/error.jsp</location>
    </error-page>
</web-app>
"@

Set-Content -Path (Join-Path -Path $srcMainWebappWEBINF -ChildPath "web.xml") -Value $webXml

Write-Host "Maven project created successfully!" -ForegroundColor Green
Write-Host "Location: $rootDir" -ForegroundColor Yellow
Write-Host "You can now import this as a Maven project in your IDE." -ForegroundColor Cyan