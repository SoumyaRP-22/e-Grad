<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>e-GRAD | Smart Learning Platform</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        html, body {
            height: 100vh;
            width: 100vw;
            overflow: hidden;
            background-color: #09090b; 
            color: #ffffff; 
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            flex-shrink: 0;
        }
        .logo { font-size: 1.5rem; font-weight: 900; color: #ffffff; letter-spacing: -0.5px; text-decoration: none;}
        .logo span { color: #06b6d4; }
        .nav-links { display: flex; align-items: center; gap: 30px; }
        .nav-link { color: #ffffff; text-decoration: none; font-weight: 600; font-size: 0.95rem; transition: 0.2s; }
        .nav-link:hover { color: #06b6d4; }
        .btn-register { background-color: #06b6d4; color: #000; padding: 10px 24px; border-radius: 8px; font-weight: 700; text-decoration: none; transition: 0.2s; }
        .btn-register:hover { background-color: #0891b2; }

        .hero-section {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 0 20px;
        }

        .badge { background-color: rgba(6, 182, 212, 0.1); border: 1px solid rgba(6, 182, 212, 0.2); color: #06b6d4; padding: 8px 16px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; margin-bottom: 30px; display: inline-flex; align-items: center; gap: 8px; }
        
        .hero-title { font-size: 5rem; font-weight: 900; line-height: 1.1; margin-bottom: 25px; letter-spacing: -2px; }
        .hero-title span { color: #06b6d4; }
        
        .hero-subtitle { font-size: 1.1rem; color: #a1a1aa; max-width: 600px; line-height: 1.6; margin-bottom: 40px; }

        .hero-buttons { display: flex; gap: 20px; justify-content: center; }
        .btn-primary { background-color: #06b6d4; color: #000; padding: 14px 32px; border-radius: 8px; font-size: 1rem; font-weight: 700; text-decoration: none; transition: 0.2s; }
        .btn-primary:hover { background-color: #0891b2; transform: translateY(-2px); }
        .btn-secondary { background-color: transparent; color: #ffffff; padding: 14px 32px; border-radius: 8px; border: 1px solid #27272a; font-size: 1rem; font-weight: 600; text-decoration: none; transition: 0.2s; }
        .btn-secondary:hover { border-color: #52525b; background-color: #18181b; }

        .footer {
            padding: 20px;
            text-align: center;
            font-size: 0.85rem;
            color: #71717a;
            flex-shrink: 0;        }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="#" class="logo">e-<span>GRAD</span></a>
        <div class="nav-links">
            <a href="login.jsp" class="nav-link">Sign In</a>
            <a href="register.jsp" class="btn-register">Register</a>
        </div>
    </nav>

    <main class="hero-section">
        <div class="badge">
            🎓 Smart Learning Platform
        </div>
        
        <h1 class="hero-title">
            Learn<br>Smarter.<br>Grow <span>Faster.</span>
        </h1>
        
        <p class="hero-subtitle">
            e-GRAD brings together your profile, community forums, and<br>adaptive exams in one unified academic platform.
        </p>
        
        <div class="hero-buttons">
            <a href="login.jsp" class="btn-primary">Start Learning &rarr;</a>
            <a href="#" class="btn-secondary">See Features</a>
        </div>
    </main>

    <footer class="footer">
        &copy; 2026 e-GRAD Smart Learning Platform. All Rights Reserved.
    </footer>

</body>
</html>