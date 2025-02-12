<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>  
<%@ page import="java.util.List" %>  
<%@ page import="model.WasteSegregationGuide" %>  
<%@ page import="javax.servlet.http.HttpSession" %>  

<%
    HttpSession sessionUser = request.getSession(false);
    Integer userId = (sessionUser != null) ? (Integer) sessionUser.getAttribute("id") : null;
    String role = (sessionUser != null) ? (String) sessionUser.getAttribute("role") : null;

    if (userId == null || !"admin".equals(role)) {
        response.sendRedirect("index.jsp"); // Redirect non-admin users  
        return;
    }

    List<WasteSegregationGuide> guideList = (List<WasteSegregationGuide>) request.getAttribute("guideList");
    if (guideList == null) {
        guideList = new java.util.ArrayList<WasteSegregationGuide>();
    }
%>  

<!DOCTYPE html>  
<html lang="en">  
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Waste Guide</title>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- SweetAlert -->
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
                    <h1>Manage Waste Guide</h1>
                    <p>Admin can add and view waste segregation guides.</p>
                </header>

                <!-- Add Waste Guide Button -->
                <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addGuideModal">Add Waste Guide</button>

                <!-- Waste Guide Table -->
                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Waste Type</th>
                            <th>Category</th>
                            <th>Disposal Method</th>
                            <th>Recycling Instructions</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (WasteSegregationGuide guide : guideList) {%>
                        <tr>
                            <td><%= guide.getId()%></td>
                            <td><%= guide.getWasteType()%></td>
                            <td><%= guide.getCategory()%></td>
                            <td><%= guide.getDisposalMethod()%></td>
                            <td><%= guide.getRecyclingInstructions()%></td>
                            <td>
                                <% if (guide.getImagePath() != null && !guide.getImagePath().isEmpty()) {%>
                                <img src="<%= request.getContextPath() + "/" + guide.getImagePath()%>" alt="Guide Image" width="80">
                                <% } else { %>
                                No Image
                                <% }%>
                            </td>
                            <td>
                                <a href="editWasteGuide.jsp?id=<%= guide.getId()%>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="DeleteWasteGuideServlet?id=<%= guide.getId()%>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure you want to delete this waste guide?');">
                                    Delete
                                </a>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>

                <!-- Add Waste Guide Modal -->
                <div class="modal fade" id="addGuideModal" tabindex="-1" aria-labelledby="addGuideLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addGuideLabel">Add Waste Guide</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="WasteGuideServlet" method="post" enctype="multipart/form-data">
                                    <div class="mb-3">
                                        <label class="form-label">Waste Type</label>
                                        <input type="text" name="wasteType" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Category</label>
                                        <select name="category" class="form-control" required>
                                            <option value="">Select Category</option>
                                            <option value="Biodegradable">Biodegradable</option>
                                            <option value="Recyclable">Recyclable</option>
                                            <option value="Non-Recyclable">Non-Recyclable</option>
                                            <option value="Hazardous Waste">Hazardous Waste</option>
                                            <option value="Electronic Waste">Electronic Waste (E-Waste)</option>
                                            <option value="Medical Waste">Medical Waste</option>
                                            <option value="Industrial Waste">Industrial Waste</option>
                                            <option value="Special Waste">Special Waste</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Disposal Method</label>
                                        <select name="disposalMethod" class="form-control" required>
                                            <option value="">Select Disposal Method</option>
                                            <option value="Composting">Composting</option>
                                            <option value="Recycling">Recycling</option>
                                            <option value="Landfill Disposal">Landfill Disposal</option>
                                            <option value="Incineration">Incineration</option>
                                            <option value="Hazardous Waste Treatment">Hazardous Waste Treatment</option>
                                            <option value="E-Waste Recycling">E-Waste Recycling</option>
                                            <option value="Medical Waste Disposal">Medical Waste Disposal</option>
                                            <option value="Industrial Waste Management">Industrial Waste Management</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Recycling Instructions</label>
                                        <textarea name="recyclingInstructions" class="form-control" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Image</label>
                                        <input type="file" name="image" class="form-control">
                                    </div>
                                    <input type="hidden" name="userId" value="<%= userId%>">
                                    <button type="submit" class="btn btn-primary">Add Guide</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS (with Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
