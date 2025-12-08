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

This JSP displays soft-deleted records and allows the user to Restore 
or Permanently Delete (Hard Delete) them.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 9 Recycle Bin</title>
    <link rel="stylesheet" type="text/css" href="css/module9_delete_style.css">
    <script src="js/sortTable.js"></script>
</head>
<body>

<h2 class="delete-header">Module 9 - Project Part 4: Recycle Bin</h2>

<div class="form-container delete-container">
    <h3 class="delete-header">Soft-Deleted Records</h3>
    
    <%
        MovieDAO dao = new MovieDAO();
        List<Movie> deletedMovieKeys = null;
        String message = request.getParameter("msg") != null ? request.getParameter("msg") : "";
        String msgClass = request.getParameter("class") != null ? request.getParameter("class") : "";
        try {
            deletedMovieKeys = dao.getAllDeletedMovieKeys();
        } catch (SQLException e) {
            message = "Database Error: " + e.getMessage();
            msgClass = "error-message";
        }
    %>
    
    <% if (!message.isEmpty()) { %>
        <p class="<%= msgClass %>"><%= message %></p>
    <% } %>

    <% if (deletedMovieKeys != null && !deletedMovieKeys.isEmpty()) { %>
        <table class="data-table sortable" id="moviesTable"> 
            <thead>
                <tr class="delete-table">
         
                    <th onclick="sortTable(0)">ID</th>
                    <th onclick="sortTable(1)">Title</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
       
                 <% for (Movie m : deletedMovieKeys) { %>
                    <tr>
                        <td><%= m.getId() %></td>
                        <td><%= m.getTitle() %></td>
            
                        <td>Soft-Deleted</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p class="instruction-text success-message margin-bottom-20">The Recycle Bin is empty.
No records to display.</p>
    <% } %>

    <hr class="separator-sm">

    <div class="recycle-grid">
        
        <%-- Restore Column --%>
        <div>
            <h3 class="restore-header">Restore Record</h3>
            <p class="instruction-text">Select a movie to move it back to the Active Records list.</p>
            
  
            <form action="module9_delete_process.jsp" method="post">
                <div class="form-group">
                    <label for="restoreId">Select Movie to Restore:</label>
                    <select id="restoreId" name="id" class="form-select" required <%= deletedMovieKeys == null ||
deletedMovieKeys.isEmpty() ? "disabled" : "" %>>
                        <option value="" disabled selected>-- Select a Movie to Restore --</option>
                        <%
                            if (deletedMovieKeys != null) {
      
                                for (Movie m : deletedMovieKeys) {
                        %>
                                    <option value="<%= m.getId() %>"><%= m.getTitle() %> (ID: <%= m.getId() %>)</option>
                        <%
                                }
                            }
                
                        %>
                    </select>
                </div>
                
                <input type="hidden" name="action" value="RESTORE">
                <input type="submit" value="Restore Record" class="submit-btn restore-btn" 
                       <%= deletedMovieKeys == null ||
deletedMovieKeys.isEmpty() ? "disabled" : "" %>>
            </form>

            <hr class="separator-lg">

            <%-- Restore All Form --%>
            <h3 class="restore-header">Restore All Records</h3>
            <p class="instruction-text">Restore <strong>ALL</strong> soft-deleted records to the Active Records list.</p>
            
  
            <form action="module9_delete_process.jsp" method="post" onsubmit="return confirm('Are you sure you want to restore all items from the Recycle Bin?');">
                <input type="hidden" name="action" value="RESTORE_ALL">
                <input type="submit" value="Restore All Records" class="submit-btn restore-btn" 
                       <%= deletedMovieKeys == null ||
deletedMovieKeys.isEmpty() ? "disabled" : "" %>>
            </form>
        </div>

        <%-- Permanent Delete Column --%>
        <div>
            <h3 class="delete-header">Permanently Delete Record (Irreversible)</h3>
            
            <p class="permanent-warning">Permanently removes the record from the database.</p>
        
            
            <form action="module9_delete_process.jsp" method="post" onsubmit="return confirm('ARE YOU ABSOLUTELY SURE you want to permanently delete record ID ' + document.getElementById('hardDeleteId').value + '? This action is irreversible.');">
                <div class="form-group">
                    <label for="hardDeleteId">Select Movie for Permanent Deletion:</label>
                   
                    <select id="hardDeleteId" name="id" class="form-select" required <%= deletedMovieKeys == null || deletedMovieKeys.isEmpty() ?
"disabled" : "" %>>
                        <option value="" disabled selected>-- Select a Movie to Permanently Delete --</option>
                        <%
                            if (deletedMovieKeys != null) {
       
                                for (Movie m : deletedMovieKeys) {
                        %>
                                    <option value="<%= m.getId() %>"><%= m.getTitle() %> (ID: <%= m.getId() %>)</option>
 
                        <%
                                }
                            }
                 
                        %>
                    </select>
                </div>
                
                <input type="hidden" name="action" value="HARD_DELETE">
                <input type="submit" value="Permanently Delete" class="submit-btn hard-delete-btn individual" 
                       <%= deletedMovieKeys == null ||
deletedMovieKeys.isEmpty() ? "disabled" : "" %>>
            </form>

            <hr class="separator-lg">
            
            <h3 class="delete-header">Empty Recycle Bin (Hard Delete All)</h3>
            
            <p class="permanent-warning">Permanently removes ALL soft-deleted records.</p>
       
            
            <form action="module9_delete_process.jsp" method="post" onsubmit="return confirm('ARE YOU SURE you want to PERMANENTLY delete ALL soft-deleted records? This action cannot be undone.');">
                
                <input type="hidden" name="action" value="HARD_DELETE_ALL">
                <input type="submit" value="Empty Recycle Bin" class="submit-btn hard-delete-btn" 
      
                        <%= deletedMovieKeys == null ||
deletedMovieKeys.isEmpty() ? "disabled" : "" %>>
            </form>
        </div>

    </div>

</div>

<div class="return-container">
    <a class="return-link btn-blue" href="module9_delete_select.jsp">Go Back to Active Records</a>
    <a class="return-link margin-left-10" href="index.jsp">Return to Index</a>
</div>

</body>
</html>