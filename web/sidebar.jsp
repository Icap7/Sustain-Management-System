<!-- sidebar.jsp -->
<nav class="bg-dark text-white p-3 d-flex flex-column" style="width: 250px; min-height: 100vh;">
    <h4>Admin Dashboard</h4>
    <ul class="nav flex-column flex-grow-1">
        <li class="nav-item">
            <a class="nav-link text-white" href="getUsersServlet">Manage Users</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="#impact-tracker">Real-Time Impact Tracker</a>
        </li>
    </ul>

    <!-- Logout Button -->
    <div class="mt-auto">
        <a href="LogoutServlet" class="btn btn-danger btn-block">Logout</a>
    </div>
</nav>
