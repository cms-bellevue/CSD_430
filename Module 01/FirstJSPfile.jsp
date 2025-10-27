<%--
Clint Scott
CSD 430
M1 – JSP Setup: A Journey in Configuration
10/26/2025

This introductory JSP page is set up to verify that the Java, Jakarta-Tomcat,
and Eclipse environment is configured correctly. The page confirms proper JSP
operation by dynamically displaying the current date and time. It also contains
some humorously reflective comments on the initial setup process.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP Setup - A Journey in Configuration</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>JSP Environment Verification: Success!</h2>
        <p>Current date and time:
            <strong><%= new Date() %></strong>
        </p>

        <div class="confession-box">
            <h3>Reflections on Configuration</h3>
            <p>
                <b>Successfully reaching this point feels like a significant accomplishment.</b> 🚩
            </p>
            <p>
                Honestly, the initial environment setup was quite challenging. I had moments where I felt very frustrated with the technical complexity.
                I'm committed to finishing my degree, so troubleshooting was the only path forward!
            </p>
            <p>
                Key challenges during the setup included:
            </p>
            <ol>
                <li>Starting with Tomcat 9 based on earlier instructions.</li>
                <li>Realizing the need to upgrade to Tomcat 10.1 for Jakarta compatibility due to Java EE specification changes.</li>
                <li>Working through persistent issues like Java version mismatches and port conflicts (specifically the missing Admin Port).</li>
            </ol>

            <p>
                While the process required a lot of unexpected effort, solving these errors was a solid lesson in persistence.
                It did take up a significant amount of weekend time, which wasn't ideal.
                An updated, streamlined setup guide would certainly make the initial experience smoother for everyone.
            </p>
        </div>
        <p class="status-message"><b>The page is now running correctly through Apache Tomcat in Eclipse.</b></p>
    </div>
</body>
</html>