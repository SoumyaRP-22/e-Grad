<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.egrad.models.User" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    Integer score = (Integer) request.getAttribute("score");
    Integer total = (Integer) request.getAttribute("totalQuestions");
    Integer wrong = (Integer) request.getAttribute("wrong");
    Integer unattempted = (Integer) request.getAttribute("unattempted");
    String timeUsed = (String) request.getAttribute("timeUsed");
    String examTitle = (String) request.getAttribute("examTitle");
    
    if (score == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    int percentage = (int) Math.round(((double) score / total) * 100);
    String message = percentage >= 80 ? "Excellent Work!" : (percentage >= 50 ? "Good Job!" : "Keep Practicing!");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Results - e-GRAD</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800;900&display=swap" rel="stylesheet">
    <style>
        body { background-color: #09090b; color: #ffffff; font-family: 'Inter', sans-serif; display: flex; flex-direction: column; min-height: 100vh; margin: 0; }
        
        .result-wrapper { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center; padding: 40px; }
        
        .circle-progress { width: 180px; height: 180px; border-radius: 50%; background: conic-gradient(#ffffff <%= percentage %>%, #18181b 0); display: flex; align-items: center; justify-content: center; margin-bottom: 30px; box-shadow: 0 0 30px rgba(0,0,0,0.5); }
        .circle-inner { width: 150px; height: 150px; background: #09090b; border-radius: 50%; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .circle-score { font-size: 2.5rem; font-weight: 900; color: #ffffff; letter-spacing: -1px; }
        .circle-label { font-size: 0.8rem; color: #71717a; text-transform: uppercase; letter-spacing: 2px; margin-top: 5px; }
        .result-msg { font-size: 2.5rem; font-weight: 900; margin-bottom: 10px; }
        .result-sub { color: #a1a1aa; font-size: 1rem; margin-bottom: 50px; }

        .stats-container { display: flex; gap: 20px; margin-bottom: 50px; flex-wrap: wrap; justify-content: center; }
        .stat-box { background: #18181b; border: 1px solid #27272a; border-radius: 12px; padding: 20px 40px; display: flex; flex-direction: column; min-width: 120px; }
        .stat-num { font-size: 2rem; font-weight: 900; margin-bottom: 5px; }
        .stat-label { color: #71717a; font-size: 0.85rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; }

        .txt-correct { color: #10b981; }
        .txt-wrong { color: #ef4444; }
        .txt-unattempted { color: #a1a1aa; }
        .txt-time { color: #f59e0b; }

        .btn-group { display: flex; gap: 20px; }
        .btn-primary { background: #3b82f6; color: #ffffff; padding: 12px 30px; border-radius: 8px; text-decoration: none; font-weight: 600; transition: 0.2s; border: none; font-size: 1rem; }
        .btn-primary:hover { background: #2563eb; }
        .btn-secondary { background: transparent; color: #a1a1aa; padding: 12px 30px; border-radius: 8px; text-decoration: none; font-weight: 600; transition: 0.2s; border: 1px solid #3f3f46; }
        .btn-secondary:hover { background: #27272a; color: #ffffff; }
    </style>
</head>
<body>

    <jsp:include page="../components/navbar.jsp" />

    <div class="result-wrapper">
        
        <div class="circle-progress">
            <div class="circle-inner">
                <div class="circle-score"><%= percentage %>%</div>
                <div class="circle-label">Score</div>
            </div>
        </div>

        <h1 class="result-msg"><%= message %></h1>
        <p class="result-sub">You completed the <%= examTitle %> exam.</p>

        <div class="stats-container">
            <div class="stat-box">
                <div class="stat-num txt-correct"><%= score %></div>
                <div class="stat-label">Correct</div>
            </div>
            <div class="stat-box">
                <div class="stat-num txt-wrong"><%= wrong %></div>
                <div class="stat-label">Wrong</div>
            </div>
            <div class="stat-box">
                <div class="stat-num txt-unattempted"><%= unattempted %></div>
                <div class="stat-label">Skipped</div>
            </div>
            <div class="stat-box">
                <div class="stat-num txt-time"><%= timeUsed %></div>
                <div class="stat-label">Time Used</div>
            </div>
        </div>

        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/ExamListServlet" class="btn-primary">Try Another Exam</a>
            <a href="<%= request.getContextPath() %>/views/dashboard.jsp" class="btn-secondary">Go to Dashboard</a>
        </div>

    </div>
    

</body>
</html>