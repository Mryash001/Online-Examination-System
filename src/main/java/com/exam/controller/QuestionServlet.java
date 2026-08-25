package com.exam.controller;

import com.exam.model.Exam;
import com.exam.model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/exam/question")
public class QuestionServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        Question question = exam.getCurrentQuestionObject();

        if (question == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Map<Integer, String> answers =
                (Map<Integer, String>) session.getAttribute("answers");

        String selectedAnswer = "";

        if (answers != null) {
            String savedAnswer = answers.get(question.getId());

            if (savedAnswer != null) {
                selectedAnswer = savedAnswer;
            }
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String json = "{"
                + "\"id\":" + question.getId() + ","
                + "\"questionText\":\"" + escapeJson(question.getQuestionText()) + "\","
                + "\"optionA\":\"" + escapeJson(question.getOptionA()) + "\","
                + "\"optionB\":\"" + escapeJson(question.getOptionB()) + "\","
                + "\"optionC\":\"" + escapeJson(question.getOptionC()) + "\","
                + "\"optionD\":\"" + escapeJson(question.getOptionD()) + "\","
                + "\"current\":" + (exam.getCurrentQuestion() + 1) + ","
                + "\"total\":" + exam.getTotalQuestions() + ","
                + "\"selectedAnswer\":\"" + escapeJson(selectedAnswer) + "\""
                + "}";

        response.getWriter().write(json);
    }

    private String escapeJson(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}