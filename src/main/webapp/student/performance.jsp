<%@ page import="java.util.List" %>
<%@ page import="com.exam.model.Result" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"STUDENT".equals(session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    List<Result> results =
            (List<Result>) request.getAttribute("results");

    int totalAttempts =
            results == null ? 0 : results.size();

    int passedAttempts = 0;

    double averagePercentage = 0;

    double highestPercentage = 0;

    if (results != null && !results.isEmpty()) {

        double totalPercentage = 0;

        for (Result result : results) {

            if (result.getTotalQuestions() > 0) {

                double percentage =
                        ((double) result.getScore()
                        / result.getTotalQuestions()) * 100;

                totalPercentage += percentage;

                if (percentage >= 40) {
                    passedAttempts++;
                }

                if (percentage > highestPercentage) {
                    highestPercentage = percentage;
                }
            }
        }

        averagePercentage =
                totalPercentage / results.size();
    }

    int passRate = 0;

    if (totalAttempts > 0) {
        passRate =
                (int) Math.round(
                    ((double) passedAttempts /
                    totalAttempts) * 100
                );
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Performance History | Online Exam</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .performance-hero {
            position: relative;
            overflow: hidden;

            padding: 32px;

            margin-bottom: 25px;

            border-radius: 18px;

            background:
                linear-gradient(
                    135deg,
                    #0f172a,
                    #1e3a8a
                );

            color: white;

            box-shadow:
                0 18px 40px
                rgba(15, 23, 42, 0.2);

            animation: slideUp 0.5s ease;
        }

        .performance-hero::before {
            content: "";

            position: absolute;

            width: 230px;
            height: 230px;

            right: -80px;
            top: -100px;

            border-radius: 50%;

            background:
                rgba(59, 130, 246, 0.2);
        }

        .performance-hero-content {
            position: relative;
            z-index: 2;
        }

        .performance-hero h1 {
            margin-bottom: 8px;

            font-size: 32px;
        }

        .performance-hero p {
            color: #cbd5e1;

            margin-bottom: 0;
        }

        .performance-summary {
            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 18px;

            margin-bottom: 25px;
        }

        .performance-stat {
            position: relative;

            overflow: hidden;

            padding: 22px;

            background: var(--surface);

            border:
                1px solid
                var(--border);

            border-radius: 14px;

            box-shadow:
                var(--shadow-sm);

            transition: var(--transition);
        }

        .performance-stat:hover {
            transform: translateY(-4px);

            box-shadow:
                var(--shadow);
        }

        .performance-stat::after {
            content: "";

            position: absolute;

            width: 75px;
            height: 75px;

            right: -25px;
            bottom: -25px;

            border-radius: 50%;

            background:
                var(--primary-light);
        }

        .performance-stat .stat-icon {
            width: 40px;
            height: 40px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin-bottom: 15px;

            border-radius: 10px;

            background:
                var(--primary-light);

            color:
                var(--primary);

            font-size: 14px;

            font-weight: 750;
        }

        .performance-stat .label {
            color:
                var(--text-secondary);

            font-size: 12px;

            margin-bottom: 5px;
        }

        .performance-stat .value {
            font-size: 26px;

            font-weight: 800;

            position: relative;

            z-index: 2;
        }

        .performance-stat .subtext {
            color:
                var(--text-muted);

            font-size: 12px;

            margin-top: 5px;

            position: relative;

            z-index: 2;
        }

        .history-panel {
            overflow: hidden;
        }

        .history-header {
            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;

            margin-bottom: 5px;
        }

        .history-count {
            display: inline-flex;

            align-items: center;

            padding: 6px 10px;

            border-radius: 999px;

            background:
                var(--primary-light);

            color:
                var(--primary);

            font-size: 12px;

            font-weight: 700;
        }

        .score-cell {
            font-weight: 750;

            white-space: nowrap;
        }

        .percentage-cell {
            min-width: 130px;
        }

        .percentage-value {
            display: flex;

            align-items: center;

            gap: 10px;

            font-weight: 700;
        }

        .mini-progress {
            width: 65px;

            height: 6px;

            overflow: hidden;

            border-radius: 999px;

            background:
                var(--border);
        }

        .mini-progress-bar {
            height: 100%;

            border-radius: inherit;

            background:
                var(--primary);

            transition:
                width 0.7s ease;
        }

        .result-pass {
            background:
                var(--success-light);

            color:
                var(--success);
        }

        .result-fail {
            background:
                var(--danger-light);

            color:
                var(--danger);
        }

        .empty-history {
            text-align: center;

            padding: 70px 20px;
        }

        .empty-history-icon {
            width: 72px;
            height: 72px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin: 0 auto 20px;

            border-radius: 50%;

            background:
                var(--primary-light);

            color:
                var(--primary);

            font-size: 28px;

            animation:
                emptyFloat 2.5s ease-in-out infinite;
        }

        @keyframes emptyFloat {

            0%,
            100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-6px);
            }

        }

        .empty-history h3 {
            margin-bottom: 8px;
        }

        .empty-history p {
            max-width: 500px;

            margin:
                0 auto 22px;

            color:
                var(--text-secondary);
        }

        .performance-footer {
            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 15px;

            margin-top: 20px;

            flex-wrap: wrap;
        }

        .performance-insight {
            color:
                var(--text-secondary);

            font-size: 13px;
        }

        @media (max-width: 900px) {

            .performance-summary {
                grid-template-columns:
                    repeat(2, 1fr);
            }

        }

        @media (max-width: 600px) {

            .performance-summary {
                grid-template-columns: 1fr;
            }

            .performance-hero {
                padding: 27px 22px;
            }

            .performance-hero h1 {
                font-size: 27px;
            }

            .history-header {
                align-items: flex-start;

                flex-direction: column;
            }

            .performance-footer {
                align-items: flex-start;

                flex-direction: column;
            }

        }

    </style>

</head>


<body>


<nav class="navbar">

    <a href="dashboard.jsp" class="logo">
        Online Exam
    </a>


    <div class="nav-links">

        <a href="dashboard.jsp">
            Dashboard
        </a>

        <a href="performance">
            Performance
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


        <div class="performance-hero">

            <div class="performance-hero-content">

                <h1>
                    Performance History
                </h1>

                <p>
                    Track your examination performance,
                    scores and progress over time.
                </p>

            </div>

        </div>



        <div class="performance-summary">


            <div class="performance-stat">

                <div class="stat-icon">
                    #
                </div>

                <div class="label">
                    Total Attempts
                </div>

                <div class="value">
                    <%= totalAttempts %>
                </div>

                <div class="subtext">
                    Completed examinations
                </div>

            </div>



            <div class="performance-stat">

                <div class="stat-icon">
                    ✓
                </div>

                <div class="label">
                    Passed
                </div>

                <div class="value">
                    <%= passedAttempts %>
                </div>

                <div class="subtext">
                    Successful attempts
                </div>

            </div>



            <div class="performance-stat">

                <div class="stat-icon">
                    %
                </div>

                <div class="label">
                    Average Score
                </div>

                <div class="value">

                    <%= String.format(
                        "%.2f",
                        averagePercentage
                    ) %>%

                </div>

                <div class="subtext">
                    Across all attempts
                </div>

            </div>



            <div class="performance-stat">

                <div class="stat-icon">
                    ★
                </div>

                <div class="label">
                    Best Score
                </div>

                <div class="value">

                    <%= String.format(
                        "%.2f",
                        highestPercentage
                    ) %>%

                </div>

                <div class="subtext">
                    Highest percentage
                </div>

            </div>


        </div>



        <div class="panel history-panel">


            <div class="history-header">


                <div>

                    <h2>
                        Examination History
                    </h2>

                    <p class="page-subtitle">

                        Your previous examination attempts
                        and results.

                    </p>

                </div>


                <%
                    if (totalAttempts > 0) {
                %>

                <span class="history-count">

                    <%= totalAttempts %>
                    Attempt<%= totalAttempts == 1 ? "" : "s" %>

                </span>

                <%
                    }
                %>


            </div>



            <%
                if (results != null &&
                        !results.isEmpty()) {
            %>


            <div class="table-container">

                <table class="data-table">


                    <thead>

                    <tr>

                        <th>
                            #
                        </th>

                        <th>
                            Examination
                        </th>

                        <th>
                            Date
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

                    </tr>

                    </thead>


                    <tbody>


                    <%
                        int rowNumber = 1;

                        for (Result result : results) {

                            double percentage = 0;

                            if (result.getTotalQuestions() > 0) {

                                percentage =
                                    ((double) result.getScore()
                                    / result.getTotalQuestions())
                                    * 100;
                            }

                            boolean passed =
                                    percentage >= 40;
                    %>


                    <tr>


                        <td>

                            <strong>
                                <%= rowNumber++ %>
                            </strong>

                        </td>



                        <td>

                            <strong>
                                Online Examination
                            </strong>

                        </td>



                        <td>

                            <%= result.getSubmittedAt() %>

                        </td>



                        <td class="score-cell">

                            <%= result.getScore() %>
                            /
                            <%= result.getTotalQuestions() %>

                        </td>



                        <td class="percentage-cell">


                            <div class="percentage-value">

                                <span>

                                    <%= String.format(
                                        "%.2f",
                                        percentage
                                    ) %>%

                                </span>


                                <div class="mini-progress">

                                    <div
                                        class="mini-progress-bar"
                                        data-width="<%= Math.min(percentage, 100) %>">
                                    </div>

                                </div>

                            </div>


                        </td>



                        <td>


                            <%
                                if (passed) {
                            %>


                            <span
                                class="badge result-pass">

                                ✓ PASS

                            </span>


                            <%
                                } else {
                            %>


                            <span
                                class="badge result-fail">

                                ✕ FAIL

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


            <div class="performance-footer">


                <div class="performance-insight">

                    Pass rate:
                    <strong>
                        <%= passRate %>%
                    </strong>

                </div>


                <a
                    href="dashboard.jsp"
                    class="btn btn-outline">

                    ← Back to Dashboard

                </a>


            </div>


            <%
                } else {
            %>


            <div class="empty-history">


                <div class="empty-history-icon">
                    📊
                </div>


                <h3>
                    No Examination History
                </h3>


                <p>

                    You haven't completed any examinations yet.
                    Your results will appear here after your
                    first exam.

                </p>


                <a
                    href="dashboard.jsp"
                    class="btn btn-primary">

                    Start Examination →

                </a>


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



<script
    src="${pageContext.request.contextPath}/js/theme.js">
</script>
<script>

    document.querySelectorAll(".mini-progress-bar")
        .forEach(function(bar) {

            const width = bar.getAttribute("data-width");

            bar.style.width = width + "%";

        });

</script>

</body>

</html>