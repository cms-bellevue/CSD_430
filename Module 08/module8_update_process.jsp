<%@ page import="csd430.beans.Movie" %>
<%@ page import="csd430.beans.MovieDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 8 Project Part 3
11/30/2025

This JSP processes the update logic and displays the result table.
It handles both successful updates and cancelled updates (due to no changes)
by displaying the record data in a consistent table format.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 8 Update Result</title>
    <link rel="stylesheet" type="text/css" href="css/module8_update_style.css">
</head>
<body>

<h2>Module 8 - Project Part 3: Update Confirmation</h2>

<jsp:useBean id="movieDAO" class="csd430.beans.MovieDAO" scope="page" />
<jsp:useBean id="updateMovie" class="csd430.beans.Movie" scope="page" />
<jsp:setProperty property="*" name="updateMovie" />

<%
    String message = "";
    String msgClass = "";
    String tableHeader = "";
    boolean showTable = false;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            // Fetch current DB record to compare against form data
            Movie currentDbRecord = movieDAO.getMovieById(updateMovie.getId());

            if (currentDbRecord != null) {
                // Compare fields ignoring case for strings to prevent duplicate submissions
                boolean titleSame = currentDbRecord.getTitle().trim().equalsIgnoreCase(updateMovie.getTitle().trim());
                boolean yearSame = currentDbRecord.getYear() == updateMovie.getYear();
                boolean genreSame = currentDbRecord.getGenre().trim().equalsIgnoreCase(updateMovie.getGenre().trim());
                boolean directorSame = currentDbRecord.getDirector().trim().equalsIgnoreCase(updateMovie.getDirector().trim());

                if (titleSame && yearSame && genreSame && directorSame) {
                    // No changes detected, so we cancel the DB call but still show the table
                    message = "Update cancelled. No changes detected (the database already matches this data).";
                    msgClass = "error-message"; 
                    tableHeader = "Current Record Details";
                    showTable = true; 
                } else {
                    // Changes detected, attempt update
                    boolean updateSuccess = movieDAO.updateMovie(updateMovie);
                    if (updateSuccess) {
                        message = "Success! Record updated successfully.";
                        msgClass = "success-message"; 
                        tableHeader = "Updated Record Details";
                        showTable = true;
                    } else {
                        message = "Error: Update failed. Record ID may not exist.";
                        msgClass = "error-message";
                        showTable = false;
                    }
                }
            } else {
                message = "Error: Original record not found.";
                msgClass = "error-message";
                showTable = false;
            }

        } catch (SQLException e) {
            message = "Database Error: " + e.getMessage();
            msgClass = "error-message";
            showTable = false;
        }
    } else {
        message = "Error: Invalid Request Method.";
        msgClass = "error-message";
        showTable = false;
    }
%>

<div class="result-container">
    <p class="<%= msgClass %>"><%= message %></p>

    <% if (showTable) { %>
        <h3><%= tableHeader %></h3>
        
        <table class="data-table">
            <thead>
                <tr>
                    <th>Field Name</th>
                    <th>Value</th>
                    <th>Data Type</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>ID</strong></td>
                    <td><%= updateMovie.getId() %></td>
                    <td>Integer (PK)</td>
                </tr>
                <tr>
                    <td><strong>Title</strong></td>
                    <td><%= updateMovie.getTitle() %></td>
                    <td>String</td>
                </tr>
                <tr>
                    <td><strong>Year</strong></td>
                    <td><%= updateMovie.getYear() %></td>
                    <td>Integer</td>
                </tr>
                <tr>
                    <td><strong>Genre</strong></td>
                    <td><%= updateMovie.getGenre() %></td>
                    <td>String</td>
                </tr>
                <tr>
                    <td><strong>Director</strong></td>
                    <td><%= updateMovie.getDirector() %></td>
                    <td>String</td>
                </tr>
            </tbody>
        </table>
    <% } %>
</div>

<div class="return-container">
    <a class="return-link" href="module8_update_select.jsp">Update Another Record</a>
    <a class="return-link" href="index.jsp" style="margin-left: 10px;">Return to Index</a>
</div>

</body>
</html>