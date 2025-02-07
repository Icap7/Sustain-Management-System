<%-- 
    Document   : guide
    Created on : Feb 6, 2025, 2:30:35 PM
    Author     : danish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Waste Segregation Guide</title>
    <link rel="stylesheet" type="text/css" href="WasteSegregationGuide.css">
</head>
<body>
    <div class="container">
        <h1>Waste Segregation Guide</h1>
        <p>Enter an item to see how to dispose of it properly:</p>
        <form action="WasteSegregationServlet" method="post">
            <input type="text" name="item" id="itemInput" placeholder="e.g., batteries">
            <button type="submit">Search</button>
        </form>

        <div id="result" class="result">
            <% String result = (String) request.getAttribute("result"); %>
            <% if (result != null) { %>
                <%= result %>
            <% } %>
        </div>
    </div>
</body>
</html>
