<%@page import="java.util.List"%>
<%@page import="model.Waste"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession sessionUser = request.getSession(false);
    Integer userId = (sessionUser != null) ? (Integer) sessionUser.getAttribute("id") : null;
    String role = (sessionUser != null) ? (String) sessionUser.getAttribute("role") : null;

    if (userId == null || !"admin".equals(role)) {
        response.sendRedirect("index.jsp"); // Redirect non-admin users
        return;
    }

    List<Waste> wasteList = (List<Waste>) request.getAttribute("wasteList");
    if (wasteList == null) {
        wasteList = new java.util.ArrayList<Waste>();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Waste Records</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .main-content {
                margin-left: 250px; /* Same width as sidebar */
                padding: 20px;
                width: calc(100% - 250px); /* Adjust width to fit */
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <%@ include file="sidebar.jsp" %>

            <!-- Main Content -->
            <div class="main-content">
                <header class="page-header">
                    <h1>Manage Waste Records</h1>
                    <p>Admin can delete waste records from the system.</p>
                </header>

                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">User ID</th>
                            <th scope="col">Type</th>
                            <th scope="col">Quantity (kg)</th>
                            <th scope="col">Disposal Method</th>
                            <th scope="col">Price (RM)</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (!wasteList.isEmpty()) {
                                for (Waste waste : wasteList) {
                        %>
                        <tr>
                            <td><%= waste.getUserID()%></td>
                            <td><%= waste.getType()%></td>
                            <td><%= waste.getQuantity()%></td>
                            <td><%= waste.getDisposalMethod()%></td>
                            <td><%= waste.getPrice()%></td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="confirmDelete('<%= waste.getId()%>')">Delete</button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center">No waste records found</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Delete Confirmation with SweetAlert -->
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
                                    confirmButtonText: "OK"
                                }).then(() => {
                                    location.reload();
                                });
                            } else {
                                Swal.fire({
                                    title: "Error!",
                                    text: "Failed to delete waste record. Please try again.",
                                    icon: "error",
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

