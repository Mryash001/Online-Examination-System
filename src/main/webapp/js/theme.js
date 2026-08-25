(function () {

    const savedTheme =
        localStorage.getItem("exam-theme");

    if (savedTheme) {

        document.documentElement
            .setAttribute("data-theme", savedTheme);

    } else {

        const prefersDark =
            window.matchMedia &&
            window.matchMedia(
                "(prefers-color-scheme: dark)"
            ).matches;

        if (prefersDark) {

            document.documentElement
                .setAttribute("data-theme", "dark");

        }

    }

})();


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

    updateThemeButton();

}


function updateThemeButton() {

    const button =
        document.getElementById("themeToggle");

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

}


document.addEventListener(
    "DOMContentLoaded",
    updateThemeButton
);