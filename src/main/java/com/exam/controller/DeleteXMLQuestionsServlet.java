package com.exam.controller;

import com.exam.dao.QuestionDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/delete-xml")
public class DeleteXMLQuestionsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("login.jsp");
            return;
        }

        QuestionDAO questionDAO = new QuestionDAO();

        boolean deleted = questionDAO.deleteXMLQuestions();

        if (deleted) {
            response.sendRedirect("dashboard.jsp?xml=deleted");
        } else {
            response.sendRedirect("dashboard.jsp?xml=deletefailed");
        }
    }
}