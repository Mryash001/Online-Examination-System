package com.exam.controller;

import com.exam.dao.QuestionDAO;
import com.exam.model.Question;
import com.exam.util.XMLQuestionParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet("/admin/import-xml")
public class ImportXMLServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        InputStream inputStream =
                getServletContext().getResourceAsStream("/xml/questions.xml");

        if (inputStream == null) {

            response.sendRedirect("dashboard.jsp?xml=notfound");
            return;
        }

        List<Question> questions =
                XMLQuestionParser.parse(inputStream);

        inputStream.close();

        if (questions.isEmpty()) {

            response.sendRedirect("dashboard.jsp?xml=empty");
            return;
        }

        QuestionDAO questionDAO = new QuestionDAO();

        boolean imported =
                questionDAO.addQuestions(questions);

        if (imported) {

            response.sendRedirect(
                    "dashboard.jsp?xml=success&count=" + questions.size()
            );

        } else {

            response.sendRedirect(
                    "dashboard.jsp?xml=failed"
            );
        }
    }
}