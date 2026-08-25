package com.exam.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                     HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        String role = null;

        if (session != null) {
            role = (String) session.getAttribute("role");
            session.invalidate();
        }

        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect(
                request.getContextPath() + "/admin/login.jsp"
            );
        } else {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
        }
    }
}