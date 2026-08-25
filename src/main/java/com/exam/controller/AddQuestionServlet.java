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

@WebServlet("/admin/add-question")
public class AddQuestionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        String questionText = request.getParameter("questionText");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctOption = request.getParameter("correctOption");

        if (questionText == null || optionA == null || optionB == null ||
                optionC == null || optionD == null || correctOption == null ||
                questionText.trim().isEmpty() ||
                optionA.trim().isEmpty() ||
                optionB.trim().isEmpty() ||
                optionC.trim().isEmpty() ||
                optionD.trim().isEmpty()) {

            response.sendRedirect("add-question.jsp?error=empty");
            return;
        }

        Question question = new Question();

        question.setQuestionText(questionText.trim());
        question.setOptionA(optionA.trim());
        question.setOptionB(optionB.trim());
        question.setOptionC(optionC.trim());
        question.setOptionD(optionD.trim());
        question.setCorrectOption(correctOption);

        QuestionDAO questionDAO = new QuestionDAO();

        if (questionDAO.addQuestion(question)) {
            response.sendRedirect("add-question.jsp?success=added");
        } else {
            response.sendRedirect("add-question.jsp?error=failed");
        }
    }
}