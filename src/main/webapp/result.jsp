<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"STUDENT".equals(session.getAttribute("role"))) {

        response.sendRedirect("login.jsp");
        return;
    }

    Integer score =
            (Integer) request.getAttribute("score");

    Integer totalQuestions =
            (Integer) request.getAttribute("totalQuestions");

    if (score == null || totalQuestions == null) {

        response.sendRedirect(
            request.getContextPath() +
            "/student/dashboard.jsp"
        );

        return;
    }

    double percentage =
            ((double) score / totalQuestions) * 100;

    Boolean examTimedOut =
            (Boolean) request.getAttribute("examTimedOut");

    boolean passed =
            percentage >= 40;

    int incorrect =
            totalQuestions - score;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Exam Result | Online Exam</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .result-page {
            min-height: calc(100vh - 70px);

            padding: 45px 20px 70px;

            display: flex;

            justify-content: center;

            position: relative;

            overflow: hidden;
        }

        .result-page::before {
            content: "";

            position: absolute;

            width: 360px;
            height: 360px;

            top: -160px;
            left: -120px;

            border-radius: 50%;

            background:
                var(--primary);

            opacity: 0.06;

            filter: blur(3px);
        }

        .result-page::after {
            content: "";

            position: absolute;

            width: 330px;
            height: 330px;

            right: -140px;
            bottom: -150px;

            border-radius: 50%;

            background:
                var(--primary-light);

            opacity: 0.07;
        }

        .result-card {
            width: 100%;
            max-width: 760px;

            position: relative;

            z-index: 2;

            padding: 40px;

            background:
                var(--card-bg);

            border:
                1px solid
                var(--border-color);

            border-radius: 24px;

            box-shadow:
                var(--shadow);

            text-align: center;

            animation:
                resultEnter 0.6s ease;

            transition:
                background 0.3s ease,
                border-color 0.3s ease;
        }

        .result-icon {
            width: 82px;
            height: 82px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin: 0 auto 20px;

            border-radius: 50%;

            font-size: 38px;
            font-weight: 800;

            animation:
                resultIconEnter 0.7s ease;
        }

        .result-icon.pass {
            background:
                rgba(22, 163, 74, 0.12);

            color:
                #16a34a;

            box-shadow:
                0 0 0 10px
                rgba(22, 163, 74, 0.05);
        }

        .result-icon.fail {
            background:
                rgba(220, 38, 38, 0.12);

            color:
                #dc2626;

            box-shadow:
                0 0 0 10px
                rgba(220, 38, 38, 0.05);
        }

        .timeout-box {
            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom: 25px;

            padding: 14px 17px;

            border-radius: 12px;

            background:
                rgba(245, 158, 11, 0.1);

            border:
                1px solid
                rgba(245, 158, 11, 0.3);

            color:
                #b45309;

            font-size: 14px;

            font-weight: 600;

            text-align: left;

            animation:
                alertEnter 0.4s ease;
        }

        .timeout-icon {
            font-size: 22px;

            flex-shrink: 0;
        }

        .result-heading {
            margin: 0;

            color:
                var(--text-primary);

            font-size: 30px;
        }

        .result-message {
            max-width: 560px;

            margin:
                10px auto 25px;

            color:
                var(--text-secondary);

            font-size: 15px;

            line-height: 1.6;
        }

        .result-score {
            margin:
                18px 0 2px;

            color:
                var(--text-primary);

            font-size: 66px;

            font-weight: 800;

            letter-spacing: -2px;

            animation:
                scoreReveal 0.8s ease;
        }

        .score-label {
            margin: 0;

            color:
                var(--text-muted);

            font-size: 13px;

            text-transform: uppercase;

            letter-spacing: 1px;

            font-weight: 700;
        }

        .result-progress {
            max-width: 500px;

            height: 11px;

            margin:
                25px auto 30px;

            overflow: hidden;

            border-radius: 20px;

            background:
                var(--progress-bg);
        }

        .result-progress-bar {
            width: 0%;

            height: 100%;

            border-radius: inherit;

            transition:
                width 1s ease;
        }

        .result-progress-bar.pass {
            background:
                linear-gradient(
                    90deg,
                    #16a34a,
                    #4ade80
                );
        }

        .result-progress-bar.fail {
            background:
                linear-gradient(
                    90deg,
                    #dc2626,
                    #fb7185
                );
        }

        .result-details {
            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 15px;

            margin: 30px 0;
        }

        .result-detail {
            padding: 20px;

            border:
                1px solid
                var(--border-color);

            border-radius: 14px;

            background:
                var(--input-bg);

            text-align: left;

            transition:
                transform 0.2s ease,
                border-color 0.2s ease,
                background 0.3s ease;
        }

        .result-detail:hover {
            transform:
                translateY(-3px);

            border-color:
                var(--primary);
        }

        .result-detail .label {
            display: block;

            margin-bottom: 8px;

            color:
                var(--text-secondary);

            font-size: 13px;
        }

        .result-detail .value {
            color:
                var(--text-primary);

            font-size: 22px;

            font-weight: 800;
        }

        .result-status {
            margin:
                25px auto;

            padding:
                12px 20px;

            width: fit-content;

            border-radius: 30px;

            font-weight: 800;
        }

        .result-status.pass {
            background:
                rgba(22, 163, 74, 0.1);

            color:
                #16a34a;
        }

        .result-status.fail {
            background:
                rgba(220, 38, 38, 0.1);

            color:
                #dc2626;
        }

        .result-status h2 {
            margin: 0;

            font-size: 18px;
        }

        .result-actions {
            display: flex;

            justify-content: center;

            gap: 12px;

            flex-wrap: wrap;

            margin-top: 30px;

            padding-top: 25px;

            border-top:
                1px solid
                var(--border-color);
        }

        .result-actions .btn {
            min-width: 170px;
        }

        .result-note {
            margin-top: 25px;

            color:
                var(--text-muted);

            font-size: 12px;
        }

        .theme-toggle {
            width: 42px;
            height: 42px;

            border:
                1px solid
                var(--border-color);

            border-radius: 50%;

            background:
                var(--card-bg);

            color:
                var(--text-primary);

            cursor: pointer;

            font-size: 18px;

            transition:
                all 0.25s ease;
        }

        .theme-toggle:hover {
            transform:
                rotate(15deg)
                scale(1.05);

            border-color:
                var(--primary);
        }

        @keyframes resultEnter {

            from {
                opacity: 0;

                transform:
                    translateY(25px)
                    scale(0.98);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0)
                    scale(1);
            }

        }

        @keyframes resultIconEnter {

            from {
                opacity: 0;

                transform:
                    scale(0.5)
                    rotate(-15deg);
            }

            to {
                opacity: 1;

                transform:
                    scale(1)
                    rotate(0);
            }

        }

        @keyframes scoreReveal {

            from {
                opacity: 0;

                transform:
                    translateY(10px);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0);
            }

        }

        @keyframes alertEnter {

            from {
                opacity: 0;

                transform:
                    translateY(-8px);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0);
            }

        }

        @media (max-width: 700px) {

            .result-page {
                padding:
                    25px 12px 50px;
            }

            .result-card {
                padding:
                    30px 18px;

                border-radius:
                    18px;
            }

            .result-heading {
                font-size: 25px;
            }

            .result-score {
                font-size: 52px;
            }

            .result-details {
                grid-template-columns:
                    1fr;
            }

            .result-actions {
                flex-direction:
                    column;
            }

            .result-actions .btn {
                width: 100%;
            }

        }

    </style>

