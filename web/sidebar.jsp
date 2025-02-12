<!-- sidebar.jsp -->  
<style>  
    /* Sidebar styles */  
    .sidebar {  
        width: 250px;  
        background-color: #343a40;  
        color: white;  
        padding: 20px;  
        min-height: 100vh;  
        display: flex;  
        flex-direction: column;  
    }  

    .sidebar h4 {  
        margin-bottom: 20px;  
        font-size: 1.5em;  
    }  

    .sidebar .nav-link {  
        color: #ffffff;  
        padding: 10px 15px;  
        font-size: 16px;  
        border-radius: 5px;  
        transition: background-color 0.3s;  
    }  

    .sidebar .nav-link:hover {  
        background-color: #495057;  
    }  

    .sidebar .nav-item + .nav-item {  
        margin-top: 10px; /* Add spacing between items */  
    }  

    /* Ensure logout button stays at the bottom */  
    .sidebar .mt-auto {  
        margin-top: auto;  
    }  

    .sidebar .btn-danger {  
        margin-top: 20px; /* Add space above the logout button */  
    }  
</style>  

<nav class="sidebar">  
    <h4>Admin Dashboard</h4>  
    <ul class="nav flex-column flex-grow-1">  
        <li class="nav-item">  
            <a class="nav-link" href="getUsersServlet">Manage Users</a>  
        </li>  
        <li class="nav-item">  
            <a class="nav-link" href="WasteGuideServlet">Manage Waste Segregation Guide</a>  
        </li>  
        <li class="nav-item">  
            <a class="nav-link" href="WasteRecordsServlet">Manage Waste Records</a>  
        </li>  
        <li class="nav-item">  
            <a class="nav-link" href="#impact-tracker">Real-Time Impact Tracker</a>  
        </li>  
    </ul>  

    <!-- Logout Button -->  
    <div class="mt-auto">  
        <form action="LogoutServlet" method="GET">  
            <button type="submit" class="btn btn-danger btn-block">Logout</button>  
        </form>  
    </div>  
</nav>