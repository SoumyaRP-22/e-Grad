<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.egrad.models.User" %>
<%
    User navUser = (User) session.getAttribute("loggedUser");
    String basePath = request.getContextPath(); 
%>

<nav class="navbar">
    <div class="logo">
        <% if (navUser != null) { %>
            <a href="<%= basePath %>/views/dashboard.jsp">e-<span>GRAD</span></a>
        <% } else { %>
            <a href="<%= basePath %>/index.jsp">e-<span>GRAD</span></a>
        <% } %>
    </div>
    
    <ul class="nav-links">
        <% if (navUser != null) { %>
            
            <li style="margin-right: 20px;">
                <a href="<%= basePath %>/views/profile.jsp" style="display: flex; align-items: center; gap: 10px; color: #ffffff; text-decoration: none; font-weight: 500; transition: 0.3s;">
                    <div style="width: 35px; height: 35px; border-radius: 50%; background: #27272a; display: flex; align-items: center; justify-content: center; color: #06b6d4; font-size: 1.1rem; font-weight: 800; border: 2px solid #06b6d4;">
                        <%= navUser.getName().substring(0, 1).toUpperCase() %>
                    </div>
                    <%= navUser.getName() %>
                </a>
            </li>
            
            <li>
                <a href="<%= basePath %>/AuthServlet?action=logout" class="btn-logout">Logout</a>
            </li>
        <% } else { %>
            <li><a href="<%= basePath %>/login.jsp" style="color: #ffffff; text-decoration: none; margin-right: 15px;">Sign In</a></li>
            <li>
                <a href="<%= basePath %>/register.jsp" class="btn-submit" style="padding: 8px 16px; text-decoration: none;">Register</a>
            </li>
        <% } %>
    </ul>
</nav>