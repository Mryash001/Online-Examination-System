package com.exam.controller;

import com.exam.dao.AdminPerformanceDAO;
import com.exam.model.AdminStudentPerformance;
import com.exam.model.Result;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/performance")
public class AdminPerformanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect(
                request.getContextPath() +
                "/admin/login.jsp"
            );
            return;
        }

        AdminPerformanceDAO dao =
                new AdminPerformanceDAO();

        List<AdminStudentPerformance> students =
                dao.getStudentPerformance();

        List<Result> results =
                dao.getAllResults();

        List<AdminStudentPerformance> notAttempted =
                dao.getStudentsWithoutAttempts();

        int totalStudents =
                dao.getTotalStudents();

        int studentsWithAttempts =
                dao.getStudentsWithAttempts();

        int studentsWithoutAttempts =
                totalStudents - studentsWithAttempts;

        int totalAttempts =
                dao.getTotalAttempts();

        request.setAttribute(
                "students",
                students
        );

        request.setAttribute(
                "results",
                results
        );

        request.setAttribute(
                "notAttempted",
                notAttempted
        );

        request.setAttribute(
                "totalStudents",
                totalStudents
        );

        request.setAttribute(
                "studentsWithAttempts",
                studentsWithAttempts
        );

        request.setAttribute(
                "studentsWithoutAttempts",
                studentsWithoutAttempts
        );

        request.setAttribute(
                "totalAttempts",
                totalAttempts
        );

        request.getRequestDispatcher(
                "/admin/performance.jsp"
        ).forward(request, response);
    }
}