package csd430.beans;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Clint Scott
 * CSD 430
 * Module 8 Project Part 3
 * 11/30/2025
 *
 * Data Access Object (DAO) for the clint_movies_data table.
 * Handles all database interactions including Insert, Select, Update,
 * Validation (Duplicate Checks), Sanitization, and Credential Management.
 */
public class MovieDAO {

    // Database Connection Constants
    private final String url = "jdbc:mysql://localhost:3306/CSD430";
    private final String username = "student1";
    
    // Database Table Constant
    private static final String TABLE_NAME = "clint_movies_data";

    // Encrypted database password generated via SecurityUtil class.
    private final String encryptedPassword = "W9qR0admM1ZoSdNvza6RfA=="; 

    /**
     * Default Constructor.
     * Loads the MySQL JDBC Driver.
     */
    public MovieDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Error loading JDBC driver", e);
        }
    }

    /**
     * Helper method to decrypt the stored database password.
     * Used internally before establishing a connection.
     * @return The plain text password
     */
    private String getPassword() {
        return SecurityUtil.decrypt(encryptedPassword);
    }

    /**
     * Checks if a specific movie record already exists in the database.
     * @param title The movie title
     * @param director The movie director
     * @param year The release year
     * @return true if the exact record exists, false otherwise
     */
    public boolean movieExists(String title, String director, int year) throws SQLException {
        boolean exists = false;
        String query = "SELECT id FROM " + TABLE_NAME + " WHERE title = ? AND director = ? AND year = ?";

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, title);
            ps.setString(2, director);
            ps.setInt(3, year);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    exists = true;
                }
            }
        }
        return exists;
    }

    /**
     * Inserts a new movie record into the database.
     * Includes sanitization to ensure Genre is Title Case.
     * @param movie The Movie bean containing the data to insert
     */
    public void insertMovie(Movie movie) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME + " (title, year, genre, director) VALUES (?, ?, ?, ?)";

        String cleanGenre = movie.getGenre();
        if (cleanGenre != null && !cleanGenre.isEmpty()) {
            // Update 11/30/2025: Changed sanitization to only capitalize first letter.
            // Remaining characters are left as-is to support mixed case (e.g., Sci-Fi).
            cleanGenre = cleanGenre.substring(0, 1).toUpperCase() + cleanGenre.substring(1);
        }

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, movie.getTitle());
            ps.setInt(2, movie.getYear());
            ps.setString(3, cleanGenre);
            ps.setString(4, movie.getDirector());

            ps.executeUpdate();
        }
    }

    /**
     * Updates an existing movie record in the database.
     * Sanitizes the Genre field before updating.
     * @param movie The Movie object containing updated data
     * @return true if the update was successful (rows affected > 0)
     */
    public boolean updateMovie(Movie movie) throws SQLException {
        String query = "UPDATE " + TABLE_NAME + " SET title = ?, year = ?, genre = ?, director = ? WHERE id = ?";
        
        String cleanGenre = movie.getGenre();
        if (cleanGenre != null && !cleanGenre.isEmpty()) {
            // Update 11/30/2025: Changed sanitization to only capitalize first letter.
            // Remaining characters are left as-is to support mixed case (e.g., Sci-Fi).
            cleanGenre = cleanGenre.substring(0, 1).toUpperCase() + cleanGenre.substring(1);
        }

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, movie.getTitle());
            ps.setInt(2, movie.getYear());
            ps.setString(3, cleanGenre);
            ps.setString(4, movie.getDirector());
            ps.setInt(5, movie.getId()); // ID used for WHERE clause

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    /**
     * Retrieves all movie records from the database.
     * Results are sorted by ID in descending order.
     * @return List of Movie objects
     */
    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> movieList = new ArrayList<>();
        String query = "SELECT * FROM " + TABLE_NAME + " ORDER BY id DESC";

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setTitle(rs.getString("title"));
                movie.setYear(rs.getInt("year"));
                movie.setGenre(rs.getString("genre"));
                movie.setDirector(rs.getString("director"));
                movieList.add(movie);
            }
        }
        return movieList;
    }

    /**
     * Retrieves a list of all distinct genres currently in the database.
     * @return List of unique genre strings, sorted alphabetically
     */
    public List<String> getDistinctGenres() throws SQLException {
        List<String> genres = new ArrayList<>();
        String query = "SELECT DISTINCT genre FROM " + TABLE_NAME + " ORDER BY genre ASC";

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                genres.add(rs.getString("genre"));
            }
        }
        return genres;
    }

    /**
     * Retrieves a list of all distinct directors currently in the database.
     * @return List of unique director strings, sorted alphabetically
     */
    public List<String> getDistinctDirectors() throws SQLException {
        List<String> directors = new ArrayList<>();
        String query = "SELECT DISTINCT director FROM " + TABLE_NAME + " ORDER BY director ASC";

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                directors.add(rs.getString("director"));
            }
        }
        return directors;
    }

    /**
     * Retrieves IDs and Titles for all movies.
     * Used for selection logic in Update/Delete modules.
     * @return List of Movie objects with only ID and Title populated
     */
    public List<Movie> getAllMovieKeys() throws SQLException {
        List<Movie> movieList = new ArrayList<>();
        String query = "SELECT id, title FROM " + TABLE_NAME + " ORDER BY title ASC";

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Movie movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setTitle(rs.getString("title"));
                movieList.add(movie);
            }
        }
        return movieList;
    }

    /**
     * Retrieves a single full movie record by its Primary Key ID.
     * @param id The unique ID of the movie
     * @return Populated Movie object, or null if not found
     */
    public Movie getMovieById(int id) throws SQLException {
        Movie movie = null;
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(url, username, getPassword());
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    movie = new Movie();
                    movie.setId(rs.getInt("id"));
                    movie.setTitle(rs.getString("title"));
                    movie.setYear(rs.getInt("year"));
                    movie.setGenre(rs.getString("genre"));
                    movie.setDirector(rs.getString("director"));
                }
            }
        }
        return movie;
    }
}