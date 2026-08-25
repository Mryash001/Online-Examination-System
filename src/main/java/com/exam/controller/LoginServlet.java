package com.exam.controller;

import com.exam.dao.UserDAO;
import com.exam.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String expectedRole = request.getParameter("expectedRole");

        if (email == null || password == null ||
                email.trim().isEmpty() || password.isEmpty()) {

            if ("ADMIN".equals(expectedRole)) {
                response.sendRedirect("admin/login.jsp?error=empty");
            } else {
                response.sendRedirect("login.jsp?error=empty");
            }

            return;
        }

        if (!"ADMIN".equals(expectedRole) &&
                !"STUDENT".equals(expectedRole)) {

            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        UserDAO userDAO = new UserDAO();

        User user = userDAO.loginUser(
                email.trim(),
                password
        );

        if (user == null) {

            if ("ADMIN".equals(expectedRole)) {
                response.sendRedirect("admin/login.jsp?error=invalid");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

            return;
        }

        if (!expectedRole.equalsIgnoreCase(user.getRole())) {

            if ("ADMIN".equals(expectedRole)) {
                response.sendRedirect("admin/login.jsp?error=notadmin");
            } else {
                response.sendRedirect("login.jsp?error=notstudent");
            }

            return;
        }

        HttpSession session = request.getSession();

        session.setAttribute("userId", user.getId());
        session.setAttribute("userName", user.getName());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("role", user.getRole());

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {

            response.sendRedirect("admin/dashboard.jsp");

        } else {

            response.sendRedirect("student/dashboard.jsp");

        }
    }
}