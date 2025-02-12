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

                                <!-- Waste Type Dropdown -->
                                <div class="mb-3">
                                    <label class="form-label">Waste Type:</label>
                                    <select name="type" id="wasteType" class="form-select" required>
                                        <option value="" selected disabled>Select Waste Type</option>
                                        <option value="newspaper" data-price="0.24">Newspaper - RM 0.24/kg</option>
                                        <option value="box" data-price="0.22">Box - RM 0.22/kg</option>
                                        <option value="magazine" data-price="0.22">Magazine - RM 0.22/kg</option>
                                        <option value="aluminium" data-price="3.00">Aluminium Can/Stainless Steel - RM 3.00/kg</option>
                                        <option value="car-battery" data-price="1.00">Car Battery - RM 1.00/kg</option>
                                        <option value="plastic" data-price="0.40">Plastic - RM 0.40/kg</option>
                                        <option value="computer" data-price="4.00" data-unit="true">Computer - RM 4.00/unit</option>
                                        <option value="cooking-oil" data-price="0.80">Used Cooking Oil - RM 0.80/kg</option>
                                    </select>
                                </div>

                                <!-- Quantity Input -->
                                <div class="mb-3">
                                    <label class="form-label">Quantity (kg or unit):</label>
                                    <input type="number" name="quantity" id="quantity" class="form-control" required>
                                </div>

                                <!-- Disposal Method Dropdown -->
                                <div class="mb-3">
                                    <label class="form-label">Disposal Method:</label>
                                    <select name="disposalMethod" class="form-select">
                                        <option value="Recycling">Recycling</option>
                                        <option value="Composting">Composting</option>
                                        <option value="Incineration">Incineration</option>
                                        <option value="Landfill">Landfill</option>
                                    </select>
                                </div>

                                <!-- Hidden Input to Store Total Price -->
                                <input type="hidden" name="totalPrice" id="totalPrice">

                                <!-- Earnings Calculation Display -->
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
            document.getElementById("wasteType").addEventListener("change", updateEarnings);
            document.getElementById("quantity").addEventListener("input", updateEarnings);

            function updateEarnings() {
                const wasteTypeDropdown = document.getElementById("wasteType");
                const selectedOption = wasteTypeDropdown.options[wasteTypeDropdown.selectedIndex];
                const pricePerKgOrUnit = parseFloat(selectedOption.getAttribute("data-price"));
                const isUnitBased = selectedOption.getAttribute("data-unit") === "true";
                const quantity = parseFloat(document.getElementById("quantity").value);
                const calculatorDiv = document.getElementById("recyclingCalculator");
                const earningsField = document.getElementById("earnings");
                const totalPriceField = document.getElementById("totalPrice"); // Hidden field

                if (!isNaN(pricePerKgOrUnit) && !isNaN(quantity)) {
                    const earnings = pricePerKgOrUnit * quantity;
                    earningsField.value = earnings.toFixed(2);
                    totalPriceField.value = earnings.toFixed(2); // Store calculated price in hidden field
                    calculatorDiv.style.display = "block";
                } else {
                    calculatorDiv.style.display = "none";
                    earningsField.value = "";
                    totalPriceField.value = "0"; // Reset total price
                }
            }

        </script>

    </body>
</html>
