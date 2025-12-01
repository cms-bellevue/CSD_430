<%@ page import="csd430.beans.Movie" %>
<%@ page import="csd430.beans.MovieDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 8 Project Part 3
12/01/2025

This JSP displays a dropdown menu of existing records (Title/ID keys).
Users select a record to proceed to the update form.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 8 Update Selection</title>
    <link rel="stylesheet" type="text/css" href="css/module8_update_style.css">
</head>
<body>

<h2>Module 8 - Project Part 3: Update Record</h2>

<div class="form-container">
    <h3>Select Record to Update</h3>
    <p class="instruction-text">Choose a movie from the list below to modify its details.</p>

    <form action="module8_update_form.jsp" method="get">
        <div class="form-group">
            <label for="id">Select Movie:</label>
            <select id="id" name="id" class="form-select" required>
                <option value="" disabled selected>-- Select a Movie --</option>
                <%
                    // Initialize DAO
                    MovieDAO dao = new MovieDAO();
                    try {
                        // Populate list with Keys (ID + Title)
                        List<Movie> movies = dao.getAllMovieKeys();
                        for (Movie m : movies) {
                %>
                            <option value="<%= m.getId() %>"><%= m.getTitle() %> (ID: <%= m.getId() %>)</option>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<option disabled>Error loading data</option>");
                    }
                %>
            </select>
        </div>
        
        <input type="submit" value="Edit Record" class="submit-btn">
    </form>
</div>

<div class="return-container">
    <a class="return-link" href="index.jsp">Return to Index</a>
</div>

</body>
</html>