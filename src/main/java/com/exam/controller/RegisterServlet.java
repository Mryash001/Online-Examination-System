package com.exam.controller;

import com.exam.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (name == null || email == null || password == null || confirmPassword == null ||
                name.trim().isEmpty() || email.trim().isEmpty() ||
                password.isEmpty() || confirmPassword.isEmpty()) {

            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=password");
            return;
        }

        UserDAO userDAO = new UserDAO();

        boolean registered = userDAO.registerUser(
                name.trim(),
                email.trim(),
                password
        );

        if (registered) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}