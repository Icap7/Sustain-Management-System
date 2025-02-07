<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Sign Up - Sustainability Management System</title>
        <link rel="stylesheet" href="signup.css">
    </head>
    <body>
        <div class="page-container">
            <main class="signup-container">
                <section class="signup-form">
                    <h1>User Sign Up</h1>
                    <form action="SignupServlet" method="POST">
                        <div class="form-group">
                            <label for="name">Full Name:</label>
                            <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" placeholder="Create a password" required>
                        </div>
                        <input type="hidden" name="role" value="user">
                        <button type="submit" class="cta-button">Sign Up</button>
                    </form>

                    <div class="login-link">
                        <p>Already have an account?</p>
                        <a href="login.jsp" class="login-button">Log In</a>
                    </div>
                </section>
            </main>

            <footer class="footer-container">
                <p>© 2024 Sustainability Management System. All Rights Reserved.</p>
            </footer>
        </div>

    </body>
</html>
