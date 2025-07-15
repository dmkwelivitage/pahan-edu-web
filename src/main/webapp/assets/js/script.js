document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    form.addEventListener("submit", function () {
        const username = form.username.value;
        const password = form.password.value;
        if (!username || !password) {
            alert("Please fill in all fields.");
        }
    });
});
