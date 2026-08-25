<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Online Exam | Online Examination System</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<nav class="landing-navbar">

    <div class="landing-nav-container">

        <a href="index.jsp" class="landing-logo">

            <span class="logo-mark"></span>

            <span>
                Online <span class="logo-highlight">Exam</span>
            </span>

        </a>


        <div class="landing-nav-links">

            <a href="#home" class="active">
                Home
            </a>

            <a href="#features">
                Features
            </a>

            <a href="#students">
                For Students
            </a>

            <a href="#administrators">
                For Administrators
            </a>

        </div>


        <div class="landing-nav-actions">

            <a href="login.jsp"
               class="nav-login student-nav">

                Student Login

            </a>

            <a href="admin/login.jsp"
               class="nav-login admin-nav">

                Admin Login

            </a>

            <button
                id="themeToggle"
                class="theme-toggle"
                type="button"
                onclick="toggleTheme()"
                title="Toggle theme">

                <span id="themeIcon">☾</span>

            </button>

        </div>

    </div>

</nav>


<main>


<section class="landing-hero"
         id="home">

    <div class="hero-glow hero-glow-one"></div>

    <div class="hero-glow hero-glow-two"></div>


    <div class="landing-container">

        <div class="hero-grid">


            <div class="hero-content">

                <div class="hero-badge">

                    <span class="badge-dot"></span>

                    Online Examination Platform

                </div>


                <h1>

                    Test Your Knowledge.

                    <span>
                        Track Your Progress.
                    </span>

                </h1>


                <p class="hero-description">

                    Take secure online examinations, receive
                    instant results, and monitor your academic
                    performance from one simple platform.

                </p>


                <div class="hero-actions">

                    <a href="register.jsp"
                       class="landing-btn primary-btn">

                        Get Started

                        <span>→</span>

                    </a>


                    <a href="login.jsp"
                       class="landing-btn secondary-btn">

                        Student Login

                    </a>


                    <a href="admin/login.jsp"
                       class="landing-btn admin-btn">

                        Admin Portal

                    </a>

                </div>


                <div class="hero-highlights">

                    <div class="hero-highlight">

                        <span class="highlight-icon secure-icon">
                            ✓
                        </span>

                        <span>
                            Secure
                        </span>

                    </div>


                    <div class="hero-highlight">

                        <span class="highlight-icon instant-icon">
                            ⚡
                        </span>

                        <span>
                            Instant Results
                        </span>

                    </div>


                    <div class="hero-highlight">

                        <span class="highlight-icon performance-icon">
                            ↗
                        </span>

                        <span>
                            Performance Tracking
                        </span>

                    </div>

                </div>

            </div>


            <div class="hero-visual">

                <div class="visual-glow"></div>


                <div class="laptop">

                    <div class="laptop-screen">

                        <div class="screen-top">

                            <span></span>
                            <span></span>
                            <span></span>

                        </div>


                        <div class="screen-content">

                            <div class="screen-title">
                                Online Examination
                            </div>


                            <div class="screen-question">
                                Which language is used
                                for Java web development?
                            </div>


                            <div class="screen-option selected">
                                <span>A</span>
                                Java
                                <b>✓</b>
                            </div>


                            <div class="screen-option">
                                <span>B</span>
                                Python
                            </div>


                            <div class="screen-option">
                                <span>C</span>
                                C++
                            </div>


                            <div class="screen-option">
                                <span>D</span>
                                JavaScript
                            </div>

                        </div>

                    </div>


                    <div class="laptop-base">

                        <div class="laptop-keyboard"></div>

                        <div class="laptop-trackpad"></div>

                    </div>

                </div>


                <div class="floating-card floating-result">

                    <span class="floating-icon success">
                        ✓
                    </span>

                    <div>

                        <small>
                            Latest Result
                        </small>

                        <strong>
                            85%
                        </strong>

                    </div>

                </div>


                <div class="floating-card floating-progress">

                    <span class="floating-icon chart">
                        ↗
                    </span>

                    <div>

                        <small>
                            Progress
                        </small>

                        <strong>
                            +24%
                        </strong>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<section class="features-section"
         id="features">

    <div class="landing-container">


        <div class="section-heading">

            <div class="section-line"></div>

            <h2>
                Everything you need for online examinations
            </h2>

            <p>
                A simple experience for students and powerful
                management tools for administrators.
            </p>

        </div>


        <div class="feature-grid">


            <div class="feature-card">

                <div class="feature-icon blue">
                    MCQ
                </div>

                <h3>
                    MCQ Examinations
                </h3>

                <p>
                    Attempt randomized multiple-choice
                    examinations with a smooth and secure
                    experience.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon green">
                    ✓
                </div>

                <h3>
                    Instant Results
                </h3>

                <p>
                    Get your examination result immediately
                    after submitting your answers.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon purple">
                    S
                </div>

                <h3>
                    Secure Platform
                </h3>

                <p>
                    Role-based access keeps student and
                    administrator functionality separated.
                </p>

            </div>


            <div class="feature-card">

                <div class="feature-icon orange">
                    ↗
                </div>

                <h3>
                    Performance Tracking
                </h3>

                <p>
                    Track previous attempts, scores,
                    percentages and pass or fail results.
                </p>

            </div>

        </div>

    </div>

