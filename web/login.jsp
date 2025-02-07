<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Sustainability Management System</title>
  <link rel="stylesheet" href="login.css">
</head>
<body>
  <div class="page-container">
    <main class="login-container">
      <section class="login-form">
        <h1>Login</h1>
        <!-- Change action to point to LoginServlet -->
        <form action="LoginServlet" method="POST">
          <div class="form-group">
            <label for="role">Select Role:</label>
            <select id="role" name="role" required>
              <option value="user">User</option>
              <option value="admin">Admin</option>
            </select>
          </div>
          <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>
          </div>
          <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
          </div>
          <button type="submit" class="cta-button">Log In</button>
        </form>

        <div class="signup-link">
          <p>Don't have an account?</p>
          <a href="signup.jsp" class="signup-button">Sign Up</a>
        </div>
      </section>
    </main>

    <footer class="footer-container">
      <p>© 2024 Sustainability Management System. All Rights Reserved.</p>
    </footer>
  </div>

  <script src="LoginServlet.java"></script>
</body>
</html>