</head>

<body>


<nav class="navbar">


    <a
        href="<%= request.getContextPath() %>/student/dashboard.jsp"
        class="logo">

        Online Exam

    </a>


    <div class="nav-links">


        <a
            href="<%= request.getContextPath() %>/student/dashboard.jsp">

            Dashboard

        </a>


        <a
            href="<%= request.getContextPath() %>/student/performance">

            Performance

        </a>


        <a
            href="<%= request.getContextPath() %>/logout">

            Logout

        </a>


        <button
            id="themeToggle"
            class="theme-toggle"
            type="button"
            title="Toggle theme">

            ☾

        </button>


    </div>


</nav>



<main class="result-page">


    <div class="result-card">


        <%
            if (Boolean.TRUE.equals(examTimedOut)) {
        %>


        <div class="timeout-box">

            <span class="timeout-icon">
                ⏱
            </span>

            <div>

                <strong>
                    Time Expired
                </strong>

                <br>

                Your examination time ended before
                all questions were completed.

            </div>

        </div>


        <%
            }
        %>



        <div class="result-icon <%= passed ? "pass" : "fail" %>">

            <%= passed ? "✓" : "✕" %>

        </div>



        <h1 class="result-heading">

            Exam Completed

        </h1>



        <p class="result-message">

            Well done,
            <strong>
                <%= session.getAttribute("userName") %>
            </strong>!

            Here is your examination result.

        </p>



        <div class="result-score">

            <%= score %>
            /
            <%= totalQuestions %>

        </div>



        <p class="score-label">

            Your Score

        </p>



        <div class="result-progress">

            <div
                id="resultProgress"
                class="result-progress-bar <%= passed ? "pass" : "fail" %>"
                data-width="<%= Math.min(percentage, 100) %>">

            </div>

        </div>



        <div class="result-details">


            <div class="result-detail">

                <span class="label">

                    Correct Answers

                </span>

                <span class="value">

                    <%= score %>

                </span>

            </div>



            <div class="result-detail">

                <span class="label">

                    Incorrect / Unanswered

                </span>

                <span class="value">

                    <%= incorrect %>

                </span>

            </div>



            <div class="result-detail">

                <span class="label">

                    Total Questions

                </span>

                <span class="value">

                    <%= totalQuestions %>

                </span>

            </div>



            <div class="result-detail">

                <span class="label">

                    Percentage

                </span>

                <span class="value">

                    <%= String.format("%.2f", percentage) %>%

                </span>

            </div>


        </div>



        <div class="result-status <%= passed ? "pass" : "fail" %>">

            <h2>

                Result:
                <%= passed ? "PASS" : "FAIL" %>

            </h2>

        </div>



        <div class="result-actions">


            <a
                href="<%= request.getContextPath() %>/student/dashboard.jsp"
                class="btn btn-primary">

                ← Dashboard

            </a>


            <a
                href="<%= request.getContextPath() %>/student/performance"
                class="btn btn-outline">

                View Performance

            </a>


            <a
                href="<%= request.getContextPath() %>/logout"
                class="btn btn-dark">

                Logout

            </a>


        </div>



        <p class="result-note">

            Your examination result has been saved
            to your performance history.

        </p>


    </div>


