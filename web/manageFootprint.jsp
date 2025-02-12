<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.FootprintData" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);
    Integer userId = (sessionUser != null) ? (Integer) sessionUser.getAttribute("id") : null;
    String role = (sessionUser != null) ? (String) sessionUser.getAttribute("role") : null;

    if (userId == null || !"admin".equals(role)) {
        response.sendRedirect("index.jsp"); // Redirect non-admin users
        return;
    }

    List<FootprintData> footprintList = (List<FootprintData>) request.getAttribute("footprintList");
    if (footprintList == null) {
        footprintList = new java.util.ArrayList<FootprintData>();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Carbon Footprint</title>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- SweetAlert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <style>
            .main-content {
                margin-left: 250px; /* Adjust for sidebar width */
                padding: 20px;
                width: calc(100% - 250px);
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <%@ include file="sidebar.jsp" %>

            <div class="main-content">
                <header class="page-header">
                    <h1>Manage Carbon Footprint</h1>
                    <p>Admin can view and manage carbon footprint records.</p>
                </header>

                <!-- Carbon Footprint Table -->
                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Biomass (kg)</th>
                            <th>Carbon Footprint (tCO₂)</th>
                            <th>Coal (kg)</th>
                            <th>Cost (RM)</th>
                            <th>Electricity (kWh)</th>
                            <th>Heating Oil (L)</th>
                            <th>LPG (kg)</th>
                            <th>Natural Gas (kWh)</th>
                            <th>Renewables (Electricity %)</th>
                            <th>Renewables (Gas %)</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (FootprintData data : footprintList) {%>
                        <tr>
                            <td><%= data.getId()%></td>
                            <td><%= data.getName()%></td>
                            <td><%= data.getBiomass()%></td>
                            <td><%= data.getCarbonFootprint()%></td>
                            <td><%= data.getCoal()%></td>
                            <td><%= data.getCost()%></td>
                            <td><%= data.getElectricity()%></td>
                            <td><%= data.getHeatingOil()%></td>
                            <td><%= data.getLpg()%></td>
                            <td><%= data.getNaturalGas()%></td>
                            <td><%= data.getRenewablesElectricity()%></td>
                            <td><%= data.getRenewablesNaturalGas()%></td>
                            <td>
                                <a href="DeleteFootprintServlet?id=<%= data.getId()%>" class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure you want to delete this record?');">
                                    Delete
                                </a>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Bootstrap 5 JS (with Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
