<%@page import="java.util.List"%>
<%@page import="model.Waste"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Waste Records</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
                                    <th>Price (RM)</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody class="text-center">
                                <% for (Waste waste : wasteList) {%>
                                <tr>
                                    <td><%= waste.getType()%></td>
                                    <td><%= waste.getQuantity()%></td>
                                    <td><%= waste.getDisposalMethod()%></td>
                                    <td><%= waste.getPrice()%></td>
                                    <td>
                                        <form id="deleteForm_<%= waste.getId()%>" action="WasteServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="_method" value="DELETE">
                                            <input type="hidden" name="id" value="<%= waste.getId()%>">
                                            <input type="hidden" name="user_id" value="<%= session.getAttribute("id")%>">
                                            <button type="button" class="btn btn-danger" onclick="confirmDelete('<%= waste.getId()%>')">Delete</button>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
                                                        function confirmDelete(wasteId) {
                                                            Swal.fire({
                                                                title: "Are you sure?",
                                                                text: "You won't be able to recover this waste record!",
                                                                icon: "warning",
                                                                showCancelButton: true,
                                                                confirmButtonColor: "#d33",
                                                                cancelButtonColor: "#3085d6",
                                                                confirmButtonText: "Yes, delete it!"
                                                            }).then((result) => {
                                                                if (result.isConfirmed) {
                                                                    deleteWaste(wasteId);
                                                                }
                                                            });
                                                        }

                                                        function deleteWaste(wasteId) {
                                                            fetch('WasteServlet?id=' + wasteId, {
                                                                method: 'DELETE',
                                                            })
                                                                    .then(response => response.json())
                                                                    .then(data => {
                                                                        if (data.success) {
                                                                            Swal.fire({
                                                                                title: "Deleted!",
                                                                                text: "Waste record has been successfully deleted.",
                                                                                icon: "success",
                                                                                confirmButtonColor: "#3085d6",
                                                                                confirmButtonText: "OK"
                                                                            }).then(() => {
                                                                                location.reload(); // Reload the page to update records
                                                                            });
                                                                        } else {
                                                                            Swal.fire({
                                                                                title: "Error!",
                                                                                text: "Failed to delete waste record. Please try again.",
                                                                                icon: "error",
                                                                                confirmButtonColor: "#d33",
                                                                                confirmButtonText: "OK"
                                                                            });
                                                                        }
                                                                    })
                                                                    .catch(error => {
                                                                        console.error('Error:', error);
                                                                        Swal.fire({
                                                                            title: "Error!",
                                                                            text: "An unexpected error occurred.",
                                                                            icon: "error",
                                                                            confirmButtonColor: "#d33",
                                                                            confirmButtonText: "OK"
                                                                        });
                                                                    });
                                                        }
        </script>
    </body>

</html>
