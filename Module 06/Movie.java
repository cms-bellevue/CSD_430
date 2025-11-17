package csd430.beans;

/**
 * Clint Scott
 * CSD 430
 * Module 6 Project Part 1
 * 11/16/2025
 *
 * JavaBean model for a single movie record from the clint_movies_data table.
 */
public class Movie {
    private int id;
    private String title;
    private int year;
    private String genre;
    private String director;

    // Default constructor required by JavaBean spec
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
}