<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - e-GRAD</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800;900&display=swap" rel="stylesheet">
    <script src="assets/js/validation.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="dark-theme">
    
	<jsp:include page="/components/navbar.jsp" />

    <div class="container">
        <div class="form-card">
            <h2>Welcome Back</h2>
            
            <% if(request.getAttribute("errorMessage") != null) { %>
                <div class="alert error"><%= request.getAttribute("errorMessage") %></div>
            <% } %>
            
            <% if(request.getAttribute("successMessage") != null) { %>
                <div class="alert success"><%= request.getAttribute("successMessage") %></div>
            <% } %>

            <form action="AuthServlet" method="POST" onsubmit="return validateAuthForm()">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <input type="email" id="email" name="email" placeholder="Email" required>
                </div>
                
                <div class="form-group" style="position: relative;">
                    <input type="password" id="password" name="password" placeholder="Password" required style="width: 100%; padding-right: 45px; box-sizing: border-box;" class="form-input">
                    <i class="fa-regular fa-eye" onclick="togglePassword('password', this)" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #a1a1aa; transition: 0.2s;" onmouseover="this.style.color='#06b6d4'" onmouseout="this.style.color='#a1a1aa'" title="Show Password"></i>
                </div>
                
                <button type="submit" class="btn-submit">Sign In</button>
            </form>
            
            <p style="text-align: center; margin-top: 25px; font-size: 0.9rem; color: #a1a1aa;">
                Don't have an account? <a href="register.jsp" style="color: #06b6d4; text-decoration: none; font-weight: 600;">Get Started</a>
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