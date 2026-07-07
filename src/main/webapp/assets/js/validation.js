function validateAuthForm() {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    if (!passwordRegex.test(password)) {
        alert("Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.");
        return false;
    }

    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return false;
    }

    return true;
}

function validateProfileForm() {
    const mobileInput = document.querySelector('input[name="mobile"]').value;

    const mobileRegex = /^\d{10}$/;

    if (mobileInput.trim() !== "" && !mobileRegex.test(mobileInput)) {
        alert("Please enter a valid 10-digit mobile number without any spaces or country codes.");
        return false;
    }

    return true;
}