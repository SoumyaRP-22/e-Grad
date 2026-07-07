package com.egrad.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.egrad.dao.UserDAO;
import com.egrad.models.User;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("loggedUser");

        String newName = request.getParameter("name");
        String newMobile = request.getParameter("mobile"); 
        String newDob = request.getParameter("dob");
        String newBloodGroup = request.getParameter("blood_group");
        String newFathersName = request.getParameter("fathers_name");
        String newAddress = request.getParameter("address");

        currentUser.setName(newName);
        currentUser.setMobile(newMobile); 
        currentUser.setDob(newDob);
        currentUser.setBloodGroup(newBloodGroup);
        currentUser.setFathersName(newFathersName);
        currentUser.setAddress(newAddress);

        UserDAO dao = new UserDAO();
        boolean success = dao.updateUserProfile(currentUser);
        if (success) {
            session.setAttribute("loggedUser", currentUser);
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
        }

        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
}