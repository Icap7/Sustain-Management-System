<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>  
<%@ page import="java.util.List" %>  
<%@ page import="model.WasteSegregationGuide" %>  
<%@ page import="dao.WasteGuideDAO" %>  

<%
    WasteGuideDAO dao = new WasteGuideDAO();
    List<WasteSegregationGuide> guideList = dao.getAllGuides();
%>  

<!DOCTYPE html>  
<html lang="en">  
    <head>  
        <meta charset="UTF-8">  
        <title>Waste Segregation Guide</title>  
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">  
        <script>
            function searchGuide() {
                let input = document.getElementById("itemInput").value.toLowerCase();
                let guideItems = document.getElementsByClassName("guide-item");

                for (let i = 0; i < guideItems.length; i++) {
                    let wasteType = guideItems[i].getAttribute("data-waste-type").toLowerCase();
                    guideItems[i].style.display = wasteType.includes(input) ? "block" : "none";
                }
            }
        </script>  
    </head>  
    <body class="bg-light">  
        <div class="container mt-5">  
            <!-- Centered Title and Description -->  
            <div class="text-center mb-4">  
                <h1 class="fw-bold text-primary">Waste Segregation Guide</h1>  
                <p class="text-muted">Enter an item to see how to dispose of it properly.</p>  
            </div>  

            <!-- Back to Home Button -->  
            <div class="text-center mb-4">  
                <a href="index.jsp" class="btn btn-outline-secondary">← Back to Home</a>  
            </div>  

            <input type="text" id="itemInput" class="form-control w-50 mx-auto mb-4" placeholder="e.g., batteries" onkeyup="searchGuide()">  

            <div class="row">  
                <% if (guideList != null && !guideList.isEmpty()) { %>  
                <% for (WasteSegregationGuide guide : guideList) {%>  
                <div class="col-md-4 mb-4 guide-item" data-waste-type="<%= guide.getWasteType()%>">  
                    <div class="card shadow-sm border-light">  
                        <% if (guide.getImagePath() != null && !guide.getImagePath().isEmpty()) {%>  
                        <img src="<%= guide.getImagePath()%>" class="card-img-top" alt="<%= guide.getWasteType()%>" style="height: 200px; object-fit: cover;">  
                        <% } else { %>  
                        <img src="default-placeholder.png" class="card-img-top" alt="No Image Available" style="height: 200px; object-fit: cover;">  
                        <% }%>  

                        <div class="card-body">  
                            <h5 class="card-title text-truncate"><%= guide.getWasteType()%></h5>  
                            <p class="card-text"><strong>Category:</strong> <%= guide.getCategory()%></p>  
                            <p class="card-text"><strong>Disposal Method:</strong> <%= guide.getDisposalMethod()%></p>  
                            <a href="WasteSegregationGuideDetails.jsp?id=<%= guide.getId()%>" class="btn btn-primary btn-sm">View More</a>  
                        </div>  
                    </div>  
                </div>  
                <% } %>  
                <% } else { %>  
                <div class="col-12 text-center">  
                    <p class="text-danger">No waste segregation guides found.</p>  
                </div>  
                <% }%>  
            </div>  
        </div>  
        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>  
    </body>  
</html>