<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 5 Assignment
11/16/2025

This JSP file performs a basic READ operation using JDBC.
It connects to the CSD430 database and displays all records from the clint_movies_data table.
The table supports sorting by clicking on column headers.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430 Module 5 CRUD READ</title>
    <link rel="stylesheet" type="text/css" href="css/module5_read_style.css">
    <script src="js/sortTable.js"></script>
</head>
<body>

<h2>Module 5 CRUD READ</h2>

<p class="sort-hint">Click any column header to sort the table.</p>

<%
    String url = "jdbc:mysql://localhost:3306/CSD430";
    String username = "student1";
    String password = "pass";
    String query = "SELECT * FROM clint_movies_data";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
%>

<table class="compact-table" id="moviesTable">
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
        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getInt("year") %></td>
            <td><%= rs.getString("genre") %></td>
            <td><%= rs.getString("director") %></td>
        </tr>
<%
        }
%>
    </tbody>
</table>

<%
    } catch (Exception e) {
%>
    <p class="error-message">Error: <%= e.getMessage() %></p>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ex) {}
        try { if (stmt != null) stmt.close(); } catch (Exception ex) {}
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>

<br>

<div class="return-container">
    <a class="return-link" href="index.jsp">Return to Index</a>
</div>

</body>
</html>