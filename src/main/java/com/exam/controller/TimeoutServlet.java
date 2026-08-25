package com.exam.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/exam/timeout")
public class TimeoutServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"STUDENT".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        if (session.getAttribute("exam") == null) {
            response.sendRedirect("../student/dashboard.jsp");
            return;
        }

        session.setAttribute("examTimedOut", true);

        response.sendRedirect("result");
    }
}