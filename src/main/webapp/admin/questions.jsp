<%@ page import="java.util.List" %>
<%@ page import="com.exam.model.Question" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    List<Question> questions =
            (List<Question>) request.getAttribute("questions");

    String success = request.getParameter("success");
    String error = request.getParameter("error");

    int totalQuestions =
            questions == null ? 0 : questions.size();

    int xmlQuestions = 0;
    int manualQuestions = 0;

    if (questions != null) {

        for (Question question : questions) {

            String source = question.getSource();

            if ("XML".equalsIgnoreCase(source)) {
                xmlQuestions++;
            } else {
                manualQuestions++;
            }
        }
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Question Bank | Online Exam</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .question-bank-header {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .question-bank-icon {
            width: 52px;
            height: 52px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 12px;

            background: var(--primary-light);
            color: var(--primary);

            font-size: 23px;
            font-weight: 700;

            flex-shrink: 0;
        }

        .question-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;

            margin-bottom: 25px;
        }

        .question-stat {
            padding: 20px;

            background: var(--surface);

            border: 1px solid var(--border);

            border-radius: 12px;

            display: flex;
            align-items: center;
            gap: 15px;

            transition: var(--transition);
        }

        .question-stat:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow);
        }

        .question-stat-icon {
            width: 42px;
            height: 42px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 10px;

            background: var(--primary-light);
            color: var(--primary);

            font-weight: 750;
        }

        .question-stat-content .label {
            color: var(--text-secondary);
            font-size: 12px;
            margin-bottom: 3px;
        }

        .question-stat-content .value {
            font-size: 23px;
            font-weight: 750;
        }

        .question-table td.question-column {
            min-width: 280px;
            max-width: 400px;

            line-height: 1.5;
        }

        .question-table td.options-column {
            min-width: 150px;
        }

        .source-xml {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .source-manual {
            background: #f1f5f9;
            color: #475569;
        }

        [data-theme="dark"] .source-xml {
            background: #172554;
            color: #60a5fa;
        }

        [data-theme="dark"] .source-manual {
            background: #334155;
            color: #cbd5e1;
        }

        .action-group {
            display: flex;
            gap: 7px;
            flex-wrap: wrap;
        }

        .action-button {
            min-height: 36px;
            padding: 7px 12px;
            font-size: 12px;
        }

        .question-count {
            color: var(--text-secondary);
            font-size: 13px;
            margin-bottom: 0;
        }

        .empty-question-bank {
            text-align: center;
            padding: 65px 20px;
        }

        .empty-question-icon {
            width: 65px;
            height: 65px;

            margin: 0 auto 18px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: var(--primary-light);
            color: var(--primary);

            font-size: 27px;
        }

        .empty-question-bank h3 {
            margin-bottom: 8px;
        }

        .empty-question-bank p {
            color: var(--text-secondary);
            margin-bottom: 22px;
        }

        .question-footer-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        @media (max-width: 768px) {

            .question-stats {
                grid-template-columns: 1fr;
            }

            .question-bank-header {
                align-items: flex-start;
            }

        }

    </style>

</head>


<body>


<nav class="navbar">

    <a href="dashboard.jsp" class="logo">
        Online Exam Admin
    </a>


    <div class="nav-links">

        <a href="dashboard.jsp">
            Dashboard
        </a>

        <a href="questions">
            Question Bank
        </a>

        <a href="add-question.jsp">
            Add Question
        </a>


        <button
            id="themeToggle"
            class="theme-toggle"
            onclick="toggleTheme()"
            type="button"
            title="Toggle theme">

            ☾

        </button>


        <a href="../logout">
            Logout
        </a>

    </div>

</nav>



<div class="dashboard">

    <div class="page-container">


        <div class="dashboard-header">

            <div class="question-bank-header">

                <div class="question-bank-icon">
                    ?
                </div>

                <div>

                    <h1>
                        Question Bank
                    </h1>

                    <p>
                        Manage all examination questions.
                    </p>

                </div>

            </div>


            <a href="add-question.jsp"
               class="btn btn-primary">

                + Add Question

            </a>

        </div>



        <%
            if ("updated".equals(success)) {
        %>

        <div class="alert alert-success">

            ✓
            Question updated successfully.

        </div>

        <%
            }

            if ("update".equals(error)) {
        %>

        <div class="alert alert-error">

            !
            Failed to update question.

        </div>

        <%
            }
        %>



        <div class="question-stats">


            <div class="question-stat">

                <div class="question-stat-icon">
                    #
                </div>

                <div class="question-stat-content">

                    <div class="label">
                        Total Questions
                    </div>

                    <div class="value">
                        <%= totalQuestions %>
                    </div>

                </div>

            </div>


            <div class="question-stat">

                <div class="question-stat-icon">
                    X
                </div>

                <div class="question-stat-content">

                    <div class="label">
                        XML Questions
                    </div>

                    <div class="value">
                        <%= xmlQuestions %>
                    </div>

                </div>

            </div>


            <div class="question-stat">

                <div class="question-stat-icon">
                    M
                </div>

                <div class="question-stat-content">

                    <div class="label">
                        Manual Questions
                    </div>

                    <div class="value">
                        <%= manualQuestions %>
                    </div>

                </div>

            </div>

        </div>



        <div class="panel">


            <div class="panel-header">

                <div>

                    <h2>
                        All Questions
                    </h2>

                    <p class="question-count">

                        <%= totalQuestions %>
                        question<%= totalQuestions == 1 ? "" : "s" %>
                        available in the question bank.

                    </p>

                </div>


                <a href="add-question.jsp"
                   class="btn btn-primary">

                    + Add

                </a>

            </div>



            <%
                if (questions != null &&
                        !questions.isEmpty()) {
            %>


            <div class="table-container">

                <table class="data-table question-table">


                    <thead>

                    <tr>

                        <th>
                            ID
                        </th>

                        <th>
                            Question
                        </th>

                        <th>
                            Option A
                        </th>

                        <th>
                            Option B
                        </th>

                        <th>
                            Option C
                        </th>

                        <th>
                            Option D
                        </th>

                        <th>
                            Correct
                        </th>

                        <th>
                            Source
                        </th>

                        <th>
                            Actions
                        </th>

                    </tr>

                    </thead>


                    <tbody>


                    <%
                        for (Question question : questions) {

                            String source =
                                    question.getSource();

                            boolean isXml =
                                    "XML".equalsIgnoreCase(source);
                    %>


                    <tr>


                        <td>

                            <strong>
                                <%= question.getId() %>
                            </strong>

                        </td>



                        <td class="question-column">

                            <%= question.getQuestionText() %>

                        </td>



                        <td class="options-column">

                            <%= question.getOptionA() %>

                        </td>



                        <td class="options-column">

                            <%= question.getOptionB() %>

                        </td>



                        <td class="options-column">

                            <%= question.getOptionC() %>

                        </td>



                        <td class="options-column">

                            <%= question.getOptionD() %>

                        </td>



                        <td>

                            <span class="badge badge-pass">

                                <%= question.getCorrectOption() %>

                            </span>

                        </td>



                        <td>

                            <%
                                if (isXml) {
                            %>

                            <span class="badge source-xml">

                                XML

                            </span>

                            <%
                                } else {
                            %>

                            <span class="badge source-manual">

                                MANUAL

                            </span>

                            <%
                                }
                            %>

                        </td>



                        <td>

                            <div class="action-group">


                                <a
                                    href="edit-question?id=<%= question.getId() %>"
                                    class="btn btn-outline action-button">

                                    Edit

                                </a>


                                <a
                                    href="delete-question?id=<%= question.getId() %>"
                                    class="btn btn-danger action-button"
                                    onclick="return confirm('Are you sure you want to delete this question?');">

                                    Delete

                                </a>


                            </div>

                        </td>


                    </tr>


                    <%
                        }
                    %>


                    </tbody>


                </table>

            </div>


            <%
                } else {
            %>


            <div class="empty-question-bank">


                <div class="empty-question-icon">
                    ?
                </div>


                <h3>
                    No Questions Found
                </h3>


                <p>
                    Your question bank is currently empty.
                    Add your first examination question to get started.
                </p>


                <a
                    href="add-question.jsp"
                    class="btn btn-primary">

                    + Add First Question

                </a>


            </div>


            <%
                }
            %>


        </div>



        <div class="question-footer-actions">


            <a
                href="add-question.jsp"
                class="btn btn-primary">

                + Add New Question

            </a>


            <a
                href="dashboard.jsp"
                class="btn btn-outline">

                ← Back to Dashboard

            </a>

        </div>


    </div>

</div>



<footer class="footer">

    Online Examination System

</footer>



<script src="${pageContext.request.contextPath}/js/theme.js"></script>


</body>

</html>