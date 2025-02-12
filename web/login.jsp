<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Sustainability Management System</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Make sure the page takes up full viewport height */
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }
            /* Flex container for full-height layout */
            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            /* Make sure the main content grows to push the footer down */
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
                <div class="login-container bg-white p-4 shadow rounded" style="max-width: 400px; width: 100%;">
                    <h1 class="text-center mb-3">Login</h1>
                    <form action="LoginServlet" method="POST">
                        <div class="mb-3">
                            <label for="role" class="form-label">Select Role:</label>
                            <select id="role" name="role" class="form-select" required>
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email:</label>
                            <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password:</label>
                            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Log In</button>
                    </form>

                    <div class="text-center mt-3">
                        <p>Don't have an account?</p>
                        <a href="signup.jsp" class="btn btn-primary w-100">Sign Up</a>
                    </div>
                </div>
            </main>

            <%@ include file="footer.jsp" %>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
