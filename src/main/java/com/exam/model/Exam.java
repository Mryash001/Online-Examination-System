package com.exam.model;

import java.util.List;

public class Exam {

    private List<Question> questions;
    private int currentQuestion;

    public Exam(List<Question> questions) {
        this.questions = questions;
        this.currentQuestion = 0;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public int getCurrentQuestion() {
        return currentQuestion;
    }

    public void setCurrentQuestion(int currentQuestion) {
        this.currentQuestion = currentQuestion;
    }

    public Question getCurrentQuestionObject() {
        return questions.get(currentQuestion);
    }

    public int getTotalQuestions() {
        return questions.size();
    }
}