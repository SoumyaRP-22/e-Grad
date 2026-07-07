<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.egrad.models.User" %>
<%@ page import="com.egrad.models.Result" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    List<Result> myResults = (List<Result>) request.getAttribute("myResults");
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy - hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Results - e-GRAD</title>
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
        .page-title { font-size: 1.8rem; font-weight: 800; margin-bottom: 30px; color: #ffffff; }

        .table-container { background: #18181b; border: 1px solid #27272a; border-radius: 12px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: #09090b; color: #a1a1aa; font-weight: 600; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; padding: 18px 25px; border-bottom: 1px solid #27272a; }
        td { padding: 18px 25px; border-bottom: 1px solid #27272a; color: #e4e4e7; font-size: 0.95rem; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background-color: #27272a; }

        .badge { padding: 6px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 700; display: inline-block; }
        .badge-pass { background: rgba(16, 185, 129, 0.1); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.2); }
        .badge-fail { background: rgba(239, 68, 68, 0.1); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.2); }
        
        .score-highlight { font-weight: 800; color: #ffffff; }
    </style>
</head>
<body>

    <jsp:include page="../components/navbar.jsp" />

    <div class="dashboard-container">
        
        <aside class="sidebar">
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/views/dashboard.jsp" class="sidebar-link">🏠 My Dashboard</a></li>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/views/profile.jsp" class="sidebar-link">👤 My Profile</a></li>
                
                <div class="nav-header">LEARN</div>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/ExamListServlet" class="sidebar-link">📝 e-Exam</a></li>
                
                <div class="nav-header">DISCUSS</div>
                <li class="sidebar-item"><a href="#" onclick="alert('Community Forum is currently unavailable'); return false;" class="sidebar-link">💬 Forum</a></li>
                
                <div class="nav-header">PROGRESS</div>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/ResultListServlet" class="sidebar-link active">📊 Results</a></li>
                <li class="sidebar-item"><a href="#" onclick="alert('Leaderboard is currently unavailable'); return false;" class="sidebar-link">🏆 Leaderboard</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <h1 class="page-title">Exam History</h1>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Assessment Name</th>
                            <th>Date Taken</th>
                            <th>Score</th>
                            <th>Percentage</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (myResults != null && !myResults.isEmpty()) {
                                for (Result r : myResults) { 
                                    boolean passed = r.getPercentage() >= 50.0;
                        %>
                            <tr>
                                <td style="font-weight: 600;"><%= r.getExamTitle() %></td>
                                <td style="color: #a1a1aa;"><%= sdf.format(r.getTakenAt()) %></td>
                                <td><span class="score-highlight"><%= r.getScore() %></span> / <%= r.getTotalQuestions() %></td>
                                <td><%= String.format("%.0f", r.getPercentage()) %>%</td>
                                <td>
                                    <span class="badge <%= passed ? "badge-pass" : "badge-fail" %>">
                                        <%= passed ? "PASSED" : "FAILED" %>
                                    </span>
                                </td>
                            </tr>
                        <% 
                                }
                            } else { 
                        %>
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 40px; color: #a1a1aa;">
                                    You haven't taken any exams yet. Go to <a href="<%= request.getContextPath() %>/ExamListServlet" style="color: #06b6d4; text-decoration: none;">e-Exam</a> to get started!
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
    
    <jsp:include page="../components/footer.jsp" />

</body>
</html>