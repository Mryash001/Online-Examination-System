<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Student Registration | Online Exam</title>

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

            background: var(--primary);

            opacity: 0.08;

            filter: blur(2px);
        }

        .auth-page::after {
            content: "";

            position: absolute;

            width: 300px;
            height: 300px;

            right: -110px;
            bottom: -110px;

            border-radius: 50%;

            background: var(--primary);

            opacity: 0.07;
        }

        .auth-card {
            width: 100%;
            max-width: 480px;

            position: relative;

            z-index: 2;

            padding: 38px;

            background: var(--card-bg);

            border:
                1px solid
                var(--border-color);

            border-radius: 22px;

            box-shadow: var(--shadow);

            animation:
                authCardEnter 0.55s ease;

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

            background:
                var(--primary-light);

            color:
                var(--primary);

            font-size: 27px;

            box-shadow:
                0 8px 22px
                rgba(37, 99, 235, 0.14);

            animation:
                iconFloat 3s ease-in-out infinite;
        }

        .auth-card h1 {
            margin: 0;

            text-align: center;

            color:
                var(--text-primary);

            font-size: 29px;
        }

        .auth-card .subtitle {
            margin:
                10px 0 28px;

            text-align: center;

            color:
                var(--text-secondary);

            font-size: 14px;

            line-height: 1.6;
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

            color:
                var(--text-secondary);

            cursor: pointer;

            border-radius: 8px;

            transition:
                background 0.2s ease,
                color 0.2s ease;
        }

        .password-toggle:hover {
            background:
                var(--hover-bg);

            color:
                var(--primary);
        }

        .password-strength {
            margin-top: 8px;

            height: 5px;

            background:
                var(--border-color);

            border-radius: 10px;

            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;

            width: 0;

            border-radius: 10px;

            transition:
                width 0.3s ease,
                background 0.3s ease;
        }

        .password-hint {
            display: block;

            margin-top: 7px;

            color:
                var(--text-muted);

            font-size: 12px;
        }

        .password-match {
            display: block;

            margin-top: 7px;

            font-size: 12px;

            min-height: 16px;
        }

        .match-success {
            color: #16a34a;
        }

        .match-error {
            color: #dc2626;
        }

        .form-button {
            width: 100%;

            margin-top: 8px;

            padding-top: 13px;
            padding-bottom: 13px;

            font-size: 15px;

            font-weight: 700;
        }

        .auth-divider {
            display: flex;

            align-items: center;

            gap: 12px;

            margin: 25px 0;

            color:
                var(--text-muted);

            font-size: 12px;
        }

        .auth-divider::before,
        .auth-divider::after {
            content: "";

            flex: 1;

            height: 1px;

            background:
                var(--border-color);
        }

        .auth-links {
            display: flex;

            flex-direction: column;

            align-items: center;

            gap: 12px;

            text-align: center;
        }

        .auth-links a {
            color:
                var(--primary);

            text-decoration: none;

            font-size: 14px;
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

            background:
                var(--hover-bg);
        }

        .admin-login-link:hover {
            text-decoration: none !important;
        }

        .auth-footer-note {
            margin-top: 25px;

            padding-top: 20px;

            border-top:
                1px solid
                var(--border-color);

            text-align: center;

            color:
                var(--text-muted);

            font-size: 12px;

            line-height: 1.5;
        }

        .alert {
            animation:
                alertEnter 0.35s ease;
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


        <a href="login.jsp">

            Student Login

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
            Create Your Account
        </h1>


        <p class="subtitle">

            Register as a student and start
            taking online examinations.

        </p>



        <%
            if ("empty".equals(error)) {
        %>

            <div class="alert alert-error">

                Please fill in all fields.

            </div>

        <%
            } else if ("password".equals(error)) {
        %>

            <div class="alert alert-error">

                Passwords do not match.

            </div>

        <%
            } else if ("exists".equals(error)) {
        %>

            <div class="alert alert-error">

                An account with this email
                already exists.

            </div>

        <%
            } else if ("failed".equals(error)) {
        %>

            <div class="alert alert-error">

                Registration failed.
                Please try again.

            </div>

        <%
            }
        %>



        <form action="register"
              method="post"
              id="registerForm">


            <div class="form-group">

                <label for="name">
                    Full Name
                </label>

                <input
                    type="text"
                    id="name"
                    name="name"
                    class="form-control"
                    placeholder="Enter your full name"
                    autocomplete="name"
                    required>

            </div>



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
                        placeholder="Create a password"
                        autocomplete="new-password"
                        required>


                    <button
                        type="button"
                        class="password-toggle"
                        id="passwordToggle"
                        title="Show password">

                        ◉

                    </button>

                </div>


                <div class="password-strength">

                    <div
                        id="passwordStrength"
                        class="password-strength-bar">
                    </div>

                </div>


                <span class="password-hint">

                    Use at least 6 characters.

                </span>

            </div>



            <div class="form-group">

                <label for="confirmPassword">

                    Confirm Password

                </label>


                <div class="password-wrapper">

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        class="form-control"
                        placeholder="Confirm your password"
                        autocomplete="new-password"
                        required>


                    <button
                        type="button"
                        class="password-toggle"
                        id="confirmPasswordToggle"
                        title="Show password">

                        ◉

                    </button>

                </div>


                <span
                    id="passwordMatch"
                    class="password-match">
                </span>

            </div>



            <button
                type="submit"
                class="btn btn-primary form-button">

                Create Account →

            </button>


        </form>



        <div class="auth-divider">

            OR

        </div>



        <div class="auth-links">


            <span>

                Already have an account?

                <a href="login.jsp">

                    Login here

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

            Your student account gives you access to
            examinations, results and performance history.

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


        button.innerHTML =
            theme === "dark"
                ? "☀"
                : "☾";


        button.title =
            theme === "dark"
                ? "Switch to light theme"
                : "Switch to dark theme";

    }



    document.getElementById("themeToggle")
        .addEventListener(
            "click",
            toggleTheme
        );



    function setupPasswordToggle(
        inputId,
        buttonId
    ) {

        const input =
            document.getElementById(
                inputId
            );

        const button =
            document.getElementById(
                buttonId
            );


        button.addEventListener(
            "click",
            function() {

                if (
                    input.type ===
                    "password"
                ) {

                    input.type =
                        "text";

                    button.title =
                        "Hide password";

                } else {

                    input.type =
                        "password";

                    button.title =
                        "Show password";

                }

            }
        );

    }



    setupPasswordToggle(
        "password",
        "passwordToggle"
    );


    setupPasswordToggle(
        "confirmPassword",
        "confirmPasswordToggle"
    );



    const password =
        document.getElementById(
            "password"
        );

    const strengthBar =
        document.getElementById(
            "passwordStrength"
        );



    password.addEventListener(
        "input",
        function() {

            const value =
                password.value;

            let strength = 0;


            if (value.length >= 6) {
                strength++;
            }

            if (value.length >= 10) {
                strength++;
            }

            if (/[A-Z]/.test(value)) {
                strength++;
            }

            if (/[0-9]/.test(value)) {
                strength++;
            }

            if (/[^A-Za-z0-9]/.test(value)) {
                strength++;
            }


            const widths = [
                "0%",
                "20%",
                "40%",
                "60%",
                "80%",
                "100%"
            ];


            strengthBar.style.width =
                widths[strength];


            if (strength <= 1) {

                strengthBar.style.background =
                    "#dc2626";

            } else if (strength <= 3) {

                strengthBar.style.background =
                    "#f59e0b";

            } else {

                strengthBar.style.background =
                    "#16a34a";

            }

            checkPasswordMatch();

        }
    );



    const confirmPassword =
        document.getElementById(
            "confirmPassword"
        );

    const passwordMatch =
        document.getElementById(
            "passwordMatch"
        );



    confirmPassword.addEventListener(
        "input",
        checkPasswordMatch
    );



    function checkPasswordMatch() {

        if (
            confirmPassword.value === ""
        ) {

            passwordMatch.innerHTML =
                "";

            passwordMatch.className =
                "password-match";

            return;

        }


        if (
            password.value ===
            confirmPassword.value
        ) {

            passwordMatch.innerHTML =
                "✓ Passwords match";

            passwordMatch.className =
                "password-match match-success";

        } else {

            passwordMatch.innerHTML =
                "✕ Passwords do not match";

            passwordMatch.className =
                "password-match match-error";

        }

    }



    document.getElementById(
        "registerForm"
    ).addEventListener(
        "submit",
        function(event) {

            if (
                password.value !==
                confirmPassword.value
            ) {

                event.preventDefault();

                passwordMatch.innerHTML =
                    "✕ Passwords do not match";

                passwordMatch.className =
                    "password-match match-error";

                confirmPassword.focus();

            }

        }
    );



    initializeTheme();

</script>


</body>

</html>