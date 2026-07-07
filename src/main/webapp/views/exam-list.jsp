<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.egrad.models.User" %>
<%@ page import="com.egrad.models.Exam" %>
<%@ page import="java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    List<Exam> examList = (List<Exam>) request.getAttribute("examList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Exams - e-GRAD</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800;900&display=swap" rel="stylesheet">
    <style>
        .exam-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; width: 100%; max-width: 1200px; margin: 0 auto; }
        .exam-card { background: #18181b; padding: 30px; border-radius: 12px; border: 1px solid #27272a; display: flex; flex-direction: column; transition: 0.3s; text-align: left; }
        .exam-card:hover { border-color: #06b6d4; transform: translateY(-5px); box-shadow: 0 10px 30px rgba(6, 182, 212, 0.1); }
        .exam-title { color: #ffffff; font-size: 1.4rem; margin-bottom: 15px; }
        .exam-desc { color: #a1a1aa; font-size: 0.95rem; margin-bottom: 25px; line-height: 1.5; flex-grow: 1; }
        .exam-meta { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #27272a; padding-top: 20px; margin-bottom: 20px; color: #71717a; font-size: 0.85rem; font-weight: 600; }
    </style>
</head>
<body class="dark-theme">

    <jsp:include page="../components/navbar.jsp" />

    <div class="container" style="padding-top: 4rem; padding-bottom: 4rem; text-align: center;">
        
        <h1 style="color: #ffffff; font-size: 2.5rem; margin-bottom: 10px;">Select an Assessment</h1>
        <p style="color: #a1a1aa; margin-bottom: 50px;">Choose a subject below to begin your timed examination.</p>

        <div class="exam-grid">
            <% 
                if (examList != null && !examList.isEmpty()) {
                    for (Exam exam : examList) { 
            %>
                <div class="exam-card">
                    <h2 class="exam-title"><%= exam.getTitle() %></h2>
                    <p class="exam-desc"><%= exam.getDescription() %></p>
                    
                    <div class="exam-meta">
                        <span>⏳ Time: <%= exam.getDurationMinutes() %> Minutes</span>
                    </div>
                    
                    <a href="<%= request.getContextPath() %>/TakeExamServlet?examId=<%= exam.getId() %>" class="btn-submit" style="text-decoration: none; text-align: center; padding: 12px;">Start Exam</a>
                </div>
            <% 
                    }
                } else { 
            %>
                <div style="grid-column: 1 / -1; color: #a1a1aa; padding: 40px; background: #18181b; border-radius: 12px; border: 1px dashed #3f3f46;">
                    No exams are currently available. Please check back later!
                </div>
            <% } %>
        </div>

    </div>

    <jsp:include page="../components/footer.jsp" />

</body>
</html>