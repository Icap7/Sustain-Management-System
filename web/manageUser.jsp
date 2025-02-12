<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Users" %> <!-- Adjust package name as needed -->
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Users</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </head>
    <body>
        <div class="d-flex">
            <%@ include file="sidebar.jsp" %>


            <!-- Main Content -->
            <div class="container-fluid p-4">
                <header class="page-header">
                    <h1>Manage Users</h1>
                    <p>Admin can edit or delete users from the system.</p>
                </header>

                <table class="table table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Role</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Users> userList = (List<Users>) request.getAttribute("userList");
                            System.out.println("Line 48 " + userList);
                            if (userList != null) {
                                for (Users user : userList) {
                        %>
                        <tr>
                            <td><%= user.getId()%></td>
                            <td><%= user.getName()%></td>
                            <td><%= user.getEmail()%></td>
                            <td><%= user.getRole()%></td>
                            <td>
                                <a href="editUser.jsp?id=<%= user.getId()%>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="DeleteUserServlet?id=<%= user.getId()%>" 
                                   class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this user?');">
                                    Delete
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5" class="text-center">No users found</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

        <%@ include file="footer.jsp" %>  

        <script>
            // Check for delete or update success message from the servlet
            const urlParams = new URLSearchParams(window.location.search);

            if (urlParams.get('deleteSuccess') === 'true') {
                Swal.fire({
                    title: "Deleted!",
                    text: "User has been deleted successfully.",
                    icon: "success",
                    confirmButtonText: "OK"
                });
            } else if (urlParams.get('deleteSuccess') === 'false') {
                Swal.fire({
                    title: "Error!",
                    text: "Failed to delete user.",
                    icon: "error",
                    confirmButtonText: "OK"
                });
            }

            if (urlParams.get('updateSuccess') === 'true') {
                Swal.fire({
                    title: "Updated!",
                    text: "User details have been updated successfully.",
                    icon: "success",
                    confirmButtonText: "OK"
                });
            }

            // Remove query parameters after showing the alert
            window.history.replaceState({}, document.title, window.location.pathname);
        </script>


    </body>
</html>
