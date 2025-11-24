<%@ page import="csd430.beans.Movie" %>
<%@ page import="csd430.beans.MovieDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 7 Project Part 2
11/23/2025

This JSP file displays a form to add a new movie record.
It prevents duplicates by checking Title/Director/Year and handles dynamic inputs.
NOTE: Database connections utilize AES-256 encrypted credentials via MovieDAO.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 7 Create Record</title>
    <link rel="stylesheet" type="text/css" href="css/module7_create_style.css">
    <script src="js/sortTable.js"></script>
    
    <%-- Client-side logic for toggling the custom genre input field --%>
    <script>
        // Shows/Hides text input based on Dropdown selection
        function handleGenreChange(selectObject) {
            var value = selectObject.value;
            var customInput = document.getElementById("customGenreInput");
            var payload = document.getElementById("realGenrePayload");

            if (value === "NEW") {
                customInput.style.display = "block";
                customInput.required = true;
                customInput.value = ""; 
                customInput.focus();
                payload.value = ""; // Clear payload so user must type input
            } else {
                customInput.style.display = "none";
                customInput.required = false;
                payload.value = value;
            }
        }

        // Syncs the hidden payload field with the user's custom text input
        function syncCustomGenre(inputObject) {
            var payload = document.getElementById("realGenrePayload");
            payload.value = inputObject.value;
        }
    </script>
</head>
<body>

<h2>Module 7 Project Part 2: Create &amp; View Records</h2>

<%-- Initialize Bean and DAO --%>
<jsp:useBean id="movieDAO" class="csd430.beans.MovieDAO" scope="page" />
<jsp:useBean id="newMovie" class="csd430.beans.Movie" scope="page" />
<jsp:setProperty property="*" name="newMovie" />

<%-- Handle Form Submission Logic --%>
<%
    // Page Constants
    final int FIRST_MOVIE_YEAR = 1888; // Year of the first motion picture
    final String DEFAULT_FALLBACK_GENRE = "Action"; // Used if DB is empty

    String message = "";
    String msgClass = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            if (newMovie.getTitle() != null && !newMovie.getTitle().isEmpty()) {
                
                // Check for duplicates (Title + Director + Year) before inserting
                // This allows for remakes by the same director in different years (e.g., Hitchcock)
                if (movieDAO.movieExists(newMovie.getTitle(), newMovie.getDirector(), newMovie.getYear())) {
                    message = "Error: This specific movie record is already in the database.";
                    msgClass = "error-message";
                } else {
                    movieDAO.insertMovie(newMovie);
                    message = "Success! Record added for: " + newMovie.getTitle();
                    msgClass = "success-message";
                }
                
            } else {
                message = "Error: Title is required.";
                msgClass = "error-message";
            }
        } catch (SQLException e) {
            message = "Database Error: " + e.getMessage();
            msgClass = "error-message";
        }
    }
%>

<%-- Record Entry Form --%>
<div class="form-container">
    <h3>Add New Movie Record</h3>
    
    <% if (!message.isEmpty()) { %>
        <p class="<%= msgClass %>"><%= message %></p>
    <% } %>

    <form action="module7_create.jsp" method="post">
        
        <div class="form-group">
            <label for="title">Movie Title:</label>
            <input type="text" id="title" name="title" required>
        </div>

        <div class="form-group">
            <label for="year">Year Released:</label>
            <select id="year" name="year" class="form-select" required>
                <%-- Generate years from current year back to the first movie year --%>
                <% 
                   int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                   for (int i = currentYear; i >= FIRST_MOVIE_YEAR; i--) { 
                %>
                    <option value="<%= i %>" <%= (i == currentYear) ? "selected" : "" %>><%= i %></option>
                <% } %>
            </select>
        </div>

        <div class="form-group">
            <label for="genreSelect">Genre:</label>
            
            <%-- Dynamic Genre List populated from Database --%>
            <select id="genreSelect" class="form-select" onchange="handleGenreChange(this)">
                <%
                    String defaultGenre = "";
                    try {
                        List<String> dbGenres = movieDAO.getDistinctGenres();
                        
                        // Handle case where DB has no genres yet
                        if (dbGenres.isEmpty()) {
                            defaultGenre = DEFAULT_FALLBACK_GENRE;
                            out.println("<option value='" + DEFAULT_FALLBACK_GENRE + "'>" + DEFAULT_FALLBACK_GENRE + "</option>");
                        } else {
                            defaultGenre = dbGenres.get(0);
                            
                            for (String g : dbGenres) {
                %>
                                <option value="<%= g %>"><%= g %></option>
                <%
                            }
                        }
                    } catch (SQLException e) {
                        out.println("<option value='Error'>Error Loading Genres</option>");
                    }
                %>
                <option value="NEW">-- Add New Genre --</option>
            </select>

            <%-- Hidden input for custom genre entry --%>
            <input type="text" id="customGenreInput" placeholder="Type new genre here..." 
                   oninput="syncCustomGenre(this)">

            <%-- Actual value sent to JavaBean --%>
            <input type="hidden" name="genre" id="realGenrePayload" value="<%= defaultGenre %>">
        </div>

        <div class="form-group">
            <label for="director">Director:</label>
            <input type="text" id="director" name="director" required>
        </div>

        <input type="submit" value="Add Record" class="submit-btn">
    </form>
</div>

<hr class="divider">

<%-- Data Display Table --%>
<h3>Database Records Sorted by Most Recent Entry</h3>
<p class="sort-hint">Click column headers to sort</p>

<table class="data-table" id="moviesTable">
    <thead>
        <tr>
            <th onclick="sortTable(0)">ID</th>
            <th onclick="sortTable(1)">Title</th>
            <th onclick="sortTable(2)">Year</th>
            <th onclick="sortTable(3)">Genre</th>
            <th onclick="sortTable(4)">Director</th>
        </tr>
    </thead>
    <tbody>
    <%
        try {
            List<Movie> allMovies = movieDAO.getAllMovies();
            for (Movie m : allMovies) {
    %>
        <tr>
            <td><%= m.getId() %></td>
            <td><%= m.getTitle() %></td>
            <td><%= m.getYear() %></td>
            <td><%= m.getGenre() %></td>
            <td><%= m.getDirector() %></td>
        </tr>
    <%
            }
        } catch (SQLException e) {
    %>
        <tr>
            <td colspan="5" class="error-message">Error loading data: <%= e.getMessage() %></td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>

<br>
<div class="return-container">
    <a class="return-link" href="index.jsp">Return to Index</a>
</div>

</body>
</html>