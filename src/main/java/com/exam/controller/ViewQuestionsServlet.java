package com.exam.controller;

import com.exam.dao.QuestionDAO;
import com.exam.model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/questions")
public class ViewQuestionsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        QuestionDAO questionDAO = new QuestionDAO();

        List<Question> questions = questionDAO.getAllQuestions();

        request.setAttribute("questions", questions);

        request.getRequestDispatcher("/admin/questions.jsp")
                .forward(request, response);
    }
}