</section>


<section class="role-section"
         id="students">

    <div class="landing-container">

        <div class="role-card student-role">


            <div class="role-illustration">

                <div class="person student-person">

                    <div class="person-head"></div>

                    <div class="person-body"></div>

                </div>


                <div class="mini-laptop"></div>

            </div>


            <div class="role-content">

                <div class="role-label">
                    STUDENT PORTAL
                </div>

                <h2>
                    Built for students.
                </h2>

                <p>
                    Attempt randomized MCQ examinations,
                    manage your answers, receive your result
                    instantly, and track your performance history.
                </p>


                <div class="role-features">

                    <span>
                        ✓ Randomized Questions
                    </span>

                    <span>
                        ✓ Timed Examination
                    </span>

                    <span>
                        ✓ Instant Results
                    </span>

                    <span>
                        ✓ Performance History
                    </span>

                </div>


                <a href="register.jsp"
                   class="landing-btn primary-btn">

                    Create Student Account

                    <span>→</span>

                </a>

            </div>

        </div>

    </div>

</section>


<section class="role-section admin-role-section"
         id="administrators">

    <div class="landing-container">

        <div class="role-card admin-role">


            <div class="role-content">

                <div class="role-label">
                    ADMIN PORTAL
                </div>

                <h2>
                    Powerful tools for administrators.
                </h2>

                <p>
                    Create, edit and delete examination
                    questions, import questions from XML,
                    and maintain the complete question bank.
                </p>


                <div class="role-features">

                    <span>
                        ✓ Question Management
                    </span>

                    <span>
                        ✓ XML Question Import
                    </span>

                    <span>
                        ✓ Edit & Delete
                    </span>

                    <span>
                        ✓ Question Bank
                    </span>

                </div>


                <a href="admin/login.jsp"
                   class="landing-btn admin-btn">

                    Open Admin Portal

                    <span>→</span>

                </a>

            </div>


            <div class="role-illustration admin-illustration">

                <div class="admin-circle">

                    <div class="person admin-person">

                        <div class="person-head"></div>

                        <div class="person-body"></div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</section>


<section class="performance-section">

    <div class="landing-container">

        <div class="performance-content">

            <div class="performance-icon">
                ↗
            </div>

            <h2>
                Track. Analyze. Improve.
            </h2>

            <p>
                Review your previous attempts, scores,
                percentages and pass or fail results from
                your personal performance dashboard.
            </p>


            <a href="login.jsp"
               class="landing-btn secondary-btn">

                View Dashboard

                <span>→</span>

            </a>

        </div>

    </div>

</section>


<section class="cta-section">

    <div class="landing-container">

        <div class="cta-card">

            <div>

                <span class="cta-label">
                    READY TO BEGIN?
                </span>

                <h2>
                    Your next examination starts here.
                </h2>

                <p>
                    Create your student account and start
                    testing your knowledge today.
                </p>

            </div>


            <a href="register.jsp"
               class="landing-btn primary-btn">

                Get Started

                <span>→</span>

            </a>

        </div>

    </div>

</section>


</main>


<footer class="landing-footer">

    <div class="landing-container">

        <div class="footer-content">

            <div class="footer-brand">

                <div class="landing-logo">

                    <span class="logo-mark"></span>

                    <span>
                        Online <span class="logo-highlight">
                            Exam
                        </span>
                    </span>

                </div>

                <p>
                    A modern online examination platform
                    for students and administrators.
                </p>

            </div>


            <div class="footer-links">

                <a href="index.jsp">
                    Home
                </a>

                <a href="login.jsp">
                    Student Login
                </a>

                <a href="register.jsp">
                    Register
                </a>

                <a href="admin/login.jsp">
                    Admin Login
                </a>

            </div>

        </div>


        <div class="footer-bottom">

            <span>
                Online Examination System
            </span>

            <span>
                All rights reserved.
            </span>

        </div>

    </div>

</footer>


<script>

    function applyTheme() {

        const savedTheme =
            localStorage.getItem("exam-theme");

        const theme =
            savedTheme || "dark";

        document.documentElement
            .setAttribute("data-theme", theme);

        const icon =
            document.getElementById("themeIcon");

        if (icon) {

            icon.textContent =
                theme === "dark" ? "☀" : "☾";

        }

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
            .setAttribute("data-theme", newTheme);

        localStorage.setItem(
            "exam-theme",
            newTheme
        );

        const icon =
            document.getElementById("themeIcon");

        if (icon) {

            icon.textContent =
                newTheme === "dark" ? "☀" : "☾";

        }

    }


    applyTheme();

</script>

</body>

</html>