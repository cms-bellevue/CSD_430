<%--
Clint Scott
CSD 430
M4 – JavaBean Example (Wyoming Memories)
11/09/2025

This JSP page demonstrates using a JavaBean (MemoryBean) to store and display
data dynamically in an HTML table. The page:
- Creates several MemoryBean objects and stores them in an ArrayList
- Iterates through the list using JSP scriptlets
- Displays the data in a clean, formatted table using external CSS
- Includes five data fields per record: place, state, activity, description and year

All Java code is kept inside scriptlets, and all HTML remains outside for clarity.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, wyoming.MemoryBean" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Wyoming Memories Data Display</title>
  <link rel="stylesheet" href="css/formStyle.css">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
</head>
<body>
  <div class="container">
    <h1>Memories of Wyoming and the Surrounding Region</h1>
    <p class="intro-description">
      This page uses a JavaBean (MemoryBean) that contains five distinct data fields for each personal memory record.
      The data is dynamically generated and displayed in this nicely formatted HTML table.
    </p>

    <%
      List<MemoryBean> memories = new ArrayList<>();
      memories.add(new MemoryBean("Green River", "WY", "Home", "Where we lived and made lifelong memories. Never wanted to leave.", "1979–1983"));
      memories.add(new MemoryBean("Rock Springs", "WY", "Shopping", "Visited local shops and the mall on weekends for essentials and fun.", "1979–1983"));
      memories.add(new MemoryBean("Yellowstone Park", "WY", "Camping", "Watched geysers and wildlife during family trips in the summer.", "1980-1982"));
      memories.add(new MemoryBean("Salt Lake City", "UT", "Travel", "Explored historic buildings and downtown attractions.", "1981"));
      memories.add(new MemoryBean("Disneyland", "CA", "Vacation", "Enjoyed rides and family fun on our big trip before moving back East.", "1982"));
    %>

    <table>
      <caption>Favorite Places and Memories Data Summary (Expanded to 5 Fields)</caption>
      <thead>
        <tr>
          <th>Place</th>
          <th>State</th>
          <th>Activity</th>
          <th>Description</th>
          <th>Year</th>
        </tr>
      </thead>
      <tbody>
        <%
          for (MemoryBean m : memories) {
        %>
        <tr>
          <td><%= m.getPlace() %></td>
          <td><%= m.getState() %></td>
          <td><%= m.getActivity() %></td>
          <td><%= m.getDescription() %></td>
          <td><%= m.getYear() %></td>
        </tr>
        <%
          }
        %>
      </tbody>
    </table>

    <p class="footer">
      All data generated dynamically using JSP and a JavaBean.
      Author: <a href="#">Clint Scott</a>
    </p>
  </div>
</body>
</html>
