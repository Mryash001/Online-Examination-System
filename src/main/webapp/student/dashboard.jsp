<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"STUDENT".equals(session.getAttribute("role"))) {

        response.sendRedirect("../login.jsp");
        return;
    }

    String userName =
            (String) session.getAttribute("userName");

    String userEmail =
            (String) session.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Dashboard | Online Exam</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .student-hero {
            position: relative;
            overflow: hidden;

            padding: 38px;

            margin-bottom: 25px;

            border-radius: 18px;

            background:
                linear-gradient(
                    135deg,
                    #2563eb,
                    #4f46e5
                );

            color: white;

            box-shadow:
                0 20px 45px
                rgba(37, 99, 235, 0.22);

            animation: slideUp 0.5s ease;
        }

        .student-hero::before {
            content: "";

            position: absolute;

            width: 260px;
            height: 260px;

            right: -90px;
            top: -110px;

            border-radius: 50%;

            background:
                rgba(255, 255, 255, 0.1);
        }

        .student-hero::after {
            content: "";

            position: absolute;

            width: 180px;
            height: 180px;

            left: 45%;
            bottom: -120px;

            border-radius: 50%;

            background:
                rgba(255, 255, 255, 0.08);
        }

        .student-hero-content {
            position: relative;
            z-index: 2;
        }

        .student-hero h1 {
            margin-bottom: 8px;

            font-size: 34px;

            letter-spacing: -0.8px;
        }

        .student-hero p {
            color: #dbeafe;

            margin-bottom: 0;
        }

        .student-badge {
            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 18px;

            padding: 7px 12px;

            border-radius: 999px;

            background:
                rgba(255, 255, 255, 0.12);

            border:
                1px solid
                rgba(255, 255, 255, 0.15);

            font-size: 12px;
        }

        .student-badge::before {
            content: "";

            width: 7px;
            height: 7px;

            border-radius: 50%;

            background: #22c55e;

            box-shadow:
                0 0 8px
                #22c55e;
        }

        .profile-panel {
            display: flex;

            align-items: center;

            gap: 18px;

            padding: 22px 25px;

            margin-bottom: 24px;
        }

        .profile-avatar {
            width: 52px;
            height: 52px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: var(--primary-light);

            color: var(--primary);

            font-size: 21px;

            font-weight: 750;

            flex-shrink: 0;
        }

        .profile-info strong {
            display: block;

            margin-bottom: 4px;

            font-size: 15px;
        }

        .profile-info span {
            color: var(--text-secondary);

            font-size: 13px;
        }

        .student-stats {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;

            margin-bottom: 25px;
        }

        .student-stat {
            position: relative;

            overflow: hidden;

            padding: 24px;

            background: var(--surface);

            border:
                1px solid
                var(--border);

            border-radius: 14px;

            box-shadow: var(--shadow-sm);

            transition: var(--transition);
        }

        .student-stat:hover {
            transform: translateY(-4px);

            box-shadow: var(--shadow);

            border-color:
                var(--border-hover);
        }

        .student-stat::after {
            content: "";

            position: absolute;

            width: 85px;
            height: 85px;

            right: -25px;
            bottom: -30px;

            border-radius: 50%;

            background:
                var(--primary-light);
        }

        .student-stat-icon {
            width: 42px;
            height: 42px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin-bottom: 15px;

            border-radius: 10px;

            background:
                var(--primary-light);

            color:
                var(--primary);

            font-weight: 750;
        }

        .student-stat .label {
            color:
                var(--text-secondary);

            font-size: 12px;

            margin-bottom: 5px;
        }

        .student-stat .value {
            font-size: 25px;

            font-weight: 800;

            position: relative;

            z-index: 2;
        }

        .exam-main-card {
            position: relative;

            overflow: hidden;

            padding: 34px;

            margin-bottom: 25px;

            background: var(--surface);

            border:
                1px solid
                var(--border);

            border-radius: 18px;

            box-shadow: var(--shadow);

            transition: var(--transition);
        }

        .exam-main-card:hover {
            transform: translateY(-3px);

            box-shadow: var(--shadow-lg);
        }

        .exam-main-card::before {
            content: "";

            position: absolute;

            width: 200px;
            height: 200px;

            right: -70px;
            top: -80px;

            border-radius: 50%;

            background:
                var(--primary-light);
        }

        .exam-card-content {
            position: relative;

            z-index: 2;
        }

        .exam-icon {
            width: 55px;
            height: 55px;

            display: flex;

            align-items: center;
            justify-content: center;

            margin-bottom: 20px;

            border-radius: 14px;

            background:
                var(--primary-light);

            color:
                var(--primary);

            font-size: 24px;

            font-weight: 750;
        }

        .exam-main-card h2 {
            margin-bottom: 8px;
        }

        .exam-main-card p {
            max-width: 700px;

            color:
                var(--text-secondary);

            margin-bottom: 22px;
        }

        .exam-features {
            display: flex;

            flex-wrap: wrap;

            gap: 10px;

            margin-bottom: 25px;
        }

        .exam-feature {
            padding: 7px 11px;

            border-radius: 8px;

            background:
                var(--bg);

            border:
                1px solid
                var(--border);

            color:
                var(--text-secondary);

            font-size: 12px;

            font-weight: 600;
        }

        .start-exam-btn {
            min-width: 190px;
        }

        .performance-panel {
            padding: 28px;
        }

        .performance-content {
            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 20px;
        }

        .performance-content p {
            color:
                var(--text-secondary);

            margin-bottom: 0;
        }

        .dashboard-actions {
            display: flex;

            gap: 10px;

            flex-wrap: wrap;
        }

        @media (max-width: 768px) {

            .student-hero {
                padding: 30px 24px;
            }

            .student-hero h1 {
                font-size: 28px;
            }

            .student-stats {
                grid-template-columns: 1fr;
            }

            .profile-panel {
                align-items: flex-start;
            }

            .performance-content {
                align-items: flex-start;

                flex-direction: column;
            }

            .exam-main-card {
                padding: 26px 22px;
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


        <div class="student-hero">

            <div class="student-hero-content">

                <h1>

                    Welcome,
                    <%= userName %>
                    👋

                </h1>

                <p>

                    Ready to test your knowledge?
                    Your next challenge is waiting.

                </p>


                <div class="student-badge">

                    Student Account

                </div>

            </div>

        </div>



        <div class="panel profile-panel">


            <div class="profile-avatar">

                <%= userName != null &&
                    !userName.isEmpty()
                    ? userName.substring(0, 1).toUpperCase()
                    : "S" %>

            </div>


            <div class="profile-info">

                <strong>

                    <%= userName %>

                </strong>

                <span>

                    <%= userEmail %>

                </span>

            </div>


        </div>



        <div class="student-stats">


            <div class="student-stat">

                <div class="student-stat-icon">
                    MCQ
                </div>

                <div class="label">
                    Examination
                </div>

                <div class="value">
                    MCQ
                </div>

            </div>



            <div class="student-stat">

                <div class="student-stat-icon">
                    #
                </div>

                <div class="label">
                    Questions
                </div>

                <div class="value">
                    10
                </div>

            </div>



            <div class="student-stat">

                <div class="student-stat-icon">
                    ⏱
                </div>

                <div class="label">
                    Duration
                </div>

                <div class="value">
                    10 min
                </div>

            </div>


        </div>



        <div class="exam-main-card">


            <div class="exam-card-content">


                <div class="exam-icon">
                    ✓
                </div>


                <h2>
                    Online Examination
                </h2>


                <p>

                    Attempt a randomized multiple-choice
                    examination. Your answers will be
                    evaluated automatically and your result
                    will be available immediately after
                    submission.

                </p>



                <div class="exam-features">


                    <span class="exam-feature">
                        10 Questions
                    </span>


                    <span class="exam-feature">
                        10 Minutes
                    </span>


                    <span class="exam-feature">
                        Automatic Evaluation
                    </span>


                    <span class="exam-feature">
                        Instant Result
                    </span>


                </div>



                <a
                    href="../exam/start"
                    class="btn btn-primary start-exam-btn">

                    Start Examination →

                </a>


            </div>

        </div>



        <div class="panel performance-panel">


            <div class="performance-content">


                <div>

                    <h2>
                        Your Performance
                    </h2>

                    <p>

                        Review your previous examination
                        results and track your progress.

                    </p>

                </div>


                <div class="dashboard-actions">

                    <a
                        href="performance"
                        class="btn btn-outline">

                        View History

                    </a>

                </div>


            </div>


        </div>


    </div>

</div>



<footer class="footer">

    Online Examination System

</footer>



<script
    src="${pageContext.request.contextPath}/js/theme.js">
</script>


</body>

</html>