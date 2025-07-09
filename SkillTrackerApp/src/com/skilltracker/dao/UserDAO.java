package com.skilltracker.dao;

import com.skilltracker.model.User;
import com.skilltracker.model.Skill;
import java.sql.SQLException;
import java.util.List;

public interface UserDAO {
    boolean registerUser(User user) throws SQLException;
    User validateUser(String username, String password) throws SQLException;
    boolean addSkillsToUser(int userId, List<Skill> skills) throws SQLException;
    List<Skill> getUserSkills(int userId) throws SQLException;
    List<Skill> getAllSkills() throws SQLException;
}
