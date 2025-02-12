<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.WasteSegregationGuide" %>
<%@ page import="dao.WasteGuideDAO" %>

<%
    String idParam = request.getParameter("id");
    WasteSegregationGuide guide = null;

    if (idParam != null && !idParam.trim().isEmpty()) {
        int guideId = Integer.parseInt(idParam);
        guide = new WasteGuideDAO().getGuideById(guideId);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Waste Guide Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <% if (guide != null) { %>
            <div class="card shadow-lg mx-auto" style="max-width: 700px;">
                <div class="card-body text-center">
                    <h1 class="card-title fw-bold"><%= guide.getWasteType() %></h1>
                    <p class="card-text"><strong>Category:</strong> <%= guide.getCategory() %></p>
                    <p class="card-text"><strong>Disposal Method:</strong> <%= guide.getDisposalMethod() %></p>
                    <p class="card-text"><strong>Recycling Instructions:</strong> <%= guide.getRecyclingInstructions() %></p>

                    <% if (guide.getImagePath() != null && !guide.getImagePath().isEmpty()) { %>
                        <img src="<%= guide.getImagePath() %>" alt="<%= guide.getWasteType() %>" class="img-fluid rounded my-3" width="100%">
                    <% } %>

                    <a href="WasteSegregationGuide.jsp" class="btn btn-secondary">Back to Guide List</a>
                </div>
            </div>
        <% } else { %>
            <div class="text-center">
                <p class="text-danger">Guide not found!</p>
                <a href="WasteSegregationGuide.jsp" class="btn btn-primary">Back to Guide List</a>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
