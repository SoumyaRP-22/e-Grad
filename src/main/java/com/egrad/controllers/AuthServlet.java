package com.egrad.controllers;

import java.io.IOException;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.egrad.dao.UserDAO;
import com.egrad.models.User;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("register".equals(action)) {
            handleRegistration(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        }
    }
    
    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String program = request.getParameter("program");
        String semester = request.getParameter("semester");
        
        User newUser = new User(name, email, password, role);
        
        newUser.setProgram(program);
        newUser.setSemester(semester);
        
        UserDAO userDao = new UserDAO();
        boolean isRegistered = userDao.registerUser(newUser);
        
        if (isRegistered) {
            request.setAttribute("successMessage", "Registration successful! Please sign in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Registration failed. Email might already exist.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UserDAO userDao = new UserDAO();
        User loggedInUser = userDao.loginUser(email, password);
        
        if (loggedInUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", loggedInUser);
            
            response.sendRedirect(request.getContextPath() + "/views/dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            doPost(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}