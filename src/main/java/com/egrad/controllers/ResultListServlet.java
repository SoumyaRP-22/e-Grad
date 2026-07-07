package com.egrad.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.egrad.dao.ExamDAO;
import com.egrad.models.Result;
import com.egrad.models.User;

@WebServlet("/ResultListServlet")
public class ResultListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("loggedUser");
        
        ExamDAO dao = new ExamDAO();
        List<Result> myResults = dao.getResultsByUserId(currentUser.getId());

        request.setAttribute("myResults", myResults);
        request.getRequestDispatcher("/views/results.jsp").forward(request, response);
    }
}