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

    <title>Admin Login</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<nav class="navbar">

    <a href="../index.jsp" class="logo">
        Online Exam
    </a>

    <div class="nav-links">

        <a href="../index.jsp">
            Home
        </a>

        <a href="../login.jsp">
            Student Login
        </a>

        <button
            id="themeToggle"
            class="theme-toggle"
            onclick="toggleTheme()"
            type="button"
            title="Toggle theme">

            <span id="themeIcon">☾</span>

        </button>

    </div>

</nav>


<div class="auth-container">

    <div class="auth-card">

        

        <h1>
            Admin Login
        </h1>

        <p class="subtitle">
            Access the examination administration panel.
        </p>


        <%
            if ("invalid".equals(error)) {
        %>

        <div class="alert alert-error">

            Invalid administrator credentials.

        </div>

        <%
            } else if ("empty".equals(error)) {
        %>

        <div class="alert alert-error">

            Please enter your email and password.

        </div>

        <%
            } else if ("notadmin".equals(error)) {
        %>

        <div class="alert alert-error">

            This account is not an administrator account.

            <br>

            Please use the Student Login portal.

        </div>

        <%
            }
        %>


        <form action="../login"
              method="post">

            <input
                type="hidden"
                name="expectedRole"
                value="ADMIN">


            <div class="form-group">

                <label for="email">
                    Administrator Email
                </label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    class="form-control"
                    placeholder="Enter administrator email"
                    autocomplete="email"
                    required>

            </div>


            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <input
                    type="password"
                    id="password"
                    name="password"
                    class="form-control"
                    placeholder="Enter your password"
                    autocomplete="current-password"
                    required>

            </div>


            <button
                type="submit"
                class="btn btn-dark form-button">

                Admin Login

            </button>

        </form>



        <p class="text-center mt-20">

            Are you a student?

            <a href="../login.jsp">
                Student Login
            </a>

        </p>


        <p class="text-center mt-20">

            <a href="../index.jsp">
                ← Back to Home
            </a>

        </p>

    </div>

</div>


<footer class="footer">

    Online Examination System

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
                theme === "dark"
                    ? "☀"
                    : "☾";

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
                newTheme === "dark"
                    ? "☀"
                    : "☾";

        }

    }


    applyTheme();

</script>

</body>

</html>