<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - e-GRAD</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800;900&display=swap" rel="stylesheet">
    <script src="assets/js/validation.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="dark-theme">
    
    <jsp:include page="/components/navbar.jsp" />

    <div class="container">
        <div class="form-card" style="max-width: 550px;">
            <h2>Create Account</h2>
            
            <% if(request.getAttribute("errorMessage") != null) { %>
                <div class="alert error"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <form action="AuthServlet" method="POST" onsubmit="return validateAuthForm()">
                <input type="hidden" name="action" value="register">
                
                <div class="form-group">
                    <input type="text" id="name" name="name" placeholder="Full Name" required>
                </div>
                
                <div class="form-group">
                    <input type="email" id="email" name="email" placeholder="Email" required>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 15px;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <select name="program" id="program" required style="width: 100%; padding: 12px; background: #09090b; color: white; border: 1px solid #27272a; border-radius: 8px; font-family: 'Inter';">
                            <option value="" disabled selected>Select Program</option>
                            <option value="B.Tech CSE">B.Tech CSE</option>
                            <option value="B.Tech ECE">B.Tech ECE</option>
                            <option value="B.Tech EEE">B.Tech EEE</option>
                            <option value="B.Tech EIE">B.Tech EIE</option>
                        </select>
                    </div>
                    
                    <div class="form-group" style="margin-bottom: 0;">
                        <select name="semester" id="semester" required style="width: 100%; padding: 12px; background: #09090b; color: white; border: 1px solid #27272a; border-radius: 8px; font-family: 'Inter';">
                            <option value="" disabled selected>Current Semester</option>
                            <option value="Semester 1">Semester 1</option>
                            <option value="Semester 2">Semester 2</option>
                            <option value="Semester 3">Semester 3</option>
                            <option value="Semester 4">Semester 4</option>
                            <option value="Semester 5">Semester 5</option>
                            <option value="Semester 6">Semester 6</option>
                            <option value="Semester 7">Semester 7</option>
                            <option value="Semester 8">Semester 8</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group" style="position: relative;">
                    <input type="password" id="password" name="password" placeholder="Password" required style="width: 100%; padding-right: 45px; box-sizing: border-box;">
                    <i class="fa-regular fa-eye" onclick="togglePassword('password', this)" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #a1a1aa; transition: 0.2s;" onmouseover="this.style.color='#06b6d4'" onmouseout="this.style.color='#a1a1aa'" title="Show Password"></i>
                </div>
                
                <div class="form-group" style="position: relative;">
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required style="width: 100%; padding-right: 45px; box-sizing: border-box;">
                    <i class="fa-regular fa-eye" onclick="togglePassword('confirmPassword', this)" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #a1a1aa; transition: 0.2s;" onmouseover="this.style.color='#06b6d4'" onmouseout="this.style.color='#a1a1aa'" title="Show Password"></i>
                </div>
                
                <div class="form-group">
                    <label for="role" style="color: #a1a1aa; font-size: 0.9rem; margin-bottom: 5px; display: block;">ROLE</label>
                    <select name="role" id="role" style="width: 100%; padding: 12px; background: #09090b; color: white; border: 1px solid #27272a; border-radius: 8px; font-family: 'Inter';">
                        <option value="student">Student</option>
                        <option value="admin">Administrator</option>
                    </select>
                </div>
                
                <button type="submit" class="btn-submit" style="margin-top: 10px;">Join e-GRAD</button>
            </form>
            
            <p style="text-align: center; margin-top: 25px; font-size: 0.9rem; color: #a1a1aa;">
                Already registered? <a href="login.jsp" style="color: #06b6d4; text-decoration: none; font-weight: 600;">Sign in here</a>
            </p>
        </div>
    </div>
    
    <script>
        function togglePassword(inputId, iconElement) {
            const input = document.getElementById(inputId);
            
            if (input.type === 'password') {
                input.type = 'text';
                iconElement.classList.remove('fa-eye');
                iconElement.classList.add('fa-eye-slash');
                iconElement.title = "Hide Password";
            } else {
                input.type = 'password';
                iconElement.classList.remove('fa-eye-slash');
                iconElement.classList.add('fa-eye');
                iconElement.title = "Show Password";
            }
        }
    </script>

    <%@include file="components/footer.jsp" %>
</body>
</html>