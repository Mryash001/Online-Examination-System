package com.exam.controller;

import com.exam.dao.QuestionDAO;
import com.exam.model.Exam;
import com.exam.model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/exam/start")
public class StartExamServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"STUDENT".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        QuestionDAO questionDAO = new QuestionDAO();

        List<Question> questions = questionDAO.getRandomQuestions(10);

        if (questions.size() < 10) {
            response.setContentType("text/html");
            response.getWriter().println("<h1>Not enough questions available.</h1>");
            response.getWriter().println("<p>Please contact the administrator.</p>");
            return;
        }

        Exam exam = new Exam(questions);

        session.setAttribute("exam", exam);
        session.setAttribute("examStartTime", System.currentTimeMillis());

        response.sendRedirect("../exam.jsp");
    }
}