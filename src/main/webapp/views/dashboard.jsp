<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.egrad.models.User" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - e-GRAD</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; padding: 0; background-color: #09090b; color: #ffffff; font-family: 'Inter', sans-serif; overflow-x: hidden; }

        .dashboard-container { display: flex; min-height: calc(100vh - 70px); }

        .sidebar { width: 260px; background-color: #18181b; border-right: 1px solid #27272a; padding: 20px 0; flex-shrink: 0; }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar-item { padding: 0 20px; margin-bottom: 5px; }
        .sidebar-link { display: flex; align-items: center; gap: 12px; padding: 12px 15px; text-decoration: none; color: #a1a1aa; border-radius: 8px; font-weight: 500; transition: 0.2s; }
        .sidebar-link:hover { background-color: #27272a; color: #ffffff; }
        .sidebar-link.active { background-color: rgba(6, 182, 212, 0.1); color: #06b6d4; border: 1px solid rgba(6, 182, 212, 0.2); }
        .nav-header { font-size: 0.75rem; color: #71717a; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin: 25px 20px 10px 20px; }

        .main-content { flex: 1; padding: 40px 50px; background-color: #09090b; }
        
        .greeting-header { margin-bottom: 30px; }
        .greeting-title { font-size: 1.8rem; font-weight: 700; color: #ffffff; margin: 0 0 5px 0; }
        .greeting-subtitle { color: #a1a1aa; font-size: 0.95rem; margin: 0; }

        .stats-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card { background-color: #18181b; border: 1px solid #27272a; border-radius: 12px; padding: 30px 20px; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; transition: 0.3s; }
        .stat-card:hover { border-color: #3f3f46; transform: translateY(-2px); }
        
        .icon-circle { width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.4rem; margin-bottom: 15px; }
        .icon-blue { background-color: rgba(6, 182, 212, 0.1); color: #06b6d4; }
        .icon-green { background-color: rgba(16, 185, 129, 0.1); color: #10b981; }
        .icon-purple { background-color: rgba(168, 85, 247, 0.1); color: #a855f7; }
        .icon-orange { background-color: rgba(249, 115, 22, 0.1); color: #f97316; }

        .stat-name { font-size: 0.95rem; font-weight: 600; color: #ffffff; margin-bottom: 15px; }
        
        .stat-line { width: 30px; height: 4px; border-radius: 2px; margin-bottom: 15px; }
        .line-blue { background-color: #06b6d4; }
        .line-green { background-color: #10b981; }
        .line-purple { background-color: #a855f7; }
        .line-orange { background-color: #f97316; }

        .stat-status { font-size: 0.85rem; color: #a1a1aa; font-weight: 500; }

        .action-panels { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .panel-card { background-color: #18181b; border: 1px solid #27272a; border-radius: 12px; padding: 25px; }
        .panel-header { display: flex; align-items: center; gap: 10px; font-size: 1.1rem; font-weight: 600; color: #ffffff; margin-bottom: 30px; }
        
        .empty-state { display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 30px 0; }
        .empty-icon { font-size: 4rem; margin-bottom: 15px; opacity: 0.9; }
        .empty-title { font-size: 1.15rem; font-weight: 600; color: #ffffff; margin: 0 0 10px 0; }
        .empty-desc { font-size: 0.9rem; color: #a1a1aa; margin: 0 0 25px 0; max-width: 280px; line-height: 1.5; }

        .btn-solid { background-color: #06b6d4; color: #000000; padding: 10px 24px; border-radius: 6px; font-weight: 700; font-size: 0.9rem; font-family: 'Inter'; cursor: pointer; transition: 0.2s; text-decoration: none; border: none; display: inline-block; }
        .btn-solid:hover { background-color: #0891b2; }
    </style>
</head>
<body>

    <jsp:include page="../components/navbar.jsp" />

    <div class="dashboard-container">
        
        <aside class="sidebar">
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/views/dashboard.jsp" class="sidebar-link active">🏠 My Dashboard</a></li>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/views/profile.jsp" class="sidebar-link">👤 My Profile</a></li>
                
                <div class="nav-header">LEARN</div>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/ExamListServlet" class="sidebar-link">📝 e-Exam</a></li>
                
                <div class="nav-header">DISCUSS</div>
                <li class="sidebar-item"><a href="#" onclick="alert('The community forum is currently unavailable'); return false;" class="sidebar-link">💬 Forum</a></li>
                
                <div class="nav-header">PROGRESS</div>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/ResultListServlet" class="sidebar-link">📊 Results</a></li>
                <li class="sidebar-item"><a href="#" onclick="alert('Leaderboard is currently unavailable'); return false;" class="sidebar-link">🏆 Leaderboard</a></li>
            </ul>
        </aside>

        <main class="main-content">
            
            <div class="greeting-header">
                <h1 class="greeting-title">Hi <%= currentUser.getName().toUpperCase() %>! 👋</h1>
                <p class="greeting-subtitle">Welcome to E-Grad.</p>
            </div>

            <div class="stats-row">
                <div class="stat-card">
                    <div class="icon-circle icon-blue">📖</div>
                    <div class="stat-name">Exams Taken</div>
                    <div class="stat-line line-blue"></div>
                    <div class="stat-status">No data yet</div>
                </div>

                <div class="stat-card">
                    <div class="icon-circle icon-green">✓</div>
                    <div class="stat-name">Average Score</div>
                    <div class="stat-line line-green"></div>
                    <div class="stat-status">No data yet</div>
                </div>

                <div class="stat-card">
                    <div class="icon-circle icon-purple">⏱️</div>
                    <div class="stat-name">Total Study Time</div>
                    <div class="stat-line line-purple"></div>
                    <div class="stat-status">No data yet</div>
                </div>

                <div class="stat-card">
                    <div class="icon-circle icon-orange">🔥</div>
                    <div class="stat-name">Current Streak</div>
                    <div class="stat-line line-orange"></div>
                    <div class="stat-status">Start your streak!</div>
                </div>
            </div>

            <div class="action-panels">
                
                <div class="panel-card">
                    <div class="panel-header">
                        📖 Continue Learning
                    </div>
                    <div class="empty-state">
                        <div class="empty-icon">📝</div>
                        <h3 class="empty-title">No subjects in progress</h3>
                        <a href="#" onclick="return false;" class="btn-solid">Browse Subjects &rarr;</a>
                    </div>
                </div>

                <div class="panel-card">
                    <div class="panel-header">
                        📅 Upcoming Exams
                    </div>
                    <div class="empty-state">
                        <div class="empty-icon">🗓️</div>
                        <h3 class="empty-title">No upcoming exams</h3>
                        <a href="<%= request.getContextPath() %>/ExamListServlet" class="btn-solid">Start Exam &rarr;</a>
                    </div>
                </div>

            </div>

        </main>
    </div>
    <jsp:include page="../components/footer.jsp" />

</body>
</html>