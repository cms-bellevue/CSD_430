package csd430.beans;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Clint Scott
 * CSD 430
 * Module 6 Project Part 1
 * 11/16/2025
 *
 * Data Access Object for interacting with the clint_movies_data table.
 */
public class MovieDAO {

    // Database connection details
    private final String url = "jdbc:mysql://localhost:3306/CSD430";
    private final String username = "student1";
    private final String password = "pass";

    public MovieDAO() {
        // Load JDBC driver when the DAO is created
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Error loading JDBC driver", e);
        }
    }

    /**
     * Retrieves all movie IDs and titles for the dropdown list
     * @return List of Movie objects with ID and Title fields populated
     */
    public List<Movie> getAllMovieKeys() throws SQLException {
        List<Movie> movieList = new ArrayList<>();
        String query = "SELECT id, title FROM clint_movies_data ORDER BY title ASC";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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
     * Retrieves a single movie by primary key ID
     * @param id Movie ID
     * @return Populated Movie bean or null if not found
     */
    public Movie getMovieById(int id) throws SQLException {
        Movie movie = null;
        String query = "SELECT * FROM clint_movies_data WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(url, username, password);
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