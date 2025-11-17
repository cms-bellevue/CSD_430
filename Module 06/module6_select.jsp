<%-- File: module6_select.jsp --%>
<%@ page import="csd430.beans.Movie" %>
<%@ page import="csd430.beans.MovieDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 6 Project Part 1 Assignment
11/16/2025

This JSP file displays a form with a dropdown list of movie keys and, after
submission, displays the selected movie record. It uses the MovieDAO bean to
select a record by its unique ID key.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 6 Select Record</title>
    <link rel="stylesheet" type="text/css" href="css/module6_select_style.css">
</head>
<body>

<h2>Module 6 Project Part 1 Select Movie Record</h2>

<%-- Define DAO bean for database access --%>
<jsp:useBean id="movieDAO" class="csd430.beans.MovieDAO" scope="page" />

<%-- Form submission and record lookup logic --%>
<%
    Movie selectedMovie = null;
    String selectedIdStr = request.getParameter("movieId");
    String errorMessage = null;

    if (selectedIdStr != null && !selectedIdStr.isEmpty()) {
        try {
            int selectedId = Integer.parseInt(selectedIdStr);
            selectedMovie = movieDAO.getMovieById(selectedId);

            if (selectedMovie == null) {
                errorMessage = "Could not find movie with ID " + selectedId;
            }

        } catch (NumberFormatException e) {
            errorMessage = "Invalid ID format";
        } catch (SQLException e) {
            errorMessage = "Database error " + e.getMessage();
        } catch (Exception e) {
            errorMessage = "Unexpected error " + e.getMessage();
        }
    }
%>

<%-- Record selection form. Applied class 'select-form-container' --%>
<div class="select-form-container">
    <h3>Select a Movie to View Details</h3>

    <form action="module6_select.jsp" method="get">
        <label for="movieId" class="form-label">
            Movie Title with ID as the Key
        </label>

        <select name="movieId" id="movieId" class="form-select">
            <option value="">-- Select Movie --</option>

            <%
            try {
                List<Movie> movieKeys = movieDAO.getAllMovieKeys();

                for (Movie movieKey : movieKeys) {
            %>
                <option value="<%= movieKey.getId() %>">
                    <%= movieKey.getTitle() %> (ID: <%= movieKey.getId() %>)
                </option>
            <%
                }
            } catch (SQLException e) {
                errorMessage = "Database error loading movie keys " + e.getMessage();
            }
            %>

        </select>

        <input type="submit" value="View Record" class="form-submit-button">
    </form>
</div>

<%-- Display error message --%>
<%
if (errorMessage != null) {
%>
    <p class="error-message">Error: <%= errorMessage %></p>
<%
}
%>

<%-- Display selected record --%>
<%
if (selectedMovie != null) {
%>
<div class="detail-box">
    <h3>Record Details for <%= selectedMovie.getTitle() %></h3>
    <p>This data record was retrieved from the CSD430 database using the unique ID key.</p>

    <table class="compact-table">

        <thead>
            <tr>
                <th>Field</th>
                <th>Value</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>ID Primary Key</td>
                <td><%= selectedMovie.getId() %></td>
            </tr>
            <tr>
                <td>Title</td>
                <td><%= selectedMovie.getTitle() %></td>
            </tr>
            <tr>
                <td>Year</td>
                <td><%= selectedMovie.getYear() %></td>
            </tr>
            <tr>
                <td>Genre</td>
                <td><%= selectedMovie.getGenre() %></td>
            </tr>
            <tr>
                <td>Director</td>
                <td><%= selectedMovie.getDirector() %></td>
            </tr>
        </tbody>
    </table>
</div>
	
<%
}
%>

<br>

<div class="return-container">
    <a class="return-link" href="index.jsp">Return to Index</a>
</div>

</body>
</html>