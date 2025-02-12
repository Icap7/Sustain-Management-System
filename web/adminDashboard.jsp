<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>

<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || !"admin".equals(sessionUser.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Retrieve summary data from request attributes (provided by AdminDashboardServlet)
    Map<String, Integer> summaryData = (Map<String, Integer>) request.getAttribute("summaryData");
    int totalUsers = (summaryData != null) ? summaryData.getOrDefault("totalUsers", 0) : 0;
    int totalGuides = (summaryData != null) ? summaryData.getOrDefault("totalGuides", 0) : 0;
    int totalWasteRecords = (summaryData != null) ? summaryData.getOrDefault("totalWasteRecords", 0) : 0;
    int totalCarbonFootprints = (summaryData != null) ? summaryData.getOrDefault("totalCarbonFootprints", 0) : 0;
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <style>
            body {
                background-color: #f4f6f9;
            }
            .sidebar {
                width: 250px;
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                background-color: #343a40;
                padding-top: 20px;
            }
            .sidebar a {
                color: white;
                padding: 10px;
                display: block;
                text-decoration: none;
                font-size: 18px;
            }
            .sidebar a:hover {
                background-color: #495057;
            }
            .main-content {
                margin-left: 250px;
                padding: 40px 30px;
            }
            .dashboard-card {
                border-radius: 12px;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .dashboard-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .dashboard-card .card-body {
                text-align: center;
                padding: 35px;
            }
            .dashboard-card .display-6 {
                font-weight: 700;
            }
            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }
                .main-content {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-dark bg-dark d-md-none">
            <div class="container-fluid">
                <button class="btn btn-outline-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar">
                    <i class="bi bi-list"></i> Menu
                </button>
            </div>
        </nav>

            <%@ include file="sidebar.jsp" %>


        <!-- Sidebar (Mobile) -->
        <div class="offcanvas offcanvas-start bg-dark text-white" tabindex="-1" id="offcanvasSidebar">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title">Admin Menu</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body">
                <%@ include file="sidebar.jsp" %>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h2 class="dashboard-title">Admin Dashboard</h2>
            <p class="dashboard-subtitle">Overview of system data and statistics.</p>

            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <a href="getUsersServlet" class="dashboard-card text-white bg-primary shadow-sm rounded d-block">
                        <div class="card-body">
                            <i class="bi bi-people display-6"></i>
                            <h5 class="card-title">Total Users</h5>
                            <p class="display-6"><%= totalUsers%></p>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3">
                    <a href="WasteGuideServlet" class="dashboard-card text-white bg-success shadow-sm rounded d-block">
                        <div class="card-body">
                            <i class="bi bi-book display-6"></i>
                            <h5 class="card-title">Waste Guides</h5>
                            <p class="display-6"><%= totalGuides%></p>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3">
                    <a href="WasteRecordsServlet" class="dashboard-card text-white bg-warning shadow-sm rounded d-block">
                        <div class="card-body">
                            <i class="bi bi-recycle display-6"></i>
                            <h5 class="card-title">Waste Records</h5>
                            <p class="display-6"><%= totalWasteRecords%></p>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-3">
                    <a href="ManageFootprintServlet" class="dashboard-card text-white bg-danger shadow-sm rounded d-block">
                        <div class="card-body">
                            <i class="bi bi-cloud display-6"></i>
                            <h5 class="card-title">Carbon Footprint Entries</h5>
                            <p class="display-6"><%= totalCarbonFootprints%></p>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
