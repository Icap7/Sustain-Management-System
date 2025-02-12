<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>  
<%@ page import="model.WasteSegregationGuide" %>  
<%@ page import="dao.WasteGuideDAO" %>  <!-- Import DAO -->
<%@ page import="javax.servlet.http.HttpSession" %>  
<%@ page import="java.util.List" %>  

<%
    HttpSession sessionUser = request.getSession(false);
    Integer userId = (sessionUser != null) ? (Integer) sessionUser.getAttribute("id") : null;
    String role = (sessionUser != null) ? (String) sessionUser.getAttribute("role") : null;

    if (userId == null || !"admin".equals(role)) {
        response.sendRedirect("index.jsp"); // Redirect non-admin users  
        return;
    }

    // Fetch the guide to edit by ID
    Integer guideId = null;
    WasteSegregationGuide guideToEdit = null;

    try {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            guideId = Integer.parseInt(idParam);
            guideToEdit = WasteGuideDAO.getGuideById(guideId);  // Fetch from DAO
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (guideToEdit == null) {
%>
<script>
    alert("Waste guide not found!");
    window.location.href = "WasteGuideServlet";  // Redirect to manage page
</script>
<%
        return;
    }
%>  

<!DOCTYPE html>  
<html lang="en">  
    <head>  
        <meta charset="UTF-8">  
        <meta name="viewport" content="width=device-width, initial-scale=1.0">  
        <title>Edit Waste Guide</title>  
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" crossorigin="anonymous">  
    </head>  
    <body>  
        <div class="container">  
            <h1>Edit Waste Guide</h1>  
            <form action="UpdateWasteGuideServlet" method="post" enctype="multipart/form-data">  
                <input type="hidden" name="id" value="<%= (guideToEdit != null) ? guideToEdit.getId() : ""%>">  

                <div class="mb-3">  
                    <label class="form-label">Waste Type</label>  
                    <input type="text" name="wasteType" class="form-control" 
                           value="<%= (guideToEdit != null) ? guideToEdit.getWasteType() : ""%>" required>  
                </div>  

                <div class="mb-3">  
                    <label class="form-label">Category</label>  
                    <select name="category" class="form-control" required>  
                        <option value="<%= (guideToEdit != null) ? guideToEdit.getCategory() : ""%>" selected>
                            <%= (guideToEdit != null) ? guideToEdit.getCategory() : "Select Category"%>
                        </option>  
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
                        <option value="<%= (guideToEdit != null) ? guideToEdit.getDisposalMethod() : ""%>" selected>
                            <%= (guideToEdit != null) ? guideToEdit.getDisposalMethod() : "Select Disposal Method"%>
                        </option>  
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
                    <textarea name="recyclingInstructions" class="form-control" required><%= (guideToEdit != null) ? guideToEdit.getRecyclingInstructions().trim() : ""%></textarea>
                </div>  

                <div class="mb-3">  
                    <label class="form-label">Image</label>  
                    <input type="file" name="image" class="form-control">  
                </div>  

                <button type="submit" class="btn btn-primary">Update Guide</button>  
            </form>  
        </div>  
    </body>  
</html>
