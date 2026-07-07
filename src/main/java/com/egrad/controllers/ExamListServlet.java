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
import com.egrad.models.Exam;

@WebServlet("/ExamListServlet")
public class ExamListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        ExamDAO examDAO = new ExamDAO();
        List<Exam> exams = examDAO.getAllExams();

        request.setAttribute("examList", exams);

        request.getRequestDispatcher("/views/exam-list.jsp").forward(request, response);
    }
}