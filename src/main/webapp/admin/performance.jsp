<%@ page import="java.util.List" %>
<%@ page import="com.exam.model.AdminStudentPerformance" %>
<%@ page import="com.exam.model.Result" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

        response.sendRedirect("../admin/login.jsp");
        return;
    }

    List<AdminStudentPerformance> students =
            (List<AdminStudentPerformance>) request.getAttribute("students");

    List<Result> results =
            (List<Result>) request.getAttribute("results");

    List<AdminStudentPerformance> notAttempted =
            (List<AdminStudentPerformance>) request.getAttribute("notAttempted");

    Integer totalStudentsObj =
            (Integer) request.getAttribute("totalStudents");

    Integer studentsWithAttemptsObj =
            (Integer) request.getAttribute("studentsWithAttempts");

    Integer studentsWithoutAttemptsObj =
            (Integer) request.getAttribute("studentsWithoutAttempts");

    Integer totalAttemptsObj =
            (Integer) request.getAttribute("totalAttempts");

    int totalStudents =
            totalStudentsObj == null ? 0 : totalStudentsObj;

    int studentsWithAttempts =
            studentsWithAttemptsObj == null ? 0 : studentsWithAttemptsObj;

    int studentsWithoutAttempts =
            studentsWithoutAttemptsObj == null ? 0 : studentsWithoutAttemptsObj;

    int totalAttempts =
            totalAttemptsObj == null ? 0 : totalAttemptsObj;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Performance</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .performance-page {
            min-height: calc(100vh - 70px);
            padding: 45px 20px 70px;
        }

        .performance-container {
            max-width: 1250px;
            margin: 0 auto;
        }

        .performance-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 30px;
        }

        .performance-header h1 {
            margin: 0 0 8px;
            font-size: 38px;
        }

        .performance-header p {
            margin: 0;
            color: #64748b;
        }

        .performance-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .performance-stat {
            padding: 25px;
            border-radius: 15px;
            border: 1px solid #dbe3ef;
            background: #ffffff;
            box-shadow: 0 8px 25px rgba(15, 23, 42, 0.06);
            transition: 0.3s ease;
        }

        .performance-stat:hover {
            transform: translateY(-3px);
        }

        .performance-stat .label {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .performance-stat .value {
            color: #111827;
            font-size: 34px;
            font-weight: 800;
        }

        .performance-stat .description {
            color: #94a3b8;
            font-size: 12px;
            margin-top: 6px;
        }

        .performance-panel {
            background: #ffffff;
            border: 1px solid #dbe3ef;
            border-radius: 18px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
        }

        .panel-heading {
            margin-bottom: 22px;
        }

        .panel-heading h2 {
            margin: 0 0 7px;
            color: #111827;
            font-size: 25px;
        }

        .panel-heading p {
            margin: 0;
            color: #64748b;
            font-size: 14px;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #dbe3ef;
            border-radius: 12px;
        }

        .performance-table {
            width: 100%;
            min-width: 850px;
            border-collapse: collapse;
            background: #ffffff;
        }

        .performance-table th {
            padding: 15px;
            text-align: left;
            background: #f8fafc;
            color: #64748b;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            border-bottom: 1px solid #dbe3ef;
        }

        .performance-table td {
            padding: 16px 15px;
            color: #1e293b;
            border-bottom: 1px solid #e5e7eb;
            font-size: 14px;
        }

        .performance-table tr:last-child td {
            border-bottom: none;
        }

        .performance-table tbody tr:hover {
            background: #f8fafc;
        }

        .student-name {
            font-weight: 700;
            color: #111827;
        }

        .student-email {
            color: #64748b;
            font-size: 13px;
        }

        .badge-number {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 42px;
            padding: 6px 10px;
            border-radius: 20px;
            background: #eff6ff;
            color: #2563eb;
            font-weight: 700;
        }

        .badge-pass {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 42px;
            padding: 6px 10px;
            border-radius: 20px;
            background: #dcfce7;
            color: #15803d;
            font-weight: 700;
        }

        .badge-fail {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 42px;
            padding: 6px 10px;
            border-radius: 20px;
            background: #fee2e2;
            color: #dc2626;
            font-weight: 700;
        }

        .pending-list {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .pending-student {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 17px;
            border-radius: 12px;
            background: #f8fafc;
            border: 1px solid #dbe3ef;
        }

        .pending-icon {
            width: 42px;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            background: #fff7ed;
            font-size: 20px;
        }

        .pending-name {
            font-weight: 700;
            color: #111827;
        }

        .pending-email {
            margin-top: 3px;
            color: #64748b;
            font-size: 13px;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #64748b;
        }

        .empty-state-icon {
            font-size: 40px;
            margin-bottom: 10px;
        }


        /* DARK THEME */

        body.dark-theme .performance-page {
            background: #070d1b;
        }

        body.dark-theme .performance-stat,
        body.dark-theme .performance-panel {
            background: #0f172a;
            border-color: #263653;
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
        }

        body.dark-theme .performance-stat .label,
        body.dark-theme .performance-stat .description {
            color: #94a3b8;
        }

        body.dark-theme .performance-stat .value {
            color: #f8fafc;
        }

        body.dark-theme .panel-heading h2 {
            color: #f8fafc;
        }

        body.dark-theme .panel-heading p {
            color: #94a3b8;
        }

        body.dark-theme .table-container {
            border-color: #263653;
        }

        body.dark-theme .performance-table {
            background: #111c31;
        }

        body.dark-theme .performance-table th {
            background: #162238;
            color: #94a3b8;
            border-color: #263653;
        }

        body.dark-theme .performance-table td {
            color: #e2e8f0;
            border-color: #263653;
        }

        body.dark-theme .performance-table tbody tr:hover {
            background: #17243b;
        }

        body.dark-theme .student-name {
            color: #f8fafc;
        }

        body.dark-theme .student-email {
            color: #94a3b8;
        }

        body.dark-theme .pending-student {
            background: #111c31;
            border-color: #263653;
        }

        body.dark-theme .pending-name {
            color: #f8fafc;
        }

        body.dark-theme .pending-email {
            color: #94a3b8;
        }

        body.dark-theme .empty-state {
            color: #94a3b8;
        }


        @media (max-width: 1000px) {

            .performance-stats {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 700px) {

            .performance-page {
                padding: 30px 15px 50px;
            }

            .performance-header {
                flex-direction: column;
            }

            .performance-header h1 {
                font-size: 31px;
            }

            .performance-stats {
                grid-template-columns: 1fr;
            }

            .performance-panel {
                padding: 20px;
            }

            .pending-list {
                grid-template-columns: 1fr;
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
            Questions
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


<div class="performance-page">

    <div class="performance-container">


        <div class="performance-header">

            <div>

                <h1>
                    Student Performance
                </h1>

                <p>
                    Monitor examination attempts, scores and student progress.
                </p>

            </div>

            <a href="dashboard.jsp"
               class="btn btn-outline">

                ← Dashboard

            </a>

        </div>


        <div class="performance-stats">


            <div class="performance-stat">

                <div class="label">
                    Total Students
                </div>

                <div class="value">
                    <%= totalStudents %>
                </div>

                <div class="description">
                    Registered students
                </div>

            </div>


            <div class="performance-stat">

                <div class="label">
                    Students Attempted
                </div>

                <div class="value">
                    <%= studentsWithAttempts %>
                </div>

                <div class="description">
                    Students with at least one attempt
                </div>

            </div>


            <div class="performance-stat">

                <div class="label">
                    Not Attempted
                </div>

                <div class="value">
                    <%= studentsWithoutAttempts %>
                </div>

                <div class="description">
                    Students yet to take the exam
                </div>

            </div>


            <div class="performance-stat">

                <div class="label">
                    Total Attempts
                </div>

                <div class="value">
                    <%= totalAttempts %>
                </div>

                <div class="description">
                    All student submissions
                </div>

            </div>


        </div>


        <div class="performance-panel">

            <div class="panel-heading">

                <h2>
                    Student Performance Overview
                </h2>

                <p>
                    View examination attempts and overall performance
                    for every student.
                </p>

            </div>


            <%
                if (students != null && !students.isEmpty()) {
            %>

            <div class="table-container">

                <table class="performance-table">

                    <thead>

                    <tr>

                        <th>
                            Student
                        </th>

                        <th>
                            Email
                        </th>

                        <th>
                            Attempts
                        </th>

                        <th>
                            Average
                        </th>

                        <th>
                            Passed
                        </th>

                        <th>
                            Failed
                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                        for (AdminStudentPerformance student : students) {
                    %>

                    <tr>

                        <td>

                            <div class="student-name">
                                <%= student.getName() %>
                            </div>

                        </td>

                        <td>

                            <div class="student-email">
                                <%= student.getEmail() %>
                            </div>

                        </td>

                        <td>

                            <span class="badge-number">
                                <%= student.getTotalAttempts() %>
                            </span>

                        </td>

                        <td>

                            <strong>
                                <%= String.format(
                                        "%.2f",
                                        student.getAveragePercentage()
                                ) %>%
                            </strong>

                        </td>

                        <td>

                            <span class="badge-pass">
                                <%= student.getPassedAttempts() %>
                            </span>

                        </td>

                        <td>

                            <%
                                if (student.getFailedAttempts() > 0) {
                            %>

                            <span class="badge-fail">
                                <%= student.getFailedAttempts() %>
                            </span>

                            <%
                                } else {
                            %>

                            <span class="badge-pass">
                                0
                            </span>

                            <%
                                }
                            %>

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

            <div class="empty-state">

                <div class="empty-state-icon">
                    📊
                </div>

                No student performance data available.

            </div>

            <%
                }
            %>

        </div>


        <div class="performance-panel">

            <div class="panel-heading">

                <h2>
                    Examination Attempts
                </h2>

                <p>
                    Detailed scores from every examination attempt.
                </p>

            </div>


            <%
                if (results != null && !results.isEmpty()) {
            %>

            <div class="table-container">

                <table class="performance-table">

                    <thead>

                    <tr>

                        <th>
                            Student
                        </th>

                        <th>
                            Email
                        </th>

                        <th>
                            Score
                        </th>

                        <th>
                            Percentage
                        </th>

                        <th>
                            Result
                        </th>

                        <th>
                            Submitted
                        </th>

                    </tr>

                    </thead>

                    <tbody>

                    <%
                        for (Result result : results) {
                    %>

                    <tr>

                        <td>

                            <div class="student-name">
                                <%= result.getStudentName() %>
                            </div>

                        </td>

                        <td>

                            <div class="student-email">
                                <%= result.getStudentEmail() %>
                            </div>

                        </td>

                        <td>

                            <strong>
                                <%= result.getScore() %>
                                /
                                <%= result.getTotalQuestions() %>
                            </strong>

                        </td>

                        <td>

                            <strong>
                                <%= String.format(
                                        "%.2f",
                                        result.getPercentage()
                                ) %>%
                            </strong>

                        </td>

                        <td>

                            <%
                                if ("PASS".equals(result.getResult())) {
                            %>

                            <span class="badge-pass">
                                PASS
                            </span>

                            <%
                                } else {
                            %>

                            <span class="badge-fail">
                                FAIL
                            </span>

                            <%
                                }
                            %>

                        </td>

                        <td>
                            <%= result.getSubmittedAt() %>
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

            <div class="empty-state">

                <div class="empty-state-icon">
                    📝
                </div>

                No examination attempts have been recorded yet.

            </div>

            <%
                }
            %>

        </div>


        <div class="performance-panel">

            <div class="panel-heading">

                <h2>
                    Students Who Have Not Attempted
                </h2>

                <p>
                    Registered students who have not completed an examination.
                </p>

            </div>


            <%
                if (notAttempted != null &&
                        !notAttempted.isEmpty()) {
            %>

            <div class="pending-list">

                <%
                    for (AdminStudentPerformance student : notAttempted) {
                %>

                <div class="pending-student">

                    <div class="pending-icon">
                        ⏳
                    </div>

                    <div>

                        <div class="pending-name">
                            <%= student.getName() %>
                        </div>

                        <div class="pending-email">
                            <%= student.getEmail() %>
                        </div>

                    </div>

                </div>

                <%
                    }
                %>

            </div>

            <%
                } else {
            %>

            <div class="empty-state">

                <div class="empty-state-icon">
                    ✓
                </div>

                <strong>
                    All registered students have attempted the exam.
                </strong>

            </div>

            <%
                }
            %>

        </div>


    </div>

</div>


<footer class="footer">

    Online Examination System

</footer>


<script>

    function applyTheme() {

        const theme =
            localStorage.getItem("theme") || "light";

        document.body.classList.remove(
            "light-theme",
            "dark-theme"
        );

        document.documentElement.classList.remove(
            "light-theme",
            "dark-theme"
        );

        document.body.classList.add(
            theme + "-theme"
        );

        document.documentElement.classList.add(
            theme + "-theme"
        );

        const toggle =
            document.getElementById("themeToggle");

        if (toggle) {

            toggle.textContent =
                theme === "dark"
                    ? "☀"
                    : "☾";

        }
    }


    function toggleTheme() {

        const current =
            localStorage.getItem("theme") || "light";

        const next =
            current === "light"
                ? "dark"
                : "light";

        localStorage.setItem(
            "theme",
            next
        );

        applyTheme();
    }


    document.addEventListener(
        "DOMContentLoaded",
        function () {

            applyTheme();

        }
    );

</script>

</body>

</html>