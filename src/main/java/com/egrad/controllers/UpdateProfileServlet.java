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

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("loggedUser");

        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String dob = request.getParameter("dob");
        String bloodGroup = request.getParameter("bloodGroup");
        String fathersName = request.getParameter("fathersName");
        String address = request.getParameter("address");

        currentUser.setName(name);
        currentUser.setMobile(mobile);
        currentUser.setDob(dob);
        currentUser.setBloodGroup(bloodGroup);
        currentUser.setFathersName(fathersName);
        currentUser.setAddress(address);

        UserDAO dao = new UserDAO();
        boolean isUpdated = dao.updateUserProfile(currentUser);

        if (isUpdated) {
            session.setAttribute("loggedUser", currentUser);
            
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/profile.jsp");
        }
    }
}