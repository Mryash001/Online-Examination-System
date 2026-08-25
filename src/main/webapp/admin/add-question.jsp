<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    String success = request.getParameter("success");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Add Question | Online Exam</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .question-form {
            max-width: 900px;
            margin: 0 auto;
        }

        .add-question-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
        }

        .add-question-icon {
            width: 52px;
            height: 52px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 12px;

            background: var(--primary-light);
            color: var(--primary);

            font-size: 24px;
            font-weight: 700;

            flex-shrink: 0;
        }

        .question-textarea {
            min-height: 150px;
            resize: vertical;
        }

        .options-title {
            margin-top: 30px;
            margin-bottom: 6px;
        }

        .options-description {
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 20px;
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
            max-width: 360px;

            padding: 20px;

            margin-top: 10px;

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

        .form-note {
            margin-top: 8px;

            color: var(--text-muted);

            font-size: 12px;
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

        .required-note {
            color: var(--text-muted);
            font-size: 12px;
            margin-bottom: 25px;
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

                <div class="add-question-header">

                    <div class="add-question-icon">
                        +
                    </div>

                    <div>

                        <h1>
                            Add Question
                        </h1>

                        <p>
                            Create a new multiple-choice examination question.
                        </p>

                    </div>

                </div>

            </div>

        </div>



        <%
            if ("added".equals(success)) {
        %>

        <div class="alert alert-success">

            ✓
            Question added successfully.

        </div>

        <%
            } else if ("empty".equals(error)) {
        %>

        <div class="alert alert-error">

            !
            Please fill all fields.

        </div>

        <%
            } else if ("failed".equals(error)) {
        %>

        <div class="alert alert-error">

            !
            Failed to add question.
            Please try again.

        </div>

        <%
            }
        %>



        <div class="panel question-form">


            <div class="required-note">

                All fields are required.

            </div>


            <form
                action="add-question"
                method="post">


                <div class="form-group">

                    <label for="questionText">

                        Question

                    </label>


                    <textarea
                        id="questionText"
                        name="questionText"
                        class="form-control question-textarea"
                        placeholder="Enter the examination question..."
                        required></textarea>


                    <div class="form-note">

                        Write a clear and concise question for students.

                    </div>

                </div>



                <h3 class="options-title">

                    Answer Options

                </h3>


                <p class="options-description">

                    Enter four possible answers for this question.

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


                            <option value="">
                                Select the correct option
                            </option>


                            <option value="A">
                                Option A
                            </option>


                            <option value="B">
                                Option B
                            </option>


                            <option value="C">
                                Option C
                            </option>


                            <option value="D">
                                Option D
                            </option>


                        </select>


                        <div class="form-note">

                            Select which option is the correct answer.

                        </div>

                    </div>

                </div>



                <div class="form-actions">


                    <button
                        type="submit"
                        class="btn btn-primary">

                        ✓ Add Question

                    </button>


                    <a
                        href="questions"
                        class="btn btn-outline">

                        View Question Bank

                    </a>


                    <a
                        href="dashboard.jsp"
                        class="btn btn-outline">

                        ← Cancel

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