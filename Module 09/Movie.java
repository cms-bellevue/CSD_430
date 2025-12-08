package csd430.beans;

/**
 * Clint Scott
 * CSD 430
 * Module 9 Project Part 4
 * 12/07/2025
 *
 * JavaBean model for a single movie record from the clint_movies_data table.
 * Updated for Module 9 to include the 'isDeleted' flag for soft-delete functionality.
 */
public class Movie {
    private int id;
    private String title;
    private int year;
    private String genre;
    private String director;
    private boolean isDeleted;

    // Default constructor required by JavaBean specification
    public Movie() {}

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }
    
    /**
     * Getter for the soft delete status.
     * @return true if the record is soft-deleted, false otherwise.
     */
    public boolean isDeleted() {
        return isDeleted;
    }

    /**
     * Setter for the soft delete status.
     * Used by the DAO to map the 'is_deleted' column from the database.
     * @param deleted The status to set.
     */
    public void setDeleted(boolean deleted) {
        this.isDeleted = deleted;
    }
}