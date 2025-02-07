<%@page import="java.util.List"%>
<%@page import="model.Waste"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Waste Records</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }

            .card {
                border-radius: 12px;
            }

            .card-header {
                background: linear-gradient(135deg, #007bff, #0056b3);
                color: white;
                font-size: 22px;
                font-weight: bold;
            }

            .table th,
            .table td {
                vertical-align: middle;
            }

            .btn-secondary, .btn-danger {
                font-size: 16px;
                font-weight: bold;
                padding: 8px 15px;
                border-radius: 6px;
            }

            .btn-secondary:hover {
                background-color: #5a6268;
            }

            .btn-danger:hover {
                background-color: #bd2130;
            }

            .button-group {
                display: flex;
                justify-content: center;
                gap: 10px;
            }
        </style>
    </head>

    <body>
        <div class="container mt-4">
            <div class="card shadow-lg">
                <div class="card-header text-center">
                    <h2>Waste Records</h2>
                </div>
                <div class="card-body">

                    <!-- Check if user is logged in -->
                    <%
                        HttpSession sessionUser = request.getSession(false);
                        Integer userId = (sessionUser != null) ? (Integer) sessionUser.getAttribute("id") : null;

                        if (userId == null) {
                            response.sendRedirect("login.jsp?error=Please+login+first");
                            return;
                        }
                    %>

                    <!-- Fetch Waste Records -->
                    <%
                        List<Waste> wasteList = (List<Waste>) request.getAttribute("wasteList");
                        if (wasteList == null) {
                            wasteList = new java.util.ArrayList<Waste>(); // Java 8 compatibility fix
                        }
                    %>

                    <% if (!wasteList.isEmpty()) { %>
                    <!-- Waste Records Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover mt-3">
                            <thead class="table-dark text-center">
                                <tr>
                                    <th>Type</th>
                                    <th>Quantity (kg)</th>
                                    <th>Disposal Method</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody class="text-center">
                                <% for (Waste waste : wasteList) {%>
                                <tr>
                                    <td><%= waste.getType()%></td>
                                    <td><%= waste.getQuantity()%></td>
                                    <td><%= waste.getDisposalMethod()%></td>
                                    <td>
                                        <form action="WasteServlet" method="post" class="d-inline">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<%= waste.getId()%>">
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } else { %>
                    <p class="text-muted text-center mt-4">No waste records available.</p>
                    <% }%>

                    <!-- Back Buttons -->
                    <div class="text-center mt-4 button-group">
                        <a href="waste.jsp" class="btn btn-secondary">Back to Waste Entry</a>
                        <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
                    </div>

                </div>
            </div>
        </div>

        <!-- Bootstrap JS (Optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
