<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.egrad.models.User" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    String userProgram = (currentUser.getProgram() != null) ? currentUser.getProgram() : "Not Assigned";
    String userSemester = (currentUser.getSemester() != null) ? currentUser.getSemester() : "N/A";
    
    String initials = currentUser.getName().length() >= 2 
                      ? currentUser.getName().substring(0, 2).toUpperCase() 
                      : currentUser.getName().toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - e-GRAD</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script src="<%= request.getContextPath() %>/assets/js/validation.js"></script>
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
        
        ::-webkit-calendar-picker-indicator {
            filter: invert(1);
            cursor: pointer;
        }
        
        .page-header { margin-bottom: 30px; }
        .page-title { font-size: 1.8rem; font-weight: 800; color: #ffffff; margin: 0 0 5px 0; }
        .page-subtitle { color: #a1a1aa; font-size: 0.95rem; margin: 0; }

        .profile-card { background-color: #18181b; border: 1px solid #27272a; border-radius: 12px; padding: 30px; margin-bottom: 30px; }
        
        .user-top-info { display: flex; justify-content: space-between; align-items: center; }
        .user-details-left { display: flex; align-items: center; gap: 25px; }
        
        .avatar { width: 90px; height: 90px; border-radius: 50%; background: linear-gradient(135deg, #6366f1, #a855f7); display: flex; align-items: center; justify-content: center; font-size: 2.2rem; font-weight: 900; color: #ffffff; letter-spacing: 1px; box-shadow: 0 8px 20px rgba(99, 102, 241, 0.2); }
        
        .user-name { font-size: 1.5rem; font-weight: 700; color: #ffffff; margin: 0 0 5px 0; }
        .user-email { color: #a1a1aa; font-size: 0.95rem; margin: 0 0 15px 0; }
        
        .badges { display: flex; gap: 10px; }
        .badge { padding: 6px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 700; }
        .badge-program { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .badge-semester { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .badge-status { background: rgba(168, 85, 247, 0.1); color: #a855f7; }

        .btn-outline { background: transparent; border: 1px solid #3f3f46; color: #a1a1aa; padding: 10px 16px; border-radius: 8px; cursor: pointer; transition: 0.2s; font-family: 'Inter'; font-weight: 600; font-size: 0.9rem; display: flex; align-items: center; gap: 8px;}
        .btn-outline:hover { background: #27272a; color: #ffffff; border-color: #52525b; }

        .card-title { font-size: 1.1rem; font-weight: 600; color: #ffffff; margin: 0 0 25px 0; border-bottom: 1px solid #27272a; padding-bottom: 15px; }
        
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 20px;}
        .form-group { display: flex; flex-direction: column; gap: 8px; }
        .form-label { color: #a1a1aa; font-size: 0.85rem; font-weight: 500; }
        .form-input { background-color: #09090b; border: 1px solid #27272a; border-radius: 8px; padding: 14px 16px; color: #ffffff; font-family: 'Inter'; font-size: 0.95rem; transition: 0.2s; width: 100%; box-sizing: border-box;}
        .form-input:focus { outline: none; border-color: #06b6d4; }
        
        .form-input.readonly { background-color: #111827; color: #71717a; cursor: not-allowed; border-color: #1f2937; }

        .btn-save { background: #06b6d4; color: #000; padding: 12px 24px; border-radius: 8px; border: none; font-weight: 700; cursor: pointer; transition: 0.2s; font-family: 'Inter'; }
        .btn-save:hover { background: #0891b2; }
    </style>
</head>
<body>

    <jsp:include page="../components/navbar.jsp" />

    <div class="dashboard-container">
        
        <aside class="sidebar">
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/views/dashboard.jsp" class="sidebar-link">🏠 My Dashboard</a></li>
                <li class="sidebar-item"><a href="#" class="sidebar-link active">👤 My Profile</a></li>
                
                <div class="nav-header">LEARN</div>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/ExamListServlet" class="sidebar-link">📝 e-Exam</a></li>
                
                <div class="nav-header">DISCUSS</div>
                <li class="sidebar-item"><a href="#" onclick="alert('Community Forum is currently unavailable'); return false;" class="sidebar-link">💬 Forum</a></li>
                
                <div class="nav-header">PROGRESS</div>
                <li class="sidebar-item"><a href="<%= request.getContextPath() %>/ResultListServlet" class="sidebar-link">📊 Results</a></li>
                <li class="sidebar-item"><a href="#" onclick="alert('Leaderboard is currently unavailable'); return false;" class="sidebar-link">🏆 Leaderboard</a></li>
            </ul>
        </aside>

        <main class="main-content">
            
            <div class="page-header">
                <h1 class="page-title">Your Details</h1>
                <p class="page-subtitle">Manage your profile information here.</p>
            </div>

            <div class="profile-card">
                <div class="user-top-info">
                    <div class="user-details-left">
                        <div class="avatar"><%= initials %></div>
                        <div>
                            <h2 class="user-name"><%= currentUser.getName() %></h2>
                            <p class="user-email"><%= currentUser.getEmail() %></p>
                            <div class="badges">
                                <span class="badge badge-program"><%= userProgram %></span>
                                <span class="badge badge-semester"><%= userSemester %></span>
                            </div>
                        </div>
                    </div>
        
                </div>
            </div>

            <div class="profile-card">
                
                <form action="<%= request.getContextPath() %>/UpdateProfileServlet" method="POST" onsubmit="return validateProfileForm()">
                    
                    <h3 class="card-title">Identity Details</h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-input" value="<%= currentUser.getName() %>" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-input readonly" value="<%= currentUser.getEmail() %>" readonly>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Registered Program</label>
                            <input type="text" class="form-input readonly" value="<%= userProgram %>" readonly title="Contact administration to change your program.">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Current Semester</label>
                            <input type="text" class="form-input readonly" value="<%= userSemester %>" readonly title="Semester is updated automatically by the system.">
                        </div>
                    </div>

                    <h3 class="card-title" style="margin-top: 40px;">Personal Information</h3>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Mobile Number</label>
                            <input type="text" name="mobile" class="form-input" placeholder="+91 xxxxxxxxxx" value="<%= currentUser.getMobile() != null ? currentUser.getMobile() : "" %>">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" name="dob" class="form-input" value="<%= currentUser.getDob() != null ? currentUser.getDob() : "" %>">
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Blood Group</label>
                            <select name="bloodGroup" class="form-input">
                                <option value="" disabled <%= (currentUser.getBloodGroup() == null || currentUser.getBloodGroup().isEmpty()) ? "selected" : "" %>>Select Blood Group</option>
                                <option value="A+" <%= "A+".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>A+</option>
                                <option value="A-" <%= "A-".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>A-</option>
                                <option value="B+" <%= "B+".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>B+</option>
                                <option value="B-" <%= "B-".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>B-</option>
                                <option value="O+" <%= "O+".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>O+</option>
                                <option value="O-" <%= "O-".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>O-</option>
                                <option value="AB+" <%= "AB+".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>AB+</option>
                                <option value="AB-" <%= "AB-".equals(currentUser.getBloodGroup()) ? "selected" : "" %>>AB-</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Father's Name</label>
                            <input type="text" name="fathersName" class="form-input" placeholder="Father's Full Name" value="<%= currentUser.getFathersName() != null ? currentUser.getFathersName() : "" %>">
                        </div>
                    </div>

                    <div class="form-group" style="margin-bottom: 25px;">
                        <label class="form-label">Full Address</label>
                        <textarea name="address" class="form-input" rows="3" style="resize: vertical;" placeholder="Enter your complete residential address..."><%= currentUser.getAddress() != null ? currentUser.getAddress() : "" %></textarea>
                    </div>

                    <div style="text-align: right; border-top: 1px solid #27272a; padding-top: 25px;">
                        <button type="submit" class="btn-save">Save Changes</button>
                    </div>
                </form>
            </div>

        </main>
    </div>
    
    <jsp:include page="../components/footer.jsp" />

</body>
</html>