<%@ page import="csd430.beans.Movie" %>
<%@ page import="csd430.beans.MovieDAO" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 8 Project Part 3
11/30/2025

This JSP displays the pre-populated form for editing a specific record.
The ID field is displayed but non-updateable.
It includes client-side validation (via external JS) to disable the submit button until changes are detected.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 8 Edit Record</title>
    <link rel="stylesheet" type="text/css" href="css/module8_update_style.css">
    <script src="js/module8_update.js"></script>
</head>
<body>

<h2>Module 8 - Project Part 3: Edit Record Details</h2>

<%
    MovieDAO dao = new MovieDAO();
    Movie selectedMovie = null;
    String errorMsg = "";
    int movieId = -1;
    
    List<String> distinctGenres = null;
    List<String> distinctDirectors = null;

    try {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            movieId = Integer.parseInt(idParam);
            selectedMovie = dao.getMovieById(movieId);
            
            distinctGenres = dao.getDistinctGenres();
            distinctDirectors = dao.getDistinctDirectors();
        } else {
            errorMsg = "No record selected.";
        }
    } catch (Exception e) {
        errorMsg = "Error retrieving record: " + e.getMessage();
    }
%>

<div class="form-container">
    
    <% if (selectedMovie != null) { %>
        <h3>Editing: <%= selectedMovie.getTitle() %></h3>

        <form action="module8_update_process.jsp" method="post">
            
            <div class="form-group">
                <label for="displayId">Record ID (Key):</label>
                <input type="text" id="displayId" value="<%= selectedMovie.getId() %>" disabled class="readonly-input">
                <input type="hidden" name="id" value="<%= selectedMovie.getId() %>">
            </div>

            <div class="form-group">
                <label for="title">Movie Title:</label>
                <input type="text" id="title" name="title" value="<%= selectedMovie.getTitle() %>" required>
            </div>

            <div class="form-group">
                <label for="year">Year Released:</label>
                <select id="year" name="year" class="form-select" required>
                    <% 
                        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                        for (int i = currentYear; i >= 1888; i--) { 
                    %>
                        <option value="<%= i %>" <%= (i == selectedMovie.getYear()) ? "selected" : "" %>><%= i %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label for="genreSelect">Genre:</label>
                <select id="genreSelect" class="form-select" onchange="handleDynamicSelect(this, 'customGenreInput', 'realGenrePayload')">
                    <%
                        boolean genreFound = false;
                        if (distinctGenres != null) {
                            for (String g : distinctGenres) {
                                boolean isSelected = g.equalsIgnoreCase(selectedMovie.getGenre());
                                if (isSelected) genreFound = true;
                    %>
                                <option value="<%= g %>" <%= isSelected ? "selected" : "" %>><%= g %></option>
                    <%
                            }
                        }
                    %>
                    <option value="NEW" <%= !genreFound ? "selected" : "" %>>-- Add New Genre --</option>
                </select>

                <input type="text" id="customGenreInput" class="custom-input" placeholder="Type new genre here..." 
                       value="<%= !genreFound ? selectedMovie.getGenre() : "" %>"
                       style="<%= !genreFound ? "display:block;" : "display:none;" %>"
                       oninput="syncCustomInput(this, 'realGenrePayload')">

                <input type="hidden" name="genre" id="realGenrePayload" value="<%= selectedMovie.getGenre() %>">
            </div>

            <div class="form-group">
                <label for="directorSelect">Director:</label>
                <select id="directorSelect" class="form-select" onchange="handleDynamicSelect(this, 'customDirectorInput', 'realDirectorPayload')">
                    <%
                        boolean directorFound = false;
                        if (distinctDirectors != null) {
                            for (String d : distinctDirectors) {
                                boolean isSelected = d.equalsIgnoreCase(selectedMovie.getDirector());
                                if (isSelected) directorFound = true;
                    %>
                                <option value="<%= d %>" <%= isSelected ? "selected" : "" %>><%= d %></option>
                    <%
                            }
                        }
                    %>
                    <option value="NEW" <%= !directorFound ? "selected" : "" %>>-- Add New Director --</option>
                </select>

                <input type="text" id="customDirectorInput" class="custom-input" placeholder="Type new director here..." 
                       value="<%= !directorFound ? selectedMovie.getDirector() : "" %>"
                       style="<%= !directorFound ? "display:block;" : "display:none;" %>"
                       oninput="syncCustomInput(this, 'realDirectorPayload')">

                <input type="hidden" name="director" id="realDirectorPayload" value="<%= selectedMovie.getDirector() %>">
            </div>

            <div class="button-group">
                <a href="module8_update_select.jsp" class="cancel-btn">Cancel</a>
                <input type="submit" value="Update Record" class="submit-btn update-btn disabled-btn" disabled>
            </div>
            
        </form>
    
    <% } else { %>
        <p class="error-message"><%= errorMsg.isEmpty() ? "Record not found." : errorMsg %></p>
        <div class="center-text">
            <a href="module8_update_select.jsp" class="return-link">Go Back to Selection</a>
        </div>
    <% } %>

</div>

<div class="return-container">
    <a class="return-link" href="index.jsp">Return to Index</a>
</div>

</body>
</html>