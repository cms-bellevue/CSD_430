/*
Clint Scott
CSD 430
M4 – JavaBean Example (Wyoming Memories)
11/09/2025

This JavaBean defines the MemoryBean class, which stores data for a single
memory record related to Wyoming and the surrounding region. Each record
contains five fields: place, state, activity, description, and year.

The class:
- Implements java.io.Serializable as required for all JavaBeans
- Provides a no-argument constructor
- Includes getter and setter methods for all fields
*/

package wyoming;

import java.io.Serializable;

public class MemoryBean implements Serializable {
  private static final long serialVersionUID = 1L;

  // --- Data Fields (Minimum of 5 required) ---
  private String place;
  private String state;
  private String activity;
  private String description;
  private String year;

  // No-argument constructor (required for a JavaBean)
  public MemoryBean() {}

  // Constructor for full initialization
  public MemoryBean(String place, String state, String activity, String description, String year) {
    this.place = place;
    this.state = state;
    this.activity = activity;
    this.description = description;
    this.year = year;
  }

  // --- Getter and Setter methods for all 5 fields ---
  public String getPlace() {
    return place;
  }

  public void setPlace(String place) {
    this.place = place;
  }

  public String getState() {
    return state;
  }

  public void setState(String state) {
    this.state = state;
  }

  public String getActivity() {
    return activity;
  }

  public void setActivity(String activity) {
    this.activity = activity;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getYear() {
    return year;
  }

  public void setYear(String year) {
    this.year = year;
  }
}
