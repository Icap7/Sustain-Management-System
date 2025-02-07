<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sustainability Management System</title>
  <link rel="stylesheet" href="index.css">
</head>
<body>
  <header>
    <div class="logo">Sustainable Yours</div>
    <nav>
      <ul>
        <li><a href="#about">About</a></li>
        <li><a href="#initiatives">Initiatives</a></li>
        <li><a href="#functions">Functions</a></li>
        <li><a href="#contact">Contact</a></li>
      </ul>
    </nav>
        <%
        if (session.getAttribute("user") != null) {
       %>
        <form action="LogoutServlet" method="post" style="display: inline;">
            <button type="submit" class="logout-button">Log Out</button>
        </form>
        <%
        } else {
        %>
        <button id="login-button" class="login-button" onclick="location.href='login.jsp'">Log In</button>
         <%
        }
         %>  
  </header>

  <main>
    <section class="hero">
      <h1>Building a Sustainable Future</h1>
      <p>Empowering organizations to achieve their sustainability goals.</p>
      <a href="#initiatives" class="cta-button">Learn More</a>
    </section>

    <section id="about" class="content-section">
      <h2>About Us</h2>
      <p>Our Sustainability Management System helps organizations track, manage, and improve their environmental impact.</p>
    </section>

    <section id="initiatives" class="content-section">
      <h2>Our Initiatives</h2>
      <ul>
        <li>Energy Conservation Programs</li>
        <li>Waste Reduction Strategies</li>
        <li>Community Engagement</li>
      </ul>
    </section>

    <section id="functions" class="content-section functions-section">
      <h2>Our Core Functions</h2>
      <div class="function-cards">

        <!-- Function Card: Carbon Footprint Calculator -->
        <div class="function-card">
          <h3>Carbon Footprint Calculator</h3>
          <p>Understand your environmental impact by calculating your carbon footprint based on your energy usage, transportation, and habits.</p>
          <form action="SignupRedirectServlet" method="get">
            <input type="hidden" name="function" value="carbonFootprint">
            <button class="cta-button" type="submit">Calculate Footprint</button>
          </form>
        </div>

        <!-- Function Card: Real-Time Impact Tracker -->
        <div class="function-card">
          <h3>Waste Management </h3>
          <p>Track real-time metrics on energy savings, waste reduction, and overall sustainability progress.</p>
          <a href="SignupRedirectServlet?function=waste" class="cta-button">View Metrics</a>
        </div>

        <!-- Function Card: Resource Management Tool -->
        <div class="function-card">
          <h3>Waste Segregation Guide</h3>
          <p>Interactive guide to help users properly segregate waste.</p>
          <a href=d"SignupRedirectServlet?function=WasteSegregationGuide" class="cta-button">Learn More</a>
        </div>

      </div>
    </section>
  </main>

  <footer>
    <p>&copy; 2024 Sustainability Management System. All Rights Reserved.</p>
  </footer>
</body>
</html>
