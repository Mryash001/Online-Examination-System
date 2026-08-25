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

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null ||
                password == null ||
                email.trim().isEmpty() ||
                password.isEmpty()) {

            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        UserDAO userDAO = new UserDAO();

        User user = userDAO.loginUser(
                email.trim(),
                password
        );

        if (user != null &&
                "ADMIN".equals(user.getRole())) {

            HttpSession session = request.getSession();

            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("role", user.getRole());

            response.sendRedirect("dashboard.jsp");

        } else {

            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}