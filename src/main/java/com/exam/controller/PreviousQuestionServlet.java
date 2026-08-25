package com.exam.controller;

import com.exam.model.Exam;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/exam/previous")
public class PreviousQuestionServlet extends HttpServlet {

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

        int currentQuestion =
                exam.getCurrentQuestion();

        if (currentQuestion <= 0) {

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            return;
        }

        exam.setCurrentQuestion(
                currentQuestion - 1
        );

        session.setAttribute(
                "exam",
                exam
        );

        response.setContentType(
                "application/json"
        );

        response.setCharacterEncoding(
                "UTF-8"
        );

        response.getWriter().write(
                "{\"success\":true,\"currentQuestion\":"
                        + (exam.getCurrentQuestion() + 1)
                        + "}"
        );
    }
}