<%-- 
Clint Scott
CSD 430
M4 – JavaBean Example (Wyoming Memories)
11/09/2025

This JSP page demonstrates using a JavaBean to hold memory data and display it
in a dynamic HTML table. The page creates several MemoryBean objects, stores
them in an ArrayList, and iterates through them using JSP scriptlets.
All Java code is kept inside scriptlets, and all HTML remains outside.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, wyoming.MemoryBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Wyoming Memories (1979–1983)</title>
    <link rel="stylesheet" href="css/formStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1>Memories of Wyoming (1979–1983)</h1>

    <p class="intro-description">
        This page uses a JavaBean (MemoryBean) to represent each personal memory record.
        Data is dynamically generated and displayed in a structured HTML table.
    </p>

    <%
        // Create a list to store MemoryBean objects
        List<MemoryBean> memories = new ArrayList<>();

        // Populate the list with sample data
        memories.add(new MemoryBean("Green River", "Home", "Where we lived and made lifelong memories."));
        memories.add(new MemoryBean("Rock Springs", "Shopping", "Visited stores and local shops on weekends."));
        memories.add(new MemoryBean("Yellowstone National Park", "Camping", "Watched geysers and wildlife during summer trips."));
        memories.add(new MemoryBean("Salt Lake City", "Travel", "Explored historic buildings and downtown attractions."));
        memories.add(new MemoryBean("Disneyland", "Vacation", "Enjoyed rides and family fun on our big trip."));
    %>

    <table>
        <caption>Favorite Places and Memories</caption>
        <thead>
            <tr>
                <th>Place</th>
                <th>Activity</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (MemoryBean m : memories) {
            %>
            <tr>
                <td><%= m.getPlace() %></td>
                <td><%= m.getActivity() %></td>
                <td><%= m.getDescription() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <p class="footer">
        All data generated dynamically using JSP and a JavaBean.<br>
        Author: <a href="#">Clint Scott</a>
    </p>
</div>
</body>
</html>