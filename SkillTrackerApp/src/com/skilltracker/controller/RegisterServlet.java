package com.skilltracker.controller;

import com.skilltracker.dao.UserDAO;
import com.skilltracker.dao.UserDAOImpl;
import com.skilltracker.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        
        try {
            if (userDAO.registerUser(user)) {
                response.sendRedirect("login.jsp?registration=success");
            } else {
                request.setAttribute("error", "Registration failed. Username or email may already exist.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed due to server error.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
