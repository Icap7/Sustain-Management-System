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

    <body class="d-flex flex-column min-vh-100"> <!-- Ensures full height for footer positioning -->

        <!-- Main Content (Expands) -->
        <div class="container mt-5 flex-grow-1">
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

        <!-- Footer (Fixed at Bottom) -->
        <footer class="mt-auto bg-light text-center py-3">
            <%@ include file="footer.jsp" %>
        </footer>

        <!-- Bootstrap JS (Optional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- SweetAlert Success Message -->
        <script>
            // Event Listeners
            document.getElementById("wasteType").addEventListener("change", updateEarnings);
            document.getElementById("quantity").addEventListener("input", updateEarnings);
            document.querySelector("select[name='disposalMethod']").addEventListener("change", updateEarnings);

            function updateEarnings() {
                const wasteTypeDropdown = document.getElementById("wasteType");
                const selectedOption = wasteTypeDropdown.options[wasteTypeDropdown.selectedIndex];
                const pricePerKgOrUnit = parseFloat(selectedOption.getAttribute("data-price"));
                const isUnitBased = selectedOption.getAttribute("data-unit") === "true";
                const quantity = parseFloat(document.getElementById("quantity").value);
                const disposalMethod = document.querySelector("select[name='disposalMethod']").value;
                const calculatorDiv = document.getElementById("recyclingCalculator");
                const earningsField = document.getElementById("earnings");
                const totalPriceField = document.getElementById("totalPrice"); // Hidden field

                let earnings = 0;

                // Only calculate price if disposal method is "Recycling"
                if (disposalMethod === "Recycling" && !isNaN(pricePerKgOrUnit) && !isNaN(quantity)) {
                    earnings = pricePerKgOrUnit * quantity;
                    calculatorDiv.style.display = "block"; // Show earnings display
                } else {
                    calculatorDiv.style.display = "none"; // Hide earnings display
                }

                earningsField.value = earnings.toFixed(2); // Show earnings if applicable
                totalPriceField.value = earnings.toFixed(2); // Always submit total price, even if 0
            }
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Parse URL parameters
                const urlParams = new URLSearchParams(window.location.search);
                const success = urlParams.get('success'); // Check for 'success' parameter
                const error = urlParams.get('error'); // Check for 'error' parameter

                // Show success alert
                if (success === 'true') {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'Waste entry added successfully.',
                        confirmButtonColor: '#007bff'
                    }).then(() => {
                        // Remove success param from URL after displaying alert
                        window.history.replaceState({}, document.title, window.location.pathname);
                    });
                }

                // Show error alert
                if (error) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: error,
                        confirmButtonColor: '#d33'
                    }).then(() => {
                        // Remove error param from URL after displaying alert
                        window.history.replaceState({}, document.title, window.location.pathname);
                    });
                }
            });
        </script>



    </body>

</html>
