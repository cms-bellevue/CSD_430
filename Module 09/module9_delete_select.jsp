<%@ page import="csd430.beans.Movie" %>
<%@ page import="csd430.beans.MovieDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 9 - Project Part 4
12/07/2025

This JSP displays all active records and allows the user to select one 
for soft deletion (moving to the Recycle Bin).
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 9 Delete Record</title>
    <link rel="stylesheet" type="text/css" href="css/module9_delete_style.css">
    <script src="js/sortTable.js"></script> 
</head>
<body>

<h2 class="delete-header">Module 9 - Project Part 4: Delete Record</h2>

<div class="form-container delete-container">
    
    <%
        MovieDAO dao = new MovieDAO();
        List<Movie> activeMovies = null;
        List<Movie> activeMovieKeys = null;
        String message = request.getParameter("msg") != null ? request.getParameter("msg") : "";
        String msgClass = request.getParameter("class") != null ? request.getParameter("class") : "";
        try {
            activeMovies = dao.getAllMoviesSortedByTitle(); 
            activeMovieKeys = dao.getAllMovieKeys();
        } catch (SQLException e) {
            message = "Database Error: " + e.getMessage();
            msgClass = "error-message";
        }
    %>
    
    <% if (!message.isEmpty()) { %>
        <p class="<%= msgClass %>"><%= message %></p>
    <% } %>
    
    <div class="delete-grid">
        
        <%-- Active Records Column --%>
        <div>
            <h3 class="delete-header">Active Records List - Sorted Alphabetically</h3>
       
            <p class="instruction-text">Click any column header to sort the table.</p>

            <%-- Table structure is now outside the if/else so headers always show --%>
            <table class="data-table sortable" id="moviesTable"> 
                <thead>
                    <tr class="delete-table">
                        <th onclick="sortTable(0)">ID</th>
                        <th onclick="sortTable(1)">Title</th>
                        <th onclick="sortTable(2)">Year</th>
                        <th onclick="sortTable(3)">Genre</th>
                        <th onclick="sortTable(4)">Director</th>
                    </tr>
                </thead>
         
                <tbody>
                    <% if (activeMovies != null && !activeMovies.isEmpty()) { %>
                        <% for (Movie m : activeMovies) { %>
                            <tr>
                                <td><%= m.getId() %></td>
                                <td><%= m.getTitle() %></td>
                                <td><%= m.getYear() %></td>
                                <td><%= m.getGenre() %></td>
                                <td><%= m.getDirector() %></td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <%-- If empty, show message inside a table row spanning all 5 columns --%>
                        <tr>
                            <td colspan="5">
                                <p class="instruction-text error-message">No active records found.<br>
                                The database may be empty or all records are in the Recycle Bin.</p>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <%-- Soft Delete Form Column --%>
        <div>
            <h3 class="delete-header">Move Record to Recycle Bin</h3>
            <p class="instruction-text">Choose a movie to soft delete to the recycle bin.</p>
      
            <form action="module9_delete_process.jsp" method="post">
                <div class="form-group">
                    <label for="id">Select Movie:</label>
                    <select id="id" name="id" class="form-select" required <%= activeMovieKeys == null ||
activeMovieKeys.isEmpty() ? "disabled" : "" %>>
                        <option value="" disabled selected>-- Select a Movie to Delete --</option>
                        <%
                            if (activeMovieKeys != null) {
      
                                for (Movie m : activeMovieKeys) {
                        %>
                                    <option value="<%= m.getId() %>"><%= m.getTitle() %> (ID: <%= m.getId() %>)</option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                
                <input type="hidden" name="action" value="SOFT_DELETE">
                <input type="submit" value="Soft Delete Record" 
class="submit-btn delete-btn" 
                       <%= activeMovieKeys == null ||
activeMovieKeys.isEmpty() ? "disabled" : "" %>>
            </form>
            
            <hr class="separator-md">

            <div class="return-container text-align-left">
                <h4 class="delete-link-heading">Manage deleted files:</h4>
                <a class="recycle-bin-link" href="module9_recycle_bin.jsp">View Recycle Bin</a>
            </div>
        </div>

    </div>

</div>

<div class="return-container">
    <a class="return-link" href="index.jsp">Return to Index</a>
</div>

</body>
</html>