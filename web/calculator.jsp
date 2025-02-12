<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%
    // Retrieve the result values from request attributes
    String carbonFootprint = request.getAttribute("carbonFootprint") != null ? request.getAttribute("carbonFootprint").toString() : "";
    String cost = request.getAttribute("cost") != null ? request.getAttribute("cost").toString() : "";
    DecimalFormat df = new DecimalFormat("#.##");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Carbon Footprint Calculator</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="d-flex flex-column min-vh-100">

        <!-- Main Content -->
        <div class="container mt-5 flex-grow-1">
            <header class="text-center mb-4">
                <h1>Carbon Footprint Calculator</h1>
            </header>

            <form action="CalculateServlet" method="post" class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">Electricity Usage (kWh per month):</label>
                    <input type="number" name="electricity" class="form-control" required>
                    <input type="number" name="renewables_electricity" class="form-control mt-2" placeholder="% Renewables">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Natural Gas (kWh per month):</label>
                    <input type="number" name="natural_gas" class="form-control">
                    <input type="number" name="renewables_natural_gas" class="form-control mt-2" placeholder="% Renewables">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Biomass (kg per month):</label>
                    <input type="number" name="biomass" class="form-control">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Coal (kg per month):</label>
                    <input type="number" name="coal" class="form-control">
                </div>
                <div class="col-md-6">
                    <label class="form-label">Heating Oil (litres per month):</label>
                    <input type="number" name="heating_oil" class="form-control">
                </div>
                <div class="col-md-6">
                    <label class="form-label">LPG (kg per month):</label>
                    <input type="number" name="lpg" class="form-control">
                </div>
                <div class="col-12 text-center">
                    <button type="submit" class="btn btn-primary">Calculate</button>
                    <button type="reset" class="btn btn-secondary">Reset</button>
                    <a href="index.jsp" class="btn btn-outline-success">Back to Home</a>
                </div>
            </form>

            <% if (!carbonFootprint.isEmpty() && !cost.isEmpty()) {%>
            <div class="mt-4 p-4 bg-light text-center rounded">
                <h2>Your Carbon Footprint</h2>
                <p><strong><%= df.format(Double.parseDouble(carbonFootprint))%></strong> tCO₂</p>
                <p><strong>RM<%= df.format(Double.parseDouble(cost))%></strong></p>
            </div>
            <% }%>
        </div>

        <!-- Footer -->
        <footer class="bg-dark text-white text-center py-3 mt-auto">
            <div class="container">
                <p class="mb-0">© 2024 Sustainability Management System. All rights reserved.</p>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
