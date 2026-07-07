package com.egrad.models;

import java.sql.Timestamp;

public class Result {
    private String examTitle;
    private int score;
    private int totalQuestions;
    private Timestamp takenAt;

    public String getExamTitle() { return examTitle; }
    public void setExamTitle(String examTitle) { this.examTitle = examTitle; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }

    public Timestamp getTakenAt() { return takenAt; }
    public void setTakenAt(Timestamp takenAt) { this.takenAt = takenAt; }
    
    public double getPercentage() {
        if (totalQuestions == 0) return 0;
        return ((double) score / totalQuestions) * 100;
    }
}