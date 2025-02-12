<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sustainability Management System</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">Sustainable Yours</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="#initiatives">Initiatives</a></li>
                        <li class="nav-item"><a class="nav-link" href="#functions">Functions</a></li>
<!--                        <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>-->
                    </ul>
                </div>

                <!-- User Profile / Login -->
                <%
                    String username = (String) session.getAttribute("user");
                    if (username != null) {
                %>
                <div class="dropdown">
                    <button class="btn btn-outline-dark dropdown-toggle d-flex align-items-center" type="button" 
                            id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle me-2"></i> Welcome, <%= username%>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="editProfile.jsp"><i class="bi bi-pencil-square me-2"></i>Edit Profile</a></li>
                        <li>
                            <form action="LogoutServlet" method="post">
                                <button class="dropdown-item" type="submit"><i class="bi bi-box-arrow-right me-2"></i>Log Out</button>
                            </form>
                        </li>
                    </ul>
                </div>
                <%
                } else {
                %>
                <a href="login.jsp" class="btn btn-primary"><i class="bi bi-box-arrow-in-right me-1"></i>Log In</a>
                <%
                    }
                %>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="text-center bg-light py-5">
            <div class="container">
                <h1 class="fw-bold">Building a Sustainable Future</h1>
                <p class="lead">Empowering organizations to achieve their sustainability goals.</p>
                <a href="#initiatives" class="btn btn-success btn-lg">Learn More</a>
            </div>
        </section>

        <div class="container my-5">
            <!-- About Section -->
            <section id="about" class="text-center mb-5">
                <h2>About Us</h2>
                <p>Our Sustainability Management System helps organizations track, manage, and improve their environmental impact.</p>
            </section>

            <!-- Initiatives Section -->
            <section id="initiatives" class="mb-5">
                <h2 class="text-center mb-4">Our Initiatives</h2>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card shadow-sm text-center">
                            <div class="card-body">
                                <i class="bi bi-lightbulb-fill text-warning display-6"></i>
                                <h5 class="mt-3">Energy Conservation Programs</h5>
                                <p>Reducing energy consumption through smart solutions and innovation.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card shadow-sm text-center">
                            <div class="card-body">
                                <i class="bi bi-recycle text-success display-6"></i>
                                <h5 class="mt-3">Waste Reduction Strategies</h5>
                                <p>Encouraging responsible waste management and recycling practices.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card shadow-sm text-center">
                            <div class="card-body">
                                <i class="bi bi-people-fill text-primary display-6"></i>
                                <h5 class="mt-3">Community Engagement</h5>
                                <p>Involving local communities in sustainable initiatives.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Functions Section -->
            <section id="functions" class="mb-5">
                <h2 class="text-center mb-4">Our Core Functions</h2>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm text-center">
                            <div class="card-body">
                                <i class="bi bi-cloud-sun text-info display-6"></i>
                                <h5 class="mt-3">Carbon Footprint Calculator</h5>
                                <p>Understand your environmental impact based on your energy usage and habits.</p>
                                <a href="SignupRedirectServlet?function=carbonFootprint" class="btn btn-primary w-100">Calculate Footprint</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm text-center">
                            <div class="card-body">
                                <i class="bi bi-trash text-danger display-6"></i>
                                <h5 class="mt-3">Waste Management</h5>
                                <p>Track real-time metrics on waste reduction and sustainability progress.</p>
                                <a href="SignupRedirectServlet?function=waste" class="btn btn-primary w-100">View Metrics</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm text-center">
                            <div class="card-body">
                                <i class="bi bi-list-check text-success display-6"></i>
                                <h5 class="mt-3">Waste Segregation Guide</h5>
                                <p>Learn how to properly segregate waste with our interactive guide.</p>
                                <a href="SignupRedirectServlet?function=WasteSegregationGuide" class="btn btn-primary w-100">Learn More</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('logoutSuccess') === 'true') {
                Swal.fire({
                    title: "Logged Out!",
                    text: "You have successfully logged out.",
                    icon: "success",
                    confirmButtonText: "OK"
                }).then(() => {
                    window.history.replaceState({}, document.title, window.location.pathname);
                });
            }
        </script>

        <!-- Bootstrap JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
