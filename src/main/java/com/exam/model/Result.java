package com.exam.model;

import java.sql.Timestamp;

public class Result {

    private int id;
    private int userId;
    private int score;
    private int totalQuestions;
    private Timestamp submittedAt;

    private String studentName;
    private String studentEmail;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public Timestamp getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Timestamp submittedAt) {
        this.submittedAt = submittedAt;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public double getPercentage() {

        if (totalQuestions == 0) {
            return 0;
        }

        return ((double) score / totalQuestions) * 100;
    }

    public String getResult() {

        return getPercentage() >= 40 ? "PASS" : "FAIL";
    }
}