<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="model.Users" %>

<%
    // Check if admin is logged in
    String adminUser = (String) session.getAttribute("user");
    if (adminUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve user ID from request
    String userId = request.getParameter("id");
    if (userId == null || userId.isEmpty()) {
        response.sendRedirect("manageUsers.jsp");
        return;
    }

    // Database connection details
    String url = "jdbc:derby://localhost:1527/WasteManagement";
    String dbUser = "app";
    String dbPassword = "app";

    String name = "", email = "", role = "";
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load Derby JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish connection
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        stmt = conn.prepareStatement("SELECT NAME, EMAIL, ROLE FROM USERS WHERE ID = ?");
        stmt.setInt(1, Integer.parseInt(userId));
        rs = stmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("NAME");
            email = rs.getString("EMAIL");
            role = rs.getString("ROLE");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit User</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

        <style>
            body {
                background: linear-gradient(135deg, #6e8efb, #a777e3);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .card {
                max-width: 500px;
                width: 100%;
                padding: 20px;
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                background: white;
            }
            .card h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
            .form-control {
                border-radius: 10px;
            }
            .btn {
                width: 100%;
                border-radius: 10px;
            }
            .btn-primary {
                background-color: #6e8efb;
                border: none;
            }
            .btn-secondary {
                background-color: #ccc;
                border: none;
            }
            .input-group-text {
                background-color: #f0f0f0;
                border-radius: 10px;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <h2><i class="fas fa-user-edit"></i> Edit User</h2>
            <form action="EditUserServlet" method="post">
                <input type="hidden" name="id" value="<%= userId%>">

                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" name="name" value="<%= name%>" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" name="email" value="<%= email%>" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">New Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" name="password" placeholder="Leave blank to keep current password">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user-tag"></i></span>
                        <select class="form-control" name="role">
                            <option value="admin" <%= role.equals("admin") ? "selected" : ""%>>Admin</option>
                            <option value="user" <%= role.equals("user") ? "selected" : ""%>>User</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update User</button>
                <a href="adminDashboard.jsp" class="btn btn-secondary mt-2"><i class="fas fa-times"></i> Cancel</a>
            </form>
        </div>
    </body>
</html>
