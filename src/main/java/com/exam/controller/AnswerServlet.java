package com.exam.controller;

import com.exam.model.Exam;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/exam/answer")
public class AnswerServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"STUDENT".equals(session.getAttribute("role"))) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Exam exam = (Exam) session.getAttribute("exam");

        if (exam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String answer = request.getParameter("answer");
        String questionIdParameter = request.getParameter("questionId");

        if (questionIdParameter == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int questionId;

        try {
            questionId = Integer.parseInt(questionIdParameter);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Map<Integer, String> answers =
                (Map<Integer, String>) session.getAttribute("answers");

        if (answers == null) {
            answers = new HashMap<>();
            session.setAttribute("answers", answers);
        }

        if (answer != null && !answer.trim().isEmpty()) {
            answers.put(questionId, answer);
        }

        int currentQuestion = exam.getCurrentQuestion();
        int totalQuestions = exam.getTotalQuestions();

        boolean lastQuestion =
                currentQuestion >= totalQuestions - 1;

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (lastQuestion) {

            response.getWriter().write(
                    "{\"completed\":true}"
            );

            return;
        }

        exam.setCurrentQuestion(currentQuestion + 1);

        session.setAttribute("exam", exam);

        response.getWriter().write(
                "{\"completed\":false,\"nextQuestion\":"
                        + (exam.getCurrentQuestion() + 1)
                        + "}"
        );
    }
}