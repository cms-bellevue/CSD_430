<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 8 - Project Part 3
11/30/2025

index.jsp - Main dashboard for CRUD operations.
--%>

<!DOCTYPE html>
<html>
<head>
    <title>CSD 430: Server Side Development</title>
    <link rel="stylesheet" type="text/css" href="css/index_style.css">
</head>
<body>
    <div class="container">
        <h1>CSD 430: Server Side Development</h1>
        
        <div class="crud-banner">
            <p>This application demonstrates full database management using <strong>Java JDBC</strong> and <strong>JavaBeans</strong>.</p>
            
            <div class="crud-grid">
                <div class="crud-item create">
                    <span class="icon">➕</span>
                    <span class="label"><span class="first-letter">C</span>REATE</span>
                </div>
                <div class="crud-item read">
                    <span class="icon">📂</span>
                    <span class="label"><span class="first-letter">R</span>EAD</span>
                </div>
                <div class="crud-item update">
                    <span class="icon">✏️</span>
                    <span class="label"><span class="first-letter">U</span>PDATE</span>
                </div>
                <div class="crud-item delete">
                    <span class="icon">❌</span>
                    <span class="label"><span class="first-letter">D</span>ELETE</span>
                </div>
            </div>
        </div>

        <hr>

        <div class="module-section">
            <h3>📂 READ Operations (Modules 5 & 6)</h3>
            <p>View existing data in the database.</p>
            <ul>
                <li><a href="module5_read.jsp"><strong>Full List:</strong> View all current records</a></li>
                <li><a href="module6_select.jsp"><strong>Search:</strong> Select record by Title (uses Key/ID)</a></li>
            </ul>
        </div>

        <div class="module-section">
            <h3>➕ CREATE Operations (Module 7)</h3>
            <p>Add new data to the system.</p>
            <ul>
                <li><a href="module7_create.jsp"><strong>Insert:</strong> Create a New Record</a></li>
            </ul>
        </div>

        <div class="module-section">
            <h3>✏️ UPDATE Operations (Module 8)</h3>
            <p>Modify existing data.</p>
            <ul>
                <li><a href="module8_update_select.jsp"><strong>Edit:</strong> Update an existing Record</a></li>
            </ul>
        </div>
        
        <footer>
            <p><em>Developed by Clint Scott for CSD 430</em></p>
        </footer>
    </div>
</body>
</html>