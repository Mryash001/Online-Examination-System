<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Student Login | Online Exam</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .auth-page {
            min-height: calc(100vh - 70px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 45px 20px;
            position: relative;
            overflow: hidden;
        }

        .auth-page::before {
            content: "";
            position: absolute;
            width: 320px;
            height: 320px;
            top: -120px;
            left: -100px;
            border-radius: 50%;
            background: var(--primary-light);
            opacity: 0.12;
            filter: blur(2px);
        }

        .auth-page::after {
            content: "";
            position: absolute;
            width: 280px;
            height: 280px;
            right: -100px;
            bottom: -100px;
            border-radius: 50%;
            background: var(--primary);
            opacity: 0.08;
        }

        .auth-card {
            width: 100%;
            max-width: 460px;
            position: relative;
            z-index: 2;
            padding: 38px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 22px;
            box-shadow: var(--shadow);
            animation: authCardEnter 0.55s ease;
            transition:
                background 0.3s ease,
                border-color 0.3s ease,
                box-shadow 0.3s ease;
        }

        .auth-icon {
            width: 62px;
            height: 62px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            border-radius: 18px;
            background: var(--primary-light);
            color: var(--primary);
            font-size: 27px;
            box-shadow:
                0 8px 22px
                rgba(37, 99, 235, 0.14);
            animation: iconFloat 3s ease-in-out infinite;
        }

        .auth-card h1 {
            margin: 0;
            text-align: center;
            color: var(--text-primary);
            font-size: 29px;
        }

        .auth-card .subtitle {
            margin: 10px 0 28px;
            text-align: center;
            color: var(--text-secondary);
            font-size: 14px;
            line-height: 1.6;
        }

        .auth-divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 25px 0;
            color: var(--text-muted);
            font-size: 12px;
        }

        .auth-divider::before,
        .auth-divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: var(--border-color);
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper .form-control {
            padding-right: 50px;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            width: 36px;
            height: 36px;
            border: none;
            background: transparent;
            color: var(--text-secondary);
            cursor: pointer;
            border-radius: 8px;
            transition:
                background 0.2s ease,
                color 0.2s ease;
        }

        .password-toggle:hover {
            background: var(--hover-bg);
            color: var(--primary);
        }

        .form-button {
            width: 100%;
            margin-top: 8px;
            padding-top: 13px;
            padding-bottom: 13px;
            font-size: 15px;
            font-weight: 700;
        }

        .auth-links {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
            text-align: center;
        }

        .auth-links a {
            font-size: 14px;
            color: var(--primary);
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .auth-links a:hover {
            text-decoration: underline;
        }

        .admin-login-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 13px;
            border-radius: 9px;
            background: var(--hover-bg);
        }

        .admin-login-link:hover {
            text-decoration: none !important;
        }

        .auth-footer-note {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            text-align: center;
            color: var(--text-muted);
            font-size: 12px;
        }

        .alert {
            animation: alertEnter 0.35s ease;
        }

        @keyframes authCardEnter {

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

        @keyframes iconFloat {

            0%,
            100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-5px);
            }

        }

        @keyframes alertEnter {

            from {
                opacity: 0;
                transform: translateY(-6px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }

        @media (max-width: 600px) {

            .auth-page {
                padding: 25px 14px;
            }

            .auth-card {
                padding: 30px 22px;
                border-radius: 18px;
            }

            .auth-card h1 {
                font-size: 25px;
            }

        }

    </style>

</head>

<body>

<nav class="navbar">

    <a href="index.jsp"
       class="logo">

        Online Exam

    </a>

    <div class="nav-links">

        <a href="index.jsp">
            Home
        </a>

        <a href="admin/login.jsp">
            Admin Login
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


<main class="auth-page">

    <div class="auth-card">

        <div class="auth-icon">
            🎓
        </div>


        <h1>
            Student Login
        </h1>


        <p class="subtitle">

            Login to access your examinations,
            results and performance history.

        </p>


        <%
            if ("invalid".equals(error)) {
        %>

        <div class="alert alert-error">

            Invalid email or password.

        </div>

        <%
            } else if ("empty".equals(error)) {
        %>

        <div class="alert alert-error">

            Please enter your email and password.

        </div>

        <%
            } else if ("notstudent".equals(error)) {
        %>

        <div class="alert alert-error">

            This is Student Login Potal.

            <br>

            Please use the Admin Login portal.

        </div>

        <%
            } else if ("registered".equals(success)) {
        %>

        <div class="alert alert-success">

            Registration successful.
            Please login to continue.

        </div>

        <%
            }
        %>


        <form action="login"
              method="post">

            <input
                type="hidden"
                name="expectedRole"
                value="STUDENT">


            <div class="form-group">

                <label for="email">
                    Email Address
                </label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    class="form-control"
                    placeholder="Enter your email"
                    autocomplete="email"
                    required>

            </div>


            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <div class="password-wrapper">

                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="form-control"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required>

                    <button
                        type="button"
                        id="passwordToggle"
                        class="password-toggle"
                        title="Show password">

                        ◉

                    </button>

                </div>

            </div>


            <button
                type="submit"
                class="btn btn-primary form-button">

                Login →

            </button>

        </form>


        <div class="auth-divider">
            OR
        </div>


        <div class="auth-links">

            <span>

                Don't have an account?

                <a href="register.jsp">
                    Create Student Account
                </a>

            </span>


            <a
                href="admin/login.jsp"
                class="admin-login-link">

                ⚙ Admin Login →

            </a>


            <a href="index.jsp">

                ← Back to Home

            </a>

        </div>


        <div class="auth-footer-note">

            Your examination account is protected
            by secure authentication.

        </div>

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


    const password =
        document.getElementById("password");


    const passwordToggle =
        document.getElementById(
            "passwordToggle"
        );


    passwordToggle.addEventListener(
        "click",
        function() {

            if (
                password.type ===
                "password"
            ) {

                password.type =
                    "text";

                passwordToggle.innerHTML =
                    "◉";

                passwordToggle.title =
                    "Hide password";

            } else {

                password.type =
                    "password";

                passwordToggle.innerHTML =
                    "◉";

                passwordToggle.title =
                    "Show password";

            }

        }
    );


    initializeTheme();

</script>


</body>

</html>