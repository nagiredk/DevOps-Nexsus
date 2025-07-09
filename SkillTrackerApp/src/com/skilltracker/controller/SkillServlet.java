package com.skilltracker.controller;

import com.skilltracker.dao.UserDAO;
import com.skilltracker.dao.UserDAOImpl;
import com.skilltracker.model.Skill;
import com.skilltracker.model.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/skills")
public class SkillServlet extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            List<Skill> skills = userDAO.getUserSkills(user.getId());
            List<Skill> allSkills = userDAO.getAllSkills();
            request.setAttribute("userSkills", skills);
            request.setAttribute("allSkills", allSkills);
            request.getRequestDispatcher("skills.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load skills.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String[] skillIds = request.getParameterValues("skills");
        String[] proficiencies = request.getParameterValues("proficiency");
        
        List<Skill> skills = new ArrayList<>();
        if (skillIds != null) {
            for (int i = 0; i < skillIds.length; i++) {
                Skill skill = new Skill();
                skill.setId(Integer.parseInt(skillIds[i]));
                skill.setProficiency(Integer.parseInt(proficiencies[i]));
                skills.add(skill);
            }
        }
        
        try {
            if (userDAO.addSkillsToUser(user.getId(), skills)) {
                response.sendRedirect("skills?success=true");
            } else {
                request.setAttribute("error", "Failed to save skills.");
                request.getRequestDispatcher("skills.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to save skills due to server error.");
            request.getRequestDispatcher("skills.jsp").forward(request, response);
        }
    }
}
