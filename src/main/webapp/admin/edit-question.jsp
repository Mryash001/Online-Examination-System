<%@ page import="com.exam.model.Question" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    Question question =
            (Question) request.getAttribute("question");

    if (question == null) {
        response.sendRedirect("questions");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Edit Question | Online Exam</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .question-form {
            max-width: 900px;
            margin: 0 auto;
        }

        .edit-question-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
        }

        .edit-question-icon {
            width: 52px;
            height: 52px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 12px;

            background: var(--primary-light);
            color: var(--primary);

            font-size: 22px;
            font-weight: 700;

            flex-shrink: 0;
        }

        .question-id {
            display: inline-flex;
            align-items: center;

            padding: 5px 10px;

            margin-top: 5px;

            border-radius: 999px;

            background: var(--bg);

            border: 1px solid var(--border);

            color: var(--text-secondary);

            font-size: 12px;
            font-weight: 600;
        }

        .question-textarea {
            min-height: 150px;
            resize: vertical;
        }

        .options-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .option-field {
            position: relative;
        }

        .option-label {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .option-letter {
            width: 28px;
            height: 28px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: var(--primary-light);
            color: var(--primary);

            font-size: 12px;
            font-weight: 750;
        }

        .correct-answer-box {
            max-width: 350px;

            padding: 20px;

            margin-top: 5px;

            background: var(--bg);

            border: 1px solid var(--border);

            border-radius: 12px;
        }

        .correct-answer-box label {
            margin-bottom: 10px;
        }

        .correct-answer-box select {
            width: 100%;
        }

        .form-actions {
            display: flex;
            align-items: center;
            gap: 10px;

            margin-top: 30px;

            padding-top: 25px;

            border-top: 1px solid var(--border);

            flex-wrap: wrap;
        }

        .form-note {
            margin-top: 8px;

            color: var(--text-muted);

            font-size: 12px;
        }

        @media (max-width: 768px) {

            .options-grid {
                grid-template-columns: 1fr;
            }

            .question-form {
                padding: 20px;
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

            <div>

                <div class="edit-question-header">

                    <div class="edit-question-icon">
                        ✎
                    </div>

                    <div>

                        <h1>
                            Edit Question
                        </h1>

                        <p>
                            Update the question and answer options.
                        </p>

                        <span class="question-id">

                            Question ID:
                            <%= question.getId() %>

                        </span>

                    </div>

                </div>

            </div>

        </div>



        <div class="panel question-form">


            <form
                action="edit-question"
                method="post">


                <input
                    type="hidden"
                    name="id"
                    value="<%= question.getId() %>">


                <div class="form-group">

                    <label for="questionText">

                        Question

                    </label>


                    <textarea
                        id="questionText"
                        name="questionText"
                        class="form-control question-textarea"
                        placeholder="Enter the examination question..."
                        required><%= question.getQuestionText() %></textarea>


                    <div class="form-note">

                        Write a clear and concise examination question.

                    </div>

                </div>



                <h3>
                    Answer Options
                </h3>


                <p class="page-subtitle"
                   style="margin-bottom: 20px;">

                    Update all four options and select the correct answer below.

                </p>



                <div class="options-grid">


                    <div class="form-group option-field">

                        <label
                            for="optionA"
                            class="option-label">

                            <span class="option-letter">
                                A
                            </span>

                            Option A

                        </label>


                        <input
                            type="text"
                            id="optionA"
                            name="optionA"
                            class="form-control"
                            value="<%= question.getOptionA() %>"
                            placeholder="Enter option A"
                            required>

                    </div>



                    <div class="form-group option-field">

                        <label
                            for="optionB"
                            class="option-label">

                            <span class="option-letter">
                                B
                            </span>

                            Option B

                        </label>


                        <input
                            type="text"
                            id="optionB"
                            name="optionB"
                            class="form-control"
                            value="<%= question.getOptionB() %>"
                            placeholder="Enter option B"
                            required>

                    </div>



                    <div class="form-group option-field">

                        <label
                            for="optionC"
                            class="option-label">

                            <span class="option-letter">
                                C
                            </span>

                            Option C

                        </label>


                        <input
                            type="text"
                            id="optionC"
                            name="optionC"
                            class="form-control"
                            value="<%= question.getOptionC() %>"
                            placeholder="Enter option C"
                            required>

                    </div>



                    <div class="form-group option-field">

                        <label
                            for="optionD"
                            class="option-label">

                            <span class="option-letter">
                                D
                            </span>

                            Option D

                        </label>


                        <input
                            type="text"
                            id="optionD"
                            name="optionD"
                            class="form-control"
                            value="<%= question.getOptionD() %>"
                            placeholder="Enter option D"
                            required>

                    </div>

                </div>



                <div class="correct-answer-box">


                    <div class="form-group"
                         style="margin-bottom: 0;">

                        <label for="correctOption">

                            Correct Answer

                        </label>


                        <select
                            id="correctOption"
                            name="correctOption"
                            required>


                            <option value="A"
                                <%= "A".equals(question.getCorrectOption())
                                        ? "selected" : "" %>>

                                Option A

                            </option>


                            <option value="B"
                                <%= "B".equals(question.getCorrectOption())
                                        ? "selected" : "" %>>

                                Option B

                            </option>


                            <option value="C"
                                <%= "C".equals(question.getCorrectOption())
                                        ? "selected" : "" %>>

                                Option C

                            </option>


                            <option value="D"
                                <%= "D".equals(question.getCorrectOption())
                                        ? "selected" : "" %>>

                                Option D

                            </option>


                        </select>


                        <div class="form-note">

                            Select the correct answer for this question.

                        </div>

                    </div>

                </div>



                <div class="form-actions">


                    <button
                        type="submit"
                        class="btn btn-primary">

                        ✓ Update Question

                    </button>


                    <a
                        href="questions"
                        class="btn btn-outline">

                        Cancel

                    </a>


                    <a
                        href="dashboard.jsp"
                        class="btn btn-outline">

                        ← Dashboard

                    </a>

                </div>


            </form>

        </div>


    </div>

</div>



<footer class="footer">

    Online Examination System

</footer>



<script src="${pageContext.request.contextPath}/js/theme.js"></script>


</body>

</html>