<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null ||
            !"STUDENT".equals(session.getAttribute("role"))) {

        response.sendRedirect("login.jsp");
        return;
    }

    if (session.getAttribute("exam") == null) {
        response.sendRedirect("student/dashboard.jsp");
        return;
    }

    Long examStartTime =
            (Long) session.getAttribute("examStartTime");

    if (examStartTime == null) {
        response.sendRedirect("student/dashboard.jsp");
        return;
    }

    long examDuration = 10 * 60 * 1000;

    long elapsedTime =
            System.currentTimeMillis() - examStartTime;

    long remainingMillis =
            examDuration - elapsedTime;

    if (remainingMillis <= 0) {
        response.sendRedirect("exam/result");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Online Examination</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        .exam-page {
            min-height: calc(100vh - 70px);
            padding: 30px 20px 60px;
        }

        .exam-wrapper {
            max-width: 1000px;
            margin: 0 auto;
        }

        .exam-topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 25px;
            padding: 22px 25px;
            margin-bottom: 20px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            box-shadow: var(--shadow);
        }

        .exam-title h1 {
            margin: 0 0 6px;
            font-size: 24px;
            color: var(--text-primary);
        }

        .exam-title p {
            margin: 0;
            color: var(--text-secondary);
            font-size: 14px;
        }

        .timer-area {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .timer-label {
            color: var(--text-secondary);
            font-size: 13px;
            font-weight: 600;
        }

        .timer {
            min-width: 90px;
            padding: 10px 15px;
            border-radius: 12px;
            background: var(--primary);
            color: white;
            text-align: center;
            font-size: 20px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .timer.warning {
            background: #f59e0b;
        }

        .timer.danger {
            background: #dc2626;
            animation: timerPulse 1s infinite;
        }

        .question-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 35px;
            box-shadow: var(--shadow);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .question-number {
            color: var(--text-primary);
            font-size: 18px;
            font-weight: 700;
        }

        .question-counter {
            color: var(--text-secondary);
            font-size: 14px;
        }

        .progress-container {
            width: 100%;
            height: 8px;
            margin-bottom: 30px;
            background: var(--progress-bg);
            border-radius: 20px;
            overflow: hidden;
        }

        .progress-bar {
            height: 100%;
            width: 0%;
            background: linear-gradient(
                90deg,
                var(--primary),
                var(--primary-light)
            );
            transition: width 0.4s ease;
        }

        .question-timer-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding: 12px 15px;
            border-radius: 10px;
            background: var(--input-bg);
            border: 1px solid var(--border-color);
        }

        .question-timer-label {
            color: var(--text-secondary);
            font-size: 14px;
            font-weight: 600;
        }

        .question-timer {
            color: var(--primary);
            font-size: 18px;
            font-weight: 800;
        }

        .question-timer.warning {
            color: #f59e0b;
        }

        .question-timer.danger {
            color: #dc2626;
            animation: timerPulse 1s infinite;
        }

        .question-text {
            margin-bottom: 30px;
            color: var(--text-primary);
            font-size: 25px;
            line-height: 1.55;
            font-weight: 700;
        }

        .options {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .answer-option {
            position: relative;
        }

        .answer-option input {
            position: absolute;
            opacity: 0;
        }

        .answer-label {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 17px 19px;
            background: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 13px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .answer-label:hover {
            transform: translateX(4px);
            border-color: var(--primary);
        }

        .answer-option input:checked + .answer-label {
            border-color: var(--primary);
            background: var(--selected-bg);
            box-shadow:
                0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        .option-letter {
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            border-radius: 50%;
            background: var(--option-bg);
            color: var(--text-primary);
            font-weight: 800;
        }

        .answer-option input:checked + .answer-label .option-letter {
            background: var(--primary);
            color: white;
        }

        .option-text {
            color: var(--text-primary);
            font-size: 15px;
        }

        .exam-actions {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid var(--border-color);
        }

        .navigation-left,
        .navigation-right {
            display: flex;
            gap: 10px;
        }

        .nav-button {
            min-width: 145px;
        }

        .loading {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-secondary);
        }

        .loading-spinner {
            width: 42px;
            height: 42px;
            margin: 0 auto 18px;
            border: 4px solid var(--progress-bg);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        .theme-toggle {
            width: 42px;
            height: 42px;
            border: 1px solid var(--border-color);
            border-radius: 50%;
            background: var(--card-bg);
            color: var(--text-primary);
            cursor: pointer;
            font-size: 18px;
        }

        .theme-toggle:hover {
            transform: scale(1.05);
        }

        @keyframes spin {

            to {
                transform: rotate(360deg);
            }

        }

        @keyframes timerPulse {

            0% {
                transform: scale(1);
            }

            50% {
                transform: scale(1.05);
            }

            100% {
                transform: scale(1);
            }

        }

        @media (max-width: 768px) {

            .exam-page {
                padding: 20px 12px 40px;
            }

            .exam-topbar {
                flex-direction: column;
                align-items: stretch;
            }

            .timer-area {
                justify-content: space-between;
            }

            .question-card {
                padding: 24px 18px;
            }

            .question-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 7px;
            }

            .question-text {
                font-size: 20px;
            }

            .exam-actions {
                flex-direction: column;
            }

            .navigation-left,
            .navigation-right {
                width: 100%;
            }

            .nav-button {
                width: 100%;
            }

        }

    </style>

</head>

<body>

<nav class="navbar">

    <a href="#" class="logo">
        Online Exam
    </a>

    <div class="nav-links">

        <span class="exam-status">
            Examination in Progress
        </span>

        <button
            id="themeToggle"
            class="theme-toggle"
            type="button">

            ☾

        </button>

    </div>

</nav>


<div class="exam-page">

    <div class="exam-wrapper">

        <div class="exam-topbar">

            <div class="exam-title">

                <h1>
                    Online Examination
                </h1>

                <p>
                    Select the correct answer for each question.
                </p>

            </div>

            <div class="timer-area">

                <span class="timer-label">
                    Overall Time
                </span>

                <span
                    id="timer"
                    class="timer">

                    10:00

                </span>

            </div>

        </div>


        <div class="question-card">

            <div class="question-header">

                <div
                    id="questionNumber"
                    class="question-number">

                    Loading question...

                </div>

                <div
                    id="questionCounter"
                    class="question-counter">

                </div>

            </div>


            <div class="progress-container">

                <div
                    id="progressBar"
                    class="progress-bar">
                </div>

            </div>


            <div
                id="loadingMessage"
                class="loading">

                <div class="loading-spinner"></div>

                <p>
                    Loading question...
                </p>

            </div>


            <div
                id="questionContent"
                style="display:none;">


                <div class="question-timer-box">

                    <span class="question-timer-label">
                        Time for this question
                    </span>

                    <span
                        id="questionTimer"
                        class="question-timer">

                        30s

                    </span>

                </div>


                <div
                    id="questionText"
                    class="question-text">
                </div>


                <form id="answerForm">

                    <input
                        type="hidden"
                        id="questionId"
                        name="questionId">


                    <div class="options">


                        <div class="answer-option">

                            <input
                                type="radio"
                                id="answerA"
                                name="answer"
                                value="A">

                            <label
                                for="answerA"
                                class="answer-label">

                                <span class="option-letter">
                                    A
                                </span>

                                <span
                                    id="optionA"
                                    class="option-text">
                                </span>

                            </label>

                        </div>


                        <div class="answer-option">

                            <input
                                type="radio"
                                id="answerB"
                                name="answer"
                                value="B">

                            <label
                                for="answerB"
                                class="answer-label">

                                <span class="option-letter">
                                    B
                                </span>

                                <span
                                    id="optionB"
                                    class="option-text">
                                </span>

                            </label>

                        </div>


                        <div class="answer-option">

                            <input
                                type="radio"
                                id="answerC"
                                name="answer"
                                value="C">

                            <label
                                for="answerC"
                                class="answer-label">

                                <span class="option-letter">
                                    C
                                </span>

                                <span
                                    id="optionC"
                                    class="option-text">
                                </span>

                            </label>

                        </div>


                        <div class="answer-option">

                            <input
                                type="radio"
                                id="answerD"
                                name="answer"
                                value="D">

                            <label
                                for="answerD"
                                class="answer-label">

                                <span class="option-letter">
                                    D
                                </span>

                                <span
                                    id="optionD"
                                    class="option-text">
                                </span>

                            </label>

                        </div>

                    </div>


                    <div class="exam-actions">

                        <div class="navigation-left">

                            <button
                                type="button"
                                id="previousButton"
                                class="btn btn-outline nav-button">

                                ← Previous

                            </button>

                        </div>


                        <div class="navigation-right">

                            <button
                                type="submit"
                                id="nextButton"
                                class="btn btn-primary nav-button">

                                Next Question →

                            </button>

                        </div>

                    </div>

                </form>

            </div>

        </div>

    </div>

</div>


<form
    id="timeoutForm"
    action="exam/timeout"
    method="post">
</form>


<input
    type="hidden"
    id="remainingTime"
    value="<%= remainingMillis %>">


<input
    type="hidden"
    id="contextPath"
    value="<%= request.getContextPath() %>">


<script>

    const contextPath =
        document.getElementById("contextPath").value;

    let timeLeft =
        Number(
            document.getElementById("remainingTime").value
        );

    let questionTimeLeft = 30;

    let questionTimerInterval = null;

    let submitting = false;

    let overallTimeoutSubmitted = false;


    function updateOverallTimer() {

        const totalSeconds =
            Math.max(
                0,
                Math.floor(timeLeft / 1000)
            );

        const minutes =
            Math.floor(totalSeconds / 60);

        const seconds =
            totalSeconds % 60;


        const timer =
            document.getElementById("timer");


        timer.innerHTML =
            String(minutes).padStart(2, "0") +
            ":" +
            String(seconds).padStart(2, "0");


        timer.classList.remove(
            "warning",
            "danger"
        );


        if (totalSeconds <= 60) {

            timer.classList.add("danger");

        } else if (totalSeconds <= 180) {

            timer.classList.add("warning");

        }


        if (timeLeft <= 0) {

            timer.innerHTML = "00:00";


            if (!overallTimeoutSubmitted) {

                overallTimeoutSubmitted = true;

                document.getElementById(
                    "timeoutForm"
                ).submit();

            }

            return;
        }


        timeLeft -= 1000;

        setTimeout(
            updateOverallTimer,
            1000
        );

    }


    function startQuestionTimer() {

        clearInterval(
            questionTimerInterval
        );


        questionTimeLeft = 30;


        const timer =
            document.getElementById(
                "questionTimer"
            );


        timer.innerHTML = "30s";

        timer.classList.remove(
            "warning",
            "danger"
        );


        questionTimerInterval =
            setInterval(
                function() {

                    questionTimeLeft--;


                    timer.innerHTML =
                        questionTimeLeft + "s";


                    timer.classList.remove(
                        "warning",
                        "danger"
                    );


                    if (questionTimeLeft <= 10) {

                        timer.classList.add(
                            "danger"
                        );

                    } else if (
                        questionTimeLeft <= 15
                    ) {

                        timer.classList.add(
                            "warning"
                        );

                    }


                    if (questionTimeLeft <= 0) {

                        clearInterval(
                            questionTimerInterval
                        );


                        autoNextQuestion();

                    }

                },
                1000
            );

    }


    function loadQuestion() {

        const loadingMessage =
            document.getElementById(
                "loadingMessage"
            );

        const questionContent =
            document.getElementById(
                "questionContent"
            );

        const nextButton =
            document.getElementById(
                "nextButton"
            );

        const previousButton =
            document.getElementById(
                "previousButton"
            );


        clearInterval(
            questionTimerInterval
        );


        loadingMessage.style.display =
            "block";

        questionContent.style.display =
            "none";

        nextButton.disabled = true;

        previousButton.disabled = true;


        fetch(
            contextPath + "/exam/question"
        )

        .then(response => {

            if (!response.ok) {

                throw new Error(
                    "Failed to load question"
                );

            }

            return response.json();

        })

        .then(question => {

            document.getElementById(
                "questionNumber"
            ).innerHTML =
                "Question " +
                question.current;


            document.getElementById(
                "questionCounter"
            ).innerHTML =
                "of " +
                question.total;


            document.getElementById(
                "questionText"
            ).innerHTML =
                question.questionText;


            document.getElementById(
                "optionA"
            ).innerHTML =
                question.optionA;


            document.getElementById(
                "optionB"
            ).innerHTML =
                question.optionB;


            document.getElementById(
                "optionC"
            ).innerHTML =
                question.optionC;


            document.getElementById(
                "optionD"
            ).innerHTML =
                question.optionD;


            document.getElementById(
                "questionId"
            ).value =
                question.id;


            document.getElementById(
                "answerForm"
            ).reset();


            if (question.selectedAnswer) {

                const selected =
                    document.querySelector(
                        'input[name="answer"][value="' +
                        question.selectedAnswer +
                        '"]'
                    );


                if (selected) {
                    selected.checked = true;
                }

            }


            const progress =
                (question.current /
                 question.total) * 100;


            document.getElementById(
                "progressBar"
            ).style.width =
                Math.min(
                    progress,
                    100
                ) + "%";


            if (question.current === 1) {

                previousButton.disabled = true;

            } else {

                previousButton.disabled = false;

            }


            if (
                question.current ===
                question.total
            ) {

                nextButton.innerHTML =
                    "Submit Exam ✓";

            } else {

                nextButton.innerHTML =
                    "Next Question →";

            }


            loadingMessage.style.display =
                "none";

            questionContent.style.display =
                "block";


            nextButton.disabled = false;


            startQuestionTimer();

        })

        .catch(error => {

            console.error(error);


            loadingMessage.innerHTML =
                "<p>Unable to load question.</p>" +
                "<p>Please refresh the page and try again.</p>";


            loadingMessage.style.display =
                "block";


            questionContent.style.display =
                "none";


            nextButton.disabled =
                false;


            previousButton.disabled =
                false;


            nextButton.innerHTML =
                "Try Again →";

        });

    }


    function saveCurrentAnswer(callback) {

        const questionId =
            document.getElementById(
                "questionId"
            ).value;


        const selectedAnswer =
            document.querySelector(
                'input[name="answer"]:checked'
            );


        const formData =
            new URLSearchParams();


        formData.append(
            "questionId",
            questionId
        );


        if (selectedAnswer) {

            formData.append(
                "answer",
                selectedAnswer.value
            );

        }


        fetch(
            contextPath + "/exam/answer",
            {
                method: "POST",

                headers: {
                    "Content-Type":
                        "application/x-www-form-urlencoded"
                },

                body: formData
            }
        )

        .then(response => {

            if (!response.ok) {

                throw new Error(
                    "Failed to save answer"
                );

            }

            return response.json();

        })

        .then(result => {

            callback(
                result
            );

        })

        .catch(error => {

            console.error(error);

            submitting = false;

            document.getElementById(
                "nextButton"
            ).disabled = false;

            alert(
                "Unable to save answer. Please try again."
            );

        });

    }


    function autoNextQuestion() {

        if (submitting) {
            return;
        }


        submitting = true;


        const nextButton =
            document.getElementById(
                "nextButton"
            );


        nextButton.disabled = true;

        nextButton.innerHTML =
            "Time expired...";


        saveCurrentAnswer(
            function(result) {

                submitting = false;


                if (result.completed) {

                    window.location.href =
                        contextPath +
                        "/exam/result";

                    return;

                }


                loadQuestion();

            }
        );

    }


    document.getElementById(
        "answerForm"
    ).addEventListener(
        "submit",
        function(event) {

            event.preventDefault();


            if (submitting) {
                return;
            }


            submitting = true;


            clearInterval(
                questionTimerInterval
            );


            const nextButton =
                document.getElementById(
                    "nextButton"
                );


            nextButton.disabled = true;

            nextButton.innerHTML =
                "Saving...";


            saveCurrentAnswer(
                function(result) {

                    submitting = false;


                    if (result.completed) {

                        window.location.href =
                            contextPath +
                            "/exam/result";

                        return;

                    }


                    loadQuestion();

                }
            );

        }
    );


    document.getElementById(
        "previousButton"
    ).addEventListener(
        "click",
        function() {

            if (submitting) {
                return;
            }


            const currentQuestionText =
                document.getElementById(
                    "questionNumber"
                ).innerText;


            const currentNumber =
                parseInt(
                    currentQuestionText
                        .replace(
                            "Question ",
                            ""
                        )
                );


            if (
                isNaN(currentNumber) ||
                currentNumber <= 1
            ) {

                return;

            }


            submitting = true;


            clearInterval(
                questionTimerInterval
            );


            const previousButton =
                document.getElementById(
                    "previousButton"
                );


            const nextButton =
                document.getElementById(
                    "nextButton"
                );


            previousButton.disabled =
                true;


            nextButton.disabled =
                true;


            fetch(
                contextPath +
                "/exam/previous",
                {
                    method: "POST"
                }
            )

            .then(response => {

                if (!response.ok) {

                    throw new Error(
                        "Unable to load previous question"
                    );

                }

                return response.json();

            })

            .then(() => {

                submitting = false;

                loadQuestion();

            })

            .catch(error => {

                console.error(error);

                submitting = false;

                previousButton.disabled =
                    false;

                nextButton.disabled =
                    false;

                alert(
                    "Unable to load previous question."
                );

            });

        }
    );


    function initializeTheme() {

        const savedTheme =
            localStorage.getItem(
                "theme"
            );


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
                .getAttribute(
                    "data-theme"
                );


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


        const theme =
            document.documentElement
                .getAttribute(
                    "data-theme"
                );


        if (theme === "dark") {

            button.innerHTML =
                "☀";

        } else {

            button.innerHTML =
                "☾";

        }

    }


    document.getElementById(
        "themeToggle"
    ).addEventListener(
        "click",
        toggleTheme
    );


    initializeTheme();

    updateOverallTimer();

    loadQuestion();

</script>


</body>

</html>