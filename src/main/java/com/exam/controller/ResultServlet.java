package com.exam.controller;

import com.exam.dao.ResultDAO;
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

@WebServlet("/exam/result")
public class ResultServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"STUDENT".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        Exam exam = (Exam) session.getAttribute("exam");

        Map<Integer, String> answers =
                (Map<Integer, String>) session.getAttribute("answers");

        if (exam == null || answers == null) {
            response.sendRedirect("../student/dashboard.jsp");
            return;
        }

        Boolean examTimedOut =
                (Boolean) session.getAttribute("examTimedOut");

        if (examTimedOut == null) {
            examTimedOut = false;
        }

        int score = 0;

        for (Question question : exam.getQuestions()) {

            String selectedAnswer = answers.get(question.getId());

            if (selectedAnswer != null &&
                    selectedAnswer.equals(question.getCorrectOption())) {

                score++;
            }
        }

        int totalQuestions = exam.getTotalQuestions();

        int userId = (Integer) session.getAttribute("userId");

        ResultDAO resultDAO = new ResultDAO();

        resultDAO.saveResult(
                userId,
                score,
                totalQuestions
        );

        request.setAttribute("score", score);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("examTimedOut", examTimedOut);

        session.removeAttribute("exam");
        session.removeAttribute("answers");
        session.removeAttribute("examStartTime");
        session.removeAttribute("examTimedOut");

        request.getRequestDispatcher("/result.jsp")
                .forward(request, response);
    }
}