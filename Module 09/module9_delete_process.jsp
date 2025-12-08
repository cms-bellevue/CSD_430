<%@ page import="csd430.beans.MovieDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
Clint Scott
CSD 430
Module 9 - Project Part 4
12/07/2025

This JSP processes the Soft Delete, Restore, and Hard Delete logic 
and redirects the user with a confirmation message.
It includes validation to prevent restoring duplicates.
--%>

<%
    request.setCharacterEncoding("UTF-8");
    String redirectPage = "module9_delete_select.jsp";
    String message = "";
    String msgClass = "";

    String idParam = request.getParameter("id");
    String action = request.getParameter("action"); 
    
    if (action == null || action.isEmpty() || 
        (!action.equals("HARD_DELETE_ALL") && !action.equals("RESTORE_ALL") && (idParam == null || idParam.isEmpty()))) {
        message = "Error: Invalid request or missing parameters.";
        msgClass = "error-message";
        response.sendRedirect(redirectPage + "?msg=" + URLEncoder.encode(message, "UTF-8") + "&class=" + msgClass);
        return;
    }
    
    int movieId = -1;
    try {
        MovieDAO dao = new MovieDAO();
        boolean actionSuccess = false;
        if (!action.equals("HARD_DELETE_ALL") && !action.equals("RESTORE_ALL")) {
            movieId = Integer.parseInt(idParam);
        }

        switch (action) {
            case "SOFT_DELETE":
                actionSuccess = dao.softDeleteMovie(movieId);
                if (actionSuccess) {
                    message = "Success! Record ID " + movieId + " has been moved to the Recycle Bin.";
                    msgClass = "success-message";
                } else {
                    message = "Error: Soft Delete failed. Record may not exist.";
                    msgClass = "error-message";
                }
                redirectPage = "module9_delete_select.jsp";
                break;

            case "RESTORE":
                // 1. Get the title of the movie we are trying to restore
                String titleToRestore = dao.getMovieTitleById(movieId);
                
                // 2. Check if this title is already active
                if (dao.isTitleActive(titleToRestore)) {
                    message = "Error: A movie with the title '" + titleToRestore + "' is already active in the list.";
                    msgClass = "error-message";
                    actionSuccess = false; 
                } else {
                    // 3. Safe to restore
                    actionSuccess = dao.restoreMovie(movieId);
                    if (actionSuccess) {
                        message = "Success! Record ID " + movieId + " has been restored to Active Records.";
                        msgClass = "success-message";
                    } else {
                        message = "Error: Restore failed. Record may not exist or was already active.";
                        msgClass = "error-message";
                    }
                }
                redirectPage = "module9_recycle_bin.jsp";
                break;

            case "RESTORE_ALL":
                actionSuccess = dao.restoreAllDeletedMovies();
                if (actionSuccess) {
                    message = "Success! All records in the Recycle Bin have been restored to Active Records.";
                    msgClass = "success-message";
                } else {
                    message = "Error: The Recycle Bin was empty or restore failed.";
                    msgClass = "error-message";
                }
                redirectPage = "module9_recycle_bin.jsp";
                break;
                
            case "HARD_DELETE":
                actionSuccess = dao.hardDeleteMovie(movieId);
                if (actionSuccess) {
                    message = "Success! Record ID " + movieId + " has been PERMANENTLY DELETED.";
                    msgClass = "success-message";
                } else {
                    message = "Error: Permanent Delete failed. Record may not exist.";
                    msgClass = "error-message";
                }
                redirectPage = "module9_recycle_bin.jsp";
                break;
                
            case "HARD_DELETE_ALL":
                actionSuccess = dao.hardDeleteAllDeletedMovies();
                if (actionSuccess) {
                    message = "Success! The Recycle Bin has been PERMANENTLY EMPTIED.";
                    msgClass = "success-message";
                } else {
                    message = "Error: The Recycle Bin was already empty or deletion failed.";
                    msgClass = "error-message";
                }
                redirectPage = "module9_recycle_bin.jsp";
                break;
                
            default:
                message = "Error: Unknown action requested.";
                msgClass = "error-message";
                redirectPage = "module9_delete_select.jsp";
                break;
        }

    } catch (NumberFormatException e) {
        message = "Error: Invalid ID format.";
        msgClass = "error-message";
        redirectPage = "module9_delete_select.jsp"; 
    } catch (SQLException e) {
        message = "Database Error during " + action + ": " + e.getMessage();
        msgClass = "error-message";
        redirectPage = (action.equals("RESTORE") || action.equals("HARD_DELETE") || action.equals("HARD_DELETE_ALL") || action.equals("RESTORE_ALL")) 
                       ? "module9_recycle_bin.jsp" : "module9_delete_select.jsp";
    }

    response.sendRedirect(redirectPage + "?msg=" + URLEncoder.encode(message, "UTF-8") + "&class=" + msgClass);
%>