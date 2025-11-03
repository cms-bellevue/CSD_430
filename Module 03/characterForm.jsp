<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
Clint Scott
CSD 430
M3 – Working with JSP Forms
11/02/2025

This JSP page demonstrates a web form for creating a new character in the Fallen Night MUD.
It collects character information such as name, race, class, gender, and password, along with
optional personal information and a character background description.
Required fields are validated in the browser, and form data is submitted to displayCharacter.jsp
for processing and display.
External CSS is used to provide a clean, organized layout.
--%>
<!DOCTYPE html>
<html>
<head>
    <title>Fallen Night – Create New Character</title>
    <link rel="stylesheet" href="css/formStyle.css">
</head>

<body>
    <div class="container">
        <h1>Fallen Night: Character Creation</h1>
        <p>Create a new adventurer for the world of Fallen Night.<br><i>Fields marked with * are required.</i></p>

        <form action="displayCharacter.jsp" method="post">
            
            <fieldset>
            
            <legend>Character Information</legend>

                <label for="charName">* Character Name:</label>
                <input type="text" id="charName" name="charName" required><br>

                <label for="race">* Race:</label>
                <select id="race" name="race" required>                   
                    <option value="">Select Race</option>
                    <option>Human</option>
                    <option>Elf</option>
                    <option>Dwarf</option>
                    <option>Orc</option>                 
                    <option>Drow</option>
                </select><br>

                <label for="class">* Class:</label>
                <select id="class" name="class" required>
                    <option value="">Select Class</option>
                    <option>Warrior</option>  
                    <option>Mage</option>
                    <option>Rogue</option>
                    <option>Cleric</option>
                    <option>Ranger</option>
                </select><br>
      
                <label for="gender">* Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="">Select Gender</option>
                    <option>Male</option>
                    <option>Female</option>       
                </select><br>

                <label for="password">* Character Password:</label>
                <input type="password" id="password" name="password" required><br>
            </fieldset>

            <fieldset>
                <legend>Personal Information</legend>
           
                <label for="realName">Real Name:</label>
                <input type="text" id="realName" name="realName"><br>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email"><br>

                <label><input type="checkbox" name="keepPrivate" value="yes"> Keep personal info private</label><br>
            </fieldset>

   
            <fieldset>
                <legend>Character Background</legend>
                <textarea name="background" rows="5" cols="40" placeholder="Describe your character's history..."></textarea><br>
            </fieldset>

            <input type="reset" value="Reset Form">
            <input type="submit" value="Create Character">
        </form>
 
        <footer>
            <p>© 2025 Fallen Night MUD – All Rights Reserved</p>
        </footer>
    </div>
</body>
</html>