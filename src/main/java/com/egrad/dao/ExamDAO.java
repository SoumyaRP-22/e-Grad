package com.egrad.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.egrad.connection.DBConnection;
import com.egrad.models.Exam;
import com.egrad.models.Question;
import com.egrad.models.Result;

public class ExamDAO {

    public List<Exam> getAllExams() {
        List<Exam> exams = new ArrayList<>();
        String query = "SELECT * FROM exams ORDER BY created_at DESC";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Exam exam = new Exam();
                exam.setId(rs.getInt("id"));
                exam.setTitle(rs.getString("title"));
                exam.setDescription(rs.getString("description"));
                exam.setDurationMinutes(rs.getInt("duration_minutes"));
                exams.add(exam);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching exams: ");
            e.printStackTrace();
        }
        return exams;
    }

    public Exam getExamById(int id) {
        Exam exam = null;
        String query = "SELECT * FROM exams WHERE id = ?";
        
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                exam = new Exam();
                exam.setId(rs.getInt("id"));
                exam.setTitle(rs.getString("title"));
                exam.setDescription(rs.getString("description"));
                exam.setDurationMinutes(rs.getInt("duration_minutes"));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching single exam: ");
            e.printStackTrace();
        }
        return exam;
    }

    public List<Question> getQuestionsByExamId(int examId) {
        List<Question> questions = new ArrayList<>();
        String query = "SELECT * FROM questions WHERE exam_id = ?";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, examId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("id"));
                q.setExamId(rs.getInt("exam_id"));
                q.setQuestionText(rs.getString("question_text"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                questions.add(q);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching questions: ");
            e.printStackTrace();
        }
        return questions;
    }
    
    public List<Result> getResultsByUserId(int userId) {
        List<Result> resultList = new ArrayList<>();
        String query = "SELECT e.title, r.score, r.total_questions, r.taken_at " +
                       "FROM results r " +
                       "JOIN exams e ON r.exam_id = e.id " +
                       "WHERE r.user_id = ? " +
                       "ORDER BY r.taken_at DESC";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Result res = new Result();
                res.setExamTitle(rs.getString("title"));
                res.setScore(rs.getInt("score"));
                res.setTotalQuestions(rs.getInt("total_questions"));
                res.setTakenAt(rs.getTimestamp("taken_at"));
                resultList.add(res);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching results: ");
            e.printStackTrace();
        }
        return resultList;
    }
    
    public boolean saveResult(int userId, int examId, int score, int totalQuestions) {
        boolean isSuccess = false;
        String query = "INSERT INTO results (user_id, exam_id, score, total_questions) VALUES (?, ?, ?, ?)";
        
        try {
            java.sql.Connection con = com.egrad.connection.DBConnection.getConnection();
            java.sql.PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(1, userId);
            pst.setInt(2, examId);
            pst.setInt(3, score);
            pst.setInt(4, totalQuestions);
            
            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (java.sql.SQLException e) {
            System.out.println("Error saving exam result: ");
            e.printStackTrace();
        }
        return isSuccess;
    }
}