package com.exam.controller;

import com.exam.dao.ResultDAO;
import com.exam.model.Result;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/performance")
public class PerformanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null ||
                !"STUDENT".equals(session.getAttribute("role"))) {

            response.sendRedirect("../login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        ResultDAO resultDAO = new ResultDAO();

        List<Result> results =
                resultDAO.getResultsByUserId(userId);

        request.setAttribute("results", results);

        request.getRequestDispatcher("/student/performance.jsp")
                .forward(request, response);
    }
}