</main>



<footer class="footer">

    Online Examination System

</footer>



<script>

    function initializeTheme() {

        const savedTheme =
            localStorage.getItem("theme");

        const prefersDark =
            window.matchMedia(
                "(prefers-color-scheme: dark)"
            ).matches;


        if (
            savedTheme === "dark" ||
            (!savedTheme && prefersDark)
        ) {

            document.documentElement
                .setAttribute(
                    "data-theme",
                    "dark"
                );

        } else {

            document.documentElement
                .setAttribute(
                    "data-theme",
                    "light"
                );

        }


        updateThemeIcon();

    }


    function toggleTheme() {

        const currentTheme =
            document.documentElement
                .getAttribute("data-theme");


        const newTheme =
            currentTheme === "dark"
                ? "light"
                : "dark";


        document.documentElement
            .setAttribute(
                "data-theme",
                newTheme
            );


        localStorage.setItem(
            "theme",
            newTheme
        );


        updateThemeIcon();

    }


    function updateThemeIcon() {

        const button =
            document.getElementById(
                "themeToggle"
            );


        if (!button) {
            return;
        }


        const theme =
            document.documentElement
                .getAttribute("data-theme");


        if (theme === "dark") {

            button.innerHTML = "☀";

            button.title =
                "Switch to light theme";

        } else {

            button.innerHTML = "☾";

            button.title =
                "Switch to dark theme";

        }

    }


    document.getElementById("themeToggle")
        .addEventListener(
            "click",
            toggleTheme
        );



    function animateResultProgress() {

        const progress =
            document.getElementById(
                "resultProgress"
            );


        if (!progress) {
            return;
        }


        const width =
            progress.getAttribute(
                "data-width"
            );


        setTimeout(
            function() {

                progress.style.width =
                    width + "%";

            },
            250
        );

    }


    initializeTheme();

    animateResultProgress();

</script>


</body>

</html>