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

@WebServlet("/admin/edit-question")
public class EditQuestionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        QuestionDAO questionDAO = new QuestionDAO();

        Question question = questionDAO.getQuestionById(id);

        if (question == null) {
            response.sendRedirect("questions");
            return;
        }

        request.setAttribute("question", question);

        request.getRequestDispatcher("/admin/edit-question.jsp")
                .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        Question question = new Question();

        question.setId(Integer.parseInt(request.getParameter("id")));
        question.setQuestionText(request.getParameter("questionText").trim());
        question.setOptionA(request.getParameter("optionA").trim());
        question.setOptionB(request.getParameter("optionB").trim());
        question.setOptionC(request.getParameter("optionC").trim());
        question.setOptionD(request.getParameter("optionD").trim());
        question.setCorrectOption(request.getParameter("correctOption"));

        QuestionDAO questionDAO = new QuestionDAO();

        if (questionDAO.updateQuestion(question)) {
            response.sendRedirect("questions?success=updated");
        } else {
            response.sendRedirect("questions?error=update");
        }
    }
}