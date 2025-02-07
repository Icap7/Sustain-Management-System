<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Dashboard - Sustainability Management System</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="dashboard-container">
    <header class="dashboard-header">
      <h1>Welcome to the Sustainability Management System</h1>
      <nav class="dashboard-nav">
        <ul>
          <li><a href="logout.jsp">Logout</a></li>
        </ul>
      </nav>
    </header>

    <main class="dashboard-main">
      <section class="dashboard-buttons">
        <h2>User Dashboard</h2>
        <div class="button-grid">
          <button onclick="location.href='calculator.jsp'" class="dashboard-button">Carbon Footprint</button>
          <button onclick="location.href='realTimeTracker.jsp'" class="dashboard-button">Real-Time Tracker</button>
          <button onclick="location.href='resourceManagement.jsp'" class="dashboard-button">Resource Management Tool</button>
        </div>
      </section>
    </main>

    <footer class="dashboard-footer">
      <p>&copy; 2024 Sustainability Management System. All Rights Reserved.</p>
    </footer>
  </div>

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f9;
    }

    .dashboard-container {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .dashboard-header {
      background-color: #004d40;
      color: #ffffff;
      padding: 1rem;
      text-align: center;
    }

    .dashboard-header h1 {
      margin: 0;
    }

    .dashboard-nav ul {
      list-style: none;
      padding: 0;
      margin: 0;
      display: flex;
      justify-content: flex-end;
    }

    .dashboard-nav ul li {
      margin: 0 1rem;
    }

    .dashboard-nav ul li a {
      color: #ffffff;
      text-decoration: none;
    }

    .dashboard-main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 2rem;
    }

    .dashboard-buttons {
      text-align: center;
    }

    .button-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 1rem;
      margin-top: 1.5rem;
    }

    .dashboard-button {
      background-color: #00796b;
      color: #ffffff;
      border: none;
      padding: 1rem;
      font-size: 1.2rem;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .dashboard-button:hover {
      background-color: #004d40;
    }

    .dashboard-footer {
      background-color: #004d40;
      color: #ffffff;
      text-align: center;
      padding: 1rem;
    }
  </style>
</body>
</html>
