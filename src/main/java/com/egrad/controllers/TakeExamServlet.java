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
import com.egrad.models.Question;

@WebServlet("/TakeExamServlet")
public class TakeExamServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String examIdParam = request.getParameter("examId");
        if (examIdParam == null || examIdParam.isEmpty()) {
            response.sendRedirect("ExamListServlet");
            return;
        }

        int examId = Integer.parseInt(examIdParam);
        ExamDAO dao = new ExamDAO();

        Exam currentExam = dao.getExamById(examId);
        List<Question> questions = dao.getQuestionsByExamId(examId);

        request.setAttribute("currentExam", currentExam);
        request.setAttribute("questionList", questions);

        request.getRequestDispatcher("/views/take-exam.jsp").forward(request, response);
    }
}