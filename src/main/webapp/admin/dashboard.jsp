<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

        response.sendRedirect("login.jsp");
        return;
    }

    String xmlStatus = request.getParameter("xml");
    String count = request.getParameter("count");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Admin Dashboard</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .admin-hero {
            position: relative;
            overflow: hidden;
            background:
                linear-gradient(
                    135deg,
                    #1e293b,
                    #0f172a
                );
            color: white;
            border-radius: 18px;
            padding: 40px;
            margin-bottom: 25px;
            box-shadow: var(--shadow-lg);
        }

        .admin-hero::before {
            content: "";
            position: absolute;
            width: 250px;
            height: 250px;
            right: -80px;
            top: -100px;
            border-radius: 50%;
            background: rgba(59, 130, 246, 0.2);
        }

        .admin-hero::after {
            content: "";
            position: absolute;
            width: 150px;
            height: 150px;
            left: 40%;
            bottom: -100px;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.15);
        }

        .admin-hero-content {
            position: relative;
            z-index: 2;
        }

        .admin-hero h1 {
            margin-bottom: 8px;
            font-size: 34px;
        }

        .admin-hero p {
            color: #cbd5e1;
            margin-bottom: 0;
        }

        .admin-badge {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 12px;
            margin-top: 18px;
        }

        .admin-badge::before {
            content: "";
            width: 7px;
            height: 7px;
            background: #22c55e;
            border-radius: 50%;
            box-shadow: 0 0 8px #22c55e;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        .admin-section {
            position: relative;
            overflow: hidden;
            padding: 30px;
            min-height: 240px;
            transition:
                transform 0.3s ease,
                box-shadow 0.3s ease,
                border-color 0.3s ease;
        }

        .admin-section:hover {
            transform: translateY(-4px);
        }

        .admin-section-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            background: var(--primary-light);
            color: var(--primary);
            font-size: 23px;
            margin-bottom: 20px;
        }

        .admin-section h2 {
            margin-bottom: 10px;
        }

        .admin-section p {
            color: var(--text-secondary);
            font-size: 14px;
            max-width: 500px;
        }

        .admin-section-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 22px;
        }

        .xml-section .admin-section-icon {
            background: #f1f5f9;
            color: #475569;
        }

        .performance-section {
            grid-column: 1 / -1;
            position: relative;
            overflow: hidden;
            padding: 42px 38px;
            min-height: auto;
            border: 1px solid rgba(59, 130, 246, 0.25);
            border-radius: 22px;
            background:
                radial-gradient(
                    circle at 90% 110%,
                    rgba(37, 99, 235, 0.14),
                    transparent 32%
                ),
                linear-gradient(
                    135deg,
                    rgba(15, 23, 42, 0.98),
                    rgba(8, 15, 32, 0.98)
                );
            box-shadow:
                0 20px 50px rgba(0, 0, 0, 0.25),
                inset 0 1px 0 rgba(255, 255, 255, 0.03);
            transition:
                transform 0.3s ease,
                border-color 0.3s ease,
                box-shadow 0.3s ease;
        }

        body.light-theme .performance-section {
            background: #ffffff;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            color: var(--text-primary);
        }

        body.light-theme .performance-section h2 {
            color: var(--text-primary);
        }

        body.light-theme .performance-section-description {
            color: var(--text-secondary);
        }

        body.light-theme .performance-feature {
            background: var(--bg);
            border: 1px solid var(--border);
        }

        body.light-theme .performance-feature:hover {
            background: #ffffff;
            border-color: var(--primary);
            box-shadow: var(--shadow);
        }

        body.light-theme .performance-feature strong {
            color: var(--text-primary);
        }

        body.light-theme .performance-feature span {
            color: var(--text-secondary);
        }


        body.dark-theme .performance-section {
            background:
                radial-gradient(
                    circle at 90% 110%,
                    rgba(37, 99, 235, 0.14),
                    transparent 32%
                ),
                linear-gradient(
                    135deg,
                    #0f172a,
                    #080f20
                );

            border-color: rgba(59, 130, 246, 0.25);
            color: #f8fafc;
        }

        body.dark-theme .performance-feature {
            background: rgba(15, 23, 42, 0.72);
            border-color: rgba(148, 163, 184, 0.16);
        }

        body.dark-theme .performance-feature:hover {
            background: rgba(20, 32, 55, 0.9);
        }

        .performance-section:hover {
            transform: translateY(-3px);
            border-color: rgba(59, 130, 246, 0.45);
            box-shadow:
                0 25px 60px rgba(0, 0, 0, 0.3),
                0 0 35px rgba(37, 99, 235, 0.08);
        }

        .performance-section::before {
            content: "";
            position: absolute;
            width: 260px;
            height: 260px;
            left: -150px;
            top: -150px;
            border-radius: 50%;
            background: rgba(59, 130, 246, 0.06);
            pointer-events: none;
        }

        .performance-section::after {
            content: "";
            position: absolute;
            width: 220px;
            height: 220px;
            right: -100px;
            bottom: -120px;
            border-radius: 50%;
            background: rgba(37, 99, 235, 0.08);
            pointer-events: none;
        }

        .performance-link-panel {
            margin-top: 25px;
        }

        .performance-link-panel .panel-header {
            align-items: center;
        }

        @media (max-width: 768px) {

            .performance-link-panel .panel-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

        }

        .performance-section-header {
            position: relative;
            text-align: center;
            max-width: 720px;
            margin: 0 auto 32px;
            z-index: 1;
        }

        .performance-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 16px;
            font-size: 28px;
            background:
                linear-gradient(
                    135deg,
                    rgba(37, 99, 235, 0.18),
                    rgba(99, 102, 241, 0.18)
                );
            border: 1px solid rgba(59, 130, 246, 0.25);
            box-shadow:
                0 10px 30px rgba(37, 99, 235, 0.12);
        }

        .performance-section h2 {
            margin: 0 0 10px;
            font-size: 29px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .performance-section-description {
            margin: 0 auto;
            max-width: 680px;
            color: var(--text-secondary);
            font-size: 15px;
            line-height: 1.7;
        }

        .performance-features {
            position: relative;
            z-index: 1;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-top: 30px;
        }

        .performance-feature {
            position: relative;
            padding: 25px 23px;
            min-height: 145px;
            border-radius: 16px;
            background: rgba(15, 23, 42, 0.72);
            border: 1px solid rgba(148, 163, 184, 0.16);
            transition:
                transform 0.25s ease,
                border-color 0.25s ease,
                background 0.25s ease,
                box-shadow 0.25s ease;
        }

        .performance-feature:hover {
            transform: translateY(-5px);
            border-color: rgba(59, 130, 246, 0.4);
            background: rgba(20, 32, 55, 0.9);
            box-shadow:
                0 12px 30px rgba(0, 0, 0, 0.2);
        }

        .performance-feature-icon {
            width: 44px;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            border-radius: 12px;
            font-size: 20px;
            background: rgba(37, 99, 235, 0.12);
        }

        .performance-feature:nth-child(2)
        .performance-feature-icon {
            background: rgba(34, 197, 94, 0.12);
        }

        .performance-feature:nth-child(3)
        .performance-feature-icon {
            background: rgba(245, 158, 11, 0.12);
        }

        .performance-feature strong {
            display: block;
            margin-bottom: 7px;
            color: var(--text-primary);
            font-size: 16px;
            font-weight: 700;
        }

        .performance-feature span {
            display: block;
            color: var(--text-secondary);
            font-size: 13px;
            line-height: 1.6;
        }

        .performance-action {
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }

        .performance-action .btn {
            min-width: 260px;
            justify-content: center;
            box-shadow:
                0 12px 30px rgba(37, 99, 235, 0.2);
        }

        .performance-action .btn:hover {
            transform: translateY(-2px);
            box-shadow:
                0 16px 35px rgba(37, 99, 235, 0.3);
        }

        .system-section {
            grid-column: 1 / -1;
        }

        .system-info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 20px;
        }

        .system-item {
            padding: 15px;
            background: var(--bg);
            border: 1px solid var(--border);
            border-radius: 9px;
        }

        .system-item strong {
            display: block;
            margin-bottom: 5px;
        }

        .system-item span {
            color: var(--text-secondary);
            font-size: 13px;
        }

        .status-message {
            padding: 15px 18px;
            border-radius: 10px;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            animation: slideUp 0.4s ease;
        }

        .status-message.success {
            background: var(--success-light);
            color: var(--success);
            border: 1px solid rgba(22, 163, 74, 0.2);
        }

        .status-message.error {
            background: var(--danger-light);
            color: var(--danger);
            border: 1px solid rgba(220, 38, 38, 0.2);
        }

        .status-icon {
            font-size: 18px;
            font-weight: bold;
        }

        .status-content strong {
            display: block;
            margin-bottom: 3px;
        }

        .status-content span {
            font-size: 13px;
        }

        .danger-outline {
            border-color: rgba(220, 38, 38, 0.3);
            color: var(--danger) !important;
        }

        .danger-outline:hover {
            background: var(--danger-light);
            border-color: var(--danger);
        }

        .dashboard-footer-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        @media (max-width: 900px) {

            .performance-features {
                grid-template-columns: 1fr;
            }

            .performance-feature {
                min-height: auto;
            }

        }

        @media (max-width: 768px) {

            .admin-grid {
                grid-template-columns: 1fr;
            }

            .system-section {
                grid-column: auto;
            }

            .system-info {
                grid-template-columns: 1fr;
            }

            .admin-hero {
                padding: 30px 24px;
            }

            .admin-hero h1 {
                font-size: 28px;
            }

            .admin-section {
                padding: 25px;
            }

            .performance-section {
                grid-column: auto;
                padding: 32px 22px;
            }

        }

        @media (max-width: 600px) {

            .performance-section h2 {
                font-size: 24px;
            }

            .performance-section-description {
                font-size: 14px;
            }

            .performance-action .btn {
                width: 100%;
                min-width: 0;
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


        <div class="admin-hero">

            <div class="admin-hero-content">

                <h1>
                    Admin Dashboard
                </h1>

                <p>
                    Manage your Online Examination System
                    from one place.
                </p>

                <div class="admin-badge">
                    Administrator Access
                </div>

            </div>

        </div>


        <%
            if ("success".equals(xmlStatus)) {
        %>

        <div class="status-message success">

            <div class="status-icon">
                ✓
            </div>

            <div class="status-content">

                <strong>
                    XML questions imported successfully
                </strong>

                <span>

                    <%
                        if (count != null) {
                    %>

                    Questions added:
                    <%= count %>

                    <%
                        } else {
                    %>

                    The XML question import completed.

                    <%
                        }
                    %>

                </span>

            </div>

        </div>

        <%
            } else if ("notfound".equals(xmlStatus)) {
        %>

        <div class="status-message error">

            <div class="status-icon">
                !
            </div>

            <div class="status-content">

                <strong>
                    XML file not found
                </strong>

                <span>
                    The configured XML question file could not be found.
                </span>

            </div>

        </div>

        <%
            } else if ("empty".equals(xmlStatus)) {
        %>

        <div class="status-message error">

            <div class="status-icon">
                !
            </div>

            <div class="status-content">

                <strong>
                    XML file is empty
                </strong>

                <span>
                    The XML file does not contain any questions.
                </span>

            </div>

        </div>

        <%
            } else if ("failed".equals(xmlStatus)) {
        %>

        <div class="status-message error">

            <div class="status-icon">
                !
            </div>

            <div class="status-content">

                <strong>
                    XML import failed
                </strong>

                <span>
                    The system was unable to import the XML questions.
                </span>

            </div>

        </div>

        <%
            } else if ("deleted".equals(xmlStatus)) {
        %>

        <div class="status-message success">

            <div class="status-icon">
                ✓
            </div>

            <div class="status-content">

                <strong>
                    XML questions deleted
                </strong>

                <span>
                    Previously imported XML questions were removed successfully.
                </span>

            </div>

        </div>

        <%
            } else if ("deletefailed".equals(xmlStatus)) {
        %>

        <div class="status-message error">

            <div class="status-icon">
                !
            </div>

            <div class="status-content">

                <strong>
                    XML deletion failed
                </strong>

                <span>
                    The system could not delete the XML questions.
                </span>

            </div>

        </div>

        <%
            }
        %>


        <div class="panel">

            <div class="dashboard-header"
                 style="margin-bottom: 0;">

                <div>

                    <h2>
                        Welcome, <%= session.getAttribute("userName") %>
                    </h2>

                    <p>
                        You are logged in as an administrator.
                        Use the controls below to manage the examination.
                    </p>

                </div>

            </div>

        </div>


        <div class="admin-grid">


            <div class="panel admin-section">

                <div class="admin-section-icon">
                    ⚙
                </div>

                <h2>
                    Question Management
                </h2>

                <p>
                    Create, view, edit and delete examination
                    questions from the question bank.
                </p>

                <div class="admin-section-actions">

                    <a
                        href="add-question.jsp"
                        class="btn btn-primary">

                        + Add Question

                    </a>

                    <a
                        href="questions"
                        class="btn btn-outline">

                        View Questions

                    </a>

                </div>

            </div>


            <div class="panel admin-section xml-section">

                <div class="admin-section-icon">
                    XML
                </div>

                <h2>
                    XML Question Management
                </h2>

                <p>
                    Import questions from your XML file or
                    remove previously imported XML questions.
                </p>

                <div class="admin-section-actions">

                    <a
                        href="import-xml"
                        class="btn btn-dark">

                        Import Questions

                    </a>

                    <a
                        href="delete-xml"
                        class="btn btn-outline danger-outline"
                        onclick="return confirm('Are you sure you want to delete all XML questions?');">

                        Delete XML Questions

                    </a>

                </div>

            </div>


            <div class="panel performance-section">

                <div class="performance-section-header">

                    <div class="performance-icon">
                        📊
                    </div>

                    <h2>
                        Student Performance
                    </h2>

                    <p class="performance-section-description">
                        View all student examination attempts, scores,
                        percentages, pass and fail results in one place.
                    </p>

                </div>


                <div class="performance-features">


                    <div class="performance-feature">

                        <div class="performance-feature-icon">
                            📈
                        </div>

                        <strong>
                            Attempts
                        </strong>

                        <span>
                            See how many examinations each student
                            has attempted.
                        </span>

                    </div>


                    <div class="performance-feature">

                        <div class="performance-feature-icon">
                            🎯
                        </div>

                        <strong>
                            Scores
                        </strong>

                        <span>
                            Review individual scores, percentages
                            and average performance.
                        </span>

                    </div>


                    <div class="performance-feature">

                        <div class="performance-feature-icon">
                            ⏳
                        </div>

                        <strong>
                            Pending Students
                        </strong>

                        <span>
                            Identify students who have not attempted
                            an examination yet.
                        </span>

                    </div>


                </div>


                <div class="performance-action">

                    <a
                        href="performance"
                        class="btn btn-primary">

                        View Student Performance →

                    </a>

                </div>

            </div>


            <div class="panel admin-section system-section">

                <div class="admin-section-icon">
                    ◈
                </div>

                <h2>
                    System Information
                </h2>

                <p>
                    Keep your examination system organized
                    and monitor the important components.
                </p>


                <div class="system-info">


                    <div class="system-item">

                        <strong>
                            Question Bank
                        </strong>

                        <span>
                            Manage examination questions
                        </span>

                    </div>


                    <div class="system-item">

                        <strong>
                            XML Import
                        </strong>

                        <span>
                            Import questions automatically
                        </span>

                    </div>


                    <div class="system-item">

                        <strong>
                            Student Results
                        </strong>

                        <span>
                            Performance is stored automatically
                        </span>

                    </div>


                </div>

            </div>


        </div>


        <div class="dashboard-footer-actions">

            <a
                href="../index.jsp"
                class="btn btn-outline">

                ← Back to Home

            </a>


            <a
                href="../logout"
                class="btn btn-danger">

                Logout

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