<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Carbon Footprint Calculator</title>
    <link rel="stylesheet" href="calcStyle.css">
</head>
<body>

    <!-- Navigation Menu -->
    <nav class="menu">
        <button onclick="location.href='calculator.jsp'">Carbon Footprint Calculator</button>
        <button onclick="location.href='#'">Real-Time Tracker</button>
        <button onclick="location.href='#'">Resource Management Tool</button>
    </nav>

    <header class="page-header">
        <h1>Carbon Footprint Calculator</h1>
    </header>

    <main class="calculator-container">
        <form action="CalculateServlet" method="post">
            <div class="form-group">
                <label>Electricity Usage (kWh per month):</label>
                <input type="number" name="electricity" required>
                <input type="number" name="renewables_electricity" placeholder="% Renewables">
            </div>
            <div class="form-group">
                <label>Natural Gas (kWh per month):</label>
                <input type="number" name="natural_gas">
                <input type="number" name="renewables_natural_gas" placeholder="% Renewables">
            </div>
            <div class="form-group">
                <label>Biomass (kg per month):</label>
                <input type="number" name="biomass">
            </div>
            <div class="form-group">
                <label>Coal (kg per month):</label>
                <input type="number" name="coal">
            </div>
            <div class="form-group">
                <label>Heating Oil (litres per month):</label>
                <input type="number" name="heating_oil">
            </div>
            <div class="form-group">
                <label>LPG (kg per month):</label>
                <input type="number" name="lpg">
            </div>  

            <div class="button-group">
                <button type="submit" id="calculate-button">Calculate</button><br>
                <button type="reset" id="reset-button">Reset</button>
            </div>
        </form>

        <!-- Display Result If Available -->
        <% if (!carbonFootprint.isEmpty() && !cost.isEmpty()) { %>
            <div class="result-section">
                <h2>Your Carbon Footprint</h2>
                <p><strong><%= df.format(Double.parseDouble(carbonFootprint)) %></strong> tCO₂</p>
                <p><strong>£<%= df.format(Double.parseDouble(cost)) %></strong></p>
            </div>
        <% } %>

    </main>

</body>
</html>
