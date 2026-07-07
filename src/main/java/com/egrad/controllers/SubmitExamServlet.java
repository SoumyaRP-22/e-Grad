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
import com.egrad.models.User;

@WebServlet("/SubmitExamServlet")
public class SubmitExamServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("loggedUser");
        int examId = Integer.parseInt(request.getParameter("examId"));
        String timeUsed = request.getParameter("timeUsed");
        if (timeUsed == null) timeUsed = "00:00";

        ExamDAO dao = new ExamDAO();
        Exam currentExam = dao.getExamById(examId);
        List<Question> questions = dao.getQuestionsByExamId(examId);

        int score = 0;
        int attempted = 0;
        int totalQuestions = questions.size();

        for (Question q : questions) {
            String studentAnswer = request.getParameter("q_" + q.getId());
            if (studentAnswer != null && !studentAnswer.isEmpty()) {
                attempted++;
                if (studentAnswer.equals(q.getCorrectOption())) {
                    score++;
                }
            }
        }
        
        int wrong = attempted - score;
        int unattempted = totalQuestions - attempted;

        dao.saveResult(currentUser.getId(), examId, score, totalQuestions);

        request.setAttribute("score", score);
        request.setAttribute("wrong", wrong);
        request.setAttribute("attempted", attempted);
        request.setAttribute("unattempted", unattempted);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("timeUsed", timeUsed);
        request.setAttribute("examTitle", currentExam.getTitle());

        request.getRequestDispatcher("/views/result.jsp").forward(request, response);
    }
}
