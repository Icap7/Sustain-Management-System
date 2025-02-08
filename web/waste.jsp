<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Waste Management System</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- Include SweetAlert -->

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
            .btn-primary, .btn-info, .btn-secondary {
                font-size: 18px;
                font-weight: bold;
                padding: 10px 15px;
                border-radius: 8px;
                width: 100%;
            }
            .button-group {
                display: flex;
                gap: 10px;
            }
        </style>
    </head>

    <body>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-lg">
                        <div class="card-header text-center">
                            Waste Management System
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

                            <!-- Waste Entry Form -->
                            <form action="WasteServlet" method="post">
                                <input type="hidden" name="action" value="add">
                                <div class="mb-3">
                                    <label class="form-label">Waste Type:</label>
                                    <input type="text" name="type" id="wasteType" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Quantity (kg):</label>
                                    <input type="number" name="quantity" id="quantity" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Disposal Method:</label>
                                    <select name="disposalMethod" class="form-select">
                                        <option value="Recycling">Recycling</option>
                                        <option value="Composting">Composting</option>
                                        <option value="Incineration">Incineration</option>
                                        <option value="Landfill">Landfill</option>
                                    </select>
                                </div>
                                
                                <!-- Recycling Calculator -->
                                <div class="mb-3" id="recyclingCalculator" style="display: none;">
                                    <label class="form-label">Earnings (RM):</label>
                                    <input type="text" id="earnings" class="form-control" readonly>
                                </div>
                                
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Submit Waste Entry</button>
                                </div>
                            </form>

                            <!-- Button Section -->
                            <div class="text-center mt-3 button-group">
                                <a href="WasteRecordsServlet" class="btn btn-info">View Waste Records</a>
                                <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS (Optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- SweetAlert Success Message -->
        <script>
            // Check if the success parameter is present in the URL
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('success') === 'true') {
                Swal.fire({
                    icon: 'success',
                    title: 'Success!',
                    text: 'Waste entry added successfully.',
                    confirmButtonColor: '#007bff'
                });
            }

            // Recycling Calculator Script
            document.getElementById("wasteType").addEventListener("input", updateEarnings);
            document.getElementById("quantity").addEventListener("input", updateEarnings);

            function updateEarnings() {
                const wasteType = document.getElementById("wasteType").value.toLowerCase();
                const quantity = parseFloat(document.getElementById("quantity").value);
                const calculatorDiv = document.getElementById("recyclingCalculator");
                const earningsField = document.getElementById("earnings");

                if (wasteType === "plastic" && !isNaN(quantity)) {
                    const earnings = quantity * 2;
                    earningsField.value = earnings.toFixed(2);
                    calculatorDiv.style.display = "block";
                } else {
                    calculatorDiv.style.display = "none";
                    earningsField.value = "";
                }
            }
        </script>

    </body>
</html>
