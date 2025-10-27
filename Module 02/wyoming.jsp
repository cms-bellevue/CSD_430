<%--
Clint Scott
CSD 430
M2 – Dynamic JSP Scriptlet Example (Wyoming Memories)
10/26/2025

This JSP page demonstrates the use of Java scriptlets to dynamically generate
an HTML table containing personal records from my time living in Wyoming (1979–1983).
The table data is created in Java and rendered as HTML, with each record including
a place, activity, and short description. External CSS is used to apply a clean,
modern layout similar to the previous JSP setup demonstration page.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Wyoming Memories (1979–1983)</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>Memories of Wyoming (1979–1983)</h1>
        <p class="intro-description">
            This page dynamically generates a table using JSP scriptlets to display memories and experiences
            from my time living in Wyoming between 1979 and 1983. Each record highlights a favorite place,
            activity, and a short description.
        </p>

        <%
            class Memory {
                String place;
                String activity;
                String description;

                Memory(String place, String activity, String description) {
                    this.place = place;
                    this.activity = activity;
                    this.description = description;
                }
            }

            Memory[] memories = {
                new Memory("Green River", "Home", "Where we lived and made lifelong memories."),
                new Memory("Rock Springs", "Shopping", "Visited stores and local shops on weekends."),
                new Memory("Yellowstone National Park", "Camping", "Watched geysers and wildlife during summer trips."),
                new Memory("Salt Lake City", "Travel", "A memorable trip checking out the historic buildings downtown."),
                new Memory("Disneyland", "Vacation", "Took a memorable trip filled with rides and family fun.")
            };
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
                    for (Memory m : memories) {
                %>
                <tr>
                    <td><%= m.place %></td>
                    <td><%= m.activity %></td>
                    <td><%= m.description %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <p class="footer">
            All data generated dynamically using JSP Scriptlets.<br>
            Author: <a href="#">Clint Scott</a>
        </p>
    </div>
</body>
</html>