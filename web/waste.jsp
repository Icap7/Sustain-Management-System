<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Waste" %>
<!DOCTYPE html>
<html>
<head>
    <title>Waste Management System</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2 class="text-center text-primary">Waste Management System</h2>

        <!-- Waste Entry Form -->
        <form action="WasteServlet" method="post">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label>Waste Type:</label>
                <input type="text" name="type" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Quantity (kg):</label>
                <input type="number" name="quantity" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Disposal Method:</label>
                <select name="disposalMethod" class="form-control">
                    <option value="Recycling">Recycling</option>
                    <option value="Composting">Composting</option>
                    <option value="Incineration">Incineration</option>
                    <option value="Landfill">Landfill</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>

        <h2 class="mt-4">Waste Records</h2>

        <!-- Waste Records Table -->
        <%
            List<Waste> wasteList = (List<Waste>) request.getAttribute("wasteList");
            if (wasteList == null) {
                wasteList = new ArrayList<Waste>(); // Prevents NullPointerException
            }

            if (!wasteList.isEmpty()) {
        %>
        <table class="table">
            <tr>
                <th>Type</th>
                <th>Quantity (kg)</th>
                <th>Disposal Method</th>
                <th>Action</th>
            </tr>
            <% for (Waste waste : wasteList) { %>
            <tr>
                <td><%= waste.getType() %></td>
                <td><%= waste.getQuantity() %></td>
                <td><%= waste.getDisposalMethod() %></td>
                <td>
                    <form action="WasteServlet" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= waste.getId() %>">
                        <button type="submit" class="btn btn-delete">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        <% } else { %>
            <p>No waste records available.</p>
        <% } %>
    </div>
</body>
</html>
