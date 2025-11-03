<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
Clint Scott
CSD 430
M3 – Working with JSP Forms
11/02/2025

This JSP page displays the character information submitted from the Character Creation form.
It retrieves form parameters using Java scriptlets and presents them in a formatted HTML table.
The password field is masked for security, and checkbox values are interpreted as Yes/No.
Users can review all entered details and return to the character creation form to add another
character. External CSS is used to maintain a consistent, clean layout with the form page.
--%>
<!DOCTYPE html>
<html>
<head>
    <title>Fallen Night – Character Summary</title>
    <link rel="stylesheet" href="css/formStyle.css">
</head>

<body>
    <div class="container">
        <h1>Fallen Night Character Created</h1>
        <p>Your new character has been created successfully. Review the details below.</p>

        <%
            String charName = request.getParameter("charName");
            String race = request.getParameter("race");
            String charClass = request.getParameter("class");
            String gender = request.getParameter("gender");
            String password = request.getParameter("password");
            String realName = request.getParameter("realName");
            String email = request.getParameter("email");
            String background = request.getParameter("background");
            String keepPrivate = request.getParameter("keepPrivate");
            
            // Scriptlet to mask the password for display
            String maskedPassword = "";
            if (password != null) {
                for (int i = 0; i < password.length(); i++) {
                    maskedPassword += "*";
                }
            }
        %>

        <table>
            <tr><th>Field</th><th>Value</th></tr>
            <tr><td>Character Name</td><td><%= charName %></td></tr>
            <tr><td>Race</td><td><%= race %></td></tr>
            <tr><td>Class</td><td><%= charClass %></td></tr>
            <tr><td>Gender</td><td><%= gender %></td></tr>
            <tr><td>Password</td><td><%= maskedPassword %></td></tr>
            <tr><td>Real Name</td><td><%= realName %></td></tr>
            <tr><td>Email</td><td><%= email %></td></tr>
            <tr><td>Keep Personal Info Private</td><td><%= (keepPrivate != null ? "Yes" : "No") %></td></tr>
            <tr><td>Background</td><td><%= background %></td></tr>
        </table>

        <p><a href="characterForm.jsp" class="return-link">Create Another Character</a></p>

        <footer>
            <p>© 2025 Fallen Night MUD – All Rights Reserved</p>
        </footer>
    </div>
</body>
</html>