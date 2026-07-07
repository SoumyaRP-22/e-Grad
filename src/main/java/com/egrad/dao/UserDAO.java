package com.egrad.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.egrad.connection.DBConnection;
import com.egrad.models.User;

public class UserDAO {

    public boolean registerUser(User user) {
        boolean isSuccess = false;
        
        String query = "INSERT INTO users (name, email, password, role, program, semester) VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            
            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPassword());
            pst.setString(4, user.getRole());
            pst.setString(5, user.getProgram());
            pst.setString(6, user.getSemester());
            
            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.out.println("Error saving user to DB:");
            e.printStackTrace();
        }
        return isSuccess;
    }
    
    public User loginUser(String email, String password) {
        User user = null;
        
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            
            pst.setString(1, email);
            pst.setString(2, password);
            
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setProgram(rs.getString("program"));
                user.setSemester(rs.getString("semester"));
                user.setMobile(rs.getString("mobile"));
                user.setDob(rs.getString("dob"));
                user.setBloodGroup(rs.getString("blood_group"));
                user.setFathersName(rs.getString("fathers_name"));
                user.setAddress(rs.getString("address"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error during login: ");
            e.printStackTrace();
        }
        
        return user;
    }
    
    public boolean updateUserProfile(User user) {
        boolean isSuccess = false;
        
        String query = "UPDATE users SET name=?, mobile=?, dob=?, blood_group=?, fathers_name=?, address=? WHERE id=?";
        
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            
            pst.setString(1, user.getName());
            pst.setString(2, user.getMobile());
            pst.setString(3, user.getDob());
            pst.setString(4, user.getBloodGroup());
            pst.setString(5, user.getFathersName());
            pst.setString(6, user.getAddress());
            pst.setInt(7, user.getId()); 
            
            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.out.println("Error updating user profile:");
            e.printStackTrace();
        }
        return isSuccess;
    }
}