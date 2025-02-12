<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - Sustainability Management System</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }
            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .main-content {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <div class="page-container">
            <main class="main-content">
                <div class="signup-container bg-white p-4 shadow rounded" style="max-width: 400px; width: 100%;">
                    <h1 class="text-center mb-3">Sign Up</h1>
                    <form action="SignupServlet" method="POST">
                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name:</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="Enter your full name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email:</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password:</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
                        </div>
                        <input type="hidden" name="role" value="user">
                        <button type="submit" class="btn btn-success w-100">Sign Up</button>
                    </form>

                    <div class="text-center mt-3">
                        <p>Already have an account?</p>
                        <a href="login.jsp" class="btn btn-primary w-100">Log In</a>
                    </div>
                </div>
            </main>

            <%@ include file="footer.jsp" %>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
