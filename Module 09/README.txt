Clint Scott
CSD 430 - Server Side Software Development
Module 9 - Project Part 4
Date: 12/07/2025

================================================================================
PROJECT OVERVIEW: MOVIE DATABASE MANAGEMENT SYSTEM
================================================================================
This application is a CRUD (Create, Read, Update, Delete) management system 
architected using Java Server Pages (JSP), JDBC, and JavaBeans. The system 
interfaces with a MySQL backend (`clint_movies_data`) to provide persistent 
storage for a movie library.
Architecture: MVC (Model-View-Controller) pattern utilizing DAOs for data 
abstraction and Beans for data transfer objects (DTOs).

================================================================================
MODULE 9 RELEASE NOTES (Soft-Delete Functionality)
================================================================================
This release implements the "Delete" module of the CRUD stack using a 
non-destructive soft-delete pattern (Recycle Bin).

Key Features & Implementation Details:

1. Data Model & Access (Movie.java, MovieDAO.java)
   - Manual Database Update: The column `is_deleted` was added to the 
     `clint_movies_data` table using the following SQL:
     `ALTER TABLE clint_movies_data ADD COLUMN is_deleted TINYINT(1) NOT NULL DEFAULT 0;`
   - Added an 'is_deleted' flag (BOOLEAN) to the Movie JavaBean model.
   - All standard read operations are now filtered to exclude soft-deleted 
     records (`WHERE is_deleted = 0`).
   - DAO logic (`getAllMoviesSortedByTitle()`) was added to manage sorting 
     conflicts, ensuring the Create page (`id DESC`) and Delete page (`title 
     ASC`) maintain correct default order.
   - Added validation logic (`isTitleActive`) to prevent restoring a movie if 
     an active movie with the same title already exists.

2. Delete Selection View (module9_delete_select.jsp)
   - Layout: Designed as a responsive 2-column grid. The "Active Records 
     List" is displayed side-by-side with the "Soft Delete Form".
   - UX: Includes sortable tables with clickable header hover effects for 
     better usability.
   - Navigation: Provides direct access to the Recycle Bin.
   - Fix: Ensured empty table state preserves table headers (`thead`).

3. Recycle Bin View (module9_recycle_bin.jsp)
   - Layout: Designed as a responsive 2-column grid separating Restore 
     actions (Left Column) from Destructive actions (Right Column).
   - Restore All: Added functionality to batch restore all soft-deleted items.
   - Hard Delete All: Added "Empty Recycle Bin" functionality to permanently 
     remove all soft-deleted items.
   - UI Consistency: Warning messages for irreversible actions are styled 
     with bolding and a warning icon (`⚠️`) and use a consistent confirmation 
     prompt.

4. Processing Logic (module9_delete_process.jsp)
   - Handles the routing and execution for five distinct actions: 
     `SOFT_DELETE`, `RESTORE`, `RESTORE_ALL`, `HARD_DELETE`, and 
     `HARD_DELETE_ALL`.
   - Validates requests and redirects to the appropriate view (Select vs. Bin) 
     based on the action performed.
   - Intercepts Restore requests to enforce duplicate prevention logic.

5. Application Dashboard (index.jsp)
   - Layout Optimization: The main menu was reorganized into a compact, 
     responsive 2x2 grid to display all CRUD operations (Create, Read, Update, 
     Delete) simultaneously without scrolling.
	 
================================================================================
VERSION HISTORY & COMPONENTS
================================================================================

v1.0 - READ OPERATIONS (Modules 5 & 6)
- Core DAO implementation with secure connection handling.
- "Select All" and "Search by ID" functionality.

v2.0 - CREATE OPERATIONS (Module 7)
- Insert functionality with duplicate detection logic (Title + Director + Year).
- Implementation of the "Add New" dropdown pattern.

v3.0 - UPDATE OPERATIONS (Module 8)
- Implementation of the Update function, including data binding, integrity 
  protection, and client-side validation.

v4.0 - DELETE OPERATIONS (Module 9)
- Implementation of Soft Delete, Restore, and Hard Delete functionality.

TECHNOLOGY STACK
- Frontend: JSP, CSS3, JavaScript (DOM manipulation)
- Backend: Java (JDK 8+), JDBC
- Database: MySQL
- Security: Parameterized queries (PreparedStatement) for SQL injection 
  prevention.