<!-- sidebar.jsp -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<nav class="d-flex flex-column bg-dark text-white vh-100 p-3 position-fixed" style="width: 250px;">
    <h4 class="mb-4 text-center">Admin Dashboard</h4>

    <ul class="nav flex-column flex-grow-1">
        <li class="nav-item">
            <a class="nav-link text-white" href="AdminDashboardServlet">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link text-white" href="getUsersServlet">
                <i class="bi bi-people"></i> Manage Users
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="WasteGuideServlet">
                <i class="bi bi-journal"></i> Manage Waste Segregation Guide
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="WasteRecordsServlet">
                <i class="bi bi-trash"></i> Manage Waste Records
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white" href="ManageFootprintServlet">
                <i class="bi bi-graph-up"></i> Manage Carbon Footprint
            </a>
        </li>
    </ul>

    <!-- Logout Button -->
    <div class="mt-auto">
        <form action="LogoutServlet" method="GET">
            <button type="submit" class="btn btn-danger w-100">
                <i class="bi bi-box-arrow-right"></i> Logout
            </button>
        </form>
    </div>
</nav>

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
