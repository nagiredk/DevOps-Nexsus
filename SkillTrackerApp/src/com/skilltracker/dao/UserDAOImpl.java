package com.skilltracker.dao;

import com.skilltracker.model.User;
import com.skilltracker.model.Skill;
import com.skilltracker.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    
    @Override
    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public User validateUser(String username, String password) throws SQLException {
        String sql = "SELECT id, username, email FROM users WHERE username = ? AND password = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    return user;
                }
            }
        }
        return null;
    }

    @Override
    public boolean addSkillsToUser(int userId, List<Skill> skills) throws SQLException {
        if (skills == null || skills.isEmpty()) {
            return false;
        }
        
        String sql = "INSERT INTO user_skills (user_id, skill_id, proficiency_level) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE proficiency_level = VALUES(proficiency_level)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            conn.setAutoCommit(false);
            
            for (Skill skill : skills) {
                stmt.setInt(1, userId);
                stmt.setInt(2, skill.getId());
                stmt.setInt(3, skill.getProficiency());
                stmt.addBatch();
            }
            
            int[] results = stmt.executeBatch();
            conn.commit();
            
            for (int result : results) {
                if (result <= 0) return false;
            }
            return true;
        }
    }

    @Override
    public List<Skill> getUserSkills(int userId) throws SQLException {
        List<Skill> skills = new ArrayList<>();
        
        String sql = "SELECT s.id, s.name, us.proficiency_level " +
                     "FROM skills s JOIN user_skills us ON s.id = us.skill_id " +
                     "WHERE us.user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Skill skill = new Skill();
                    skill.setId(rs.getInt("id"));
                    skill.setName(rs.getString("name"));
                    skill.setProficiency(rs.getInt("proficiency_level"));
                    skills.add(skill);
                }
            }
        }
        return skills;
    }

    @Override
    public List<Skill> getAllSkills() throws SQLException {
        List<Skill> skills = new ArrayList<>();
        
        String sql = "SELECT id, name FROM skills";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Skill skill = new Skill();
                skill.setId(rs.getInt("id"));
                skill.setName(rs.getString("name"));
                skills.add(skill);
            }
        }
        return skills;
    }
}
