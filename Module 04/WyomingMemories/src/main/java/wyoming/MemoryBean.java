/*
Clint Scott
CSD 430
M4 – JavaBean Example (Wyoming Memories)
11/09/2025

This JavaBean class defines a MemoryBean that stores information about a specific
Wyoming memory record. Each MemoryBean contains a place, activity, and description.
The class implements java.io.Serializable as required for all JavaBeans.
*/

package wyoming;

import java.io.Serializable;

public class MemoryBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private String place;
    private String activity;
    private String description;

    // No-argument constructor (required for a JavaBean)
    public MemoryBean() {}

    // Constructor for quick initialization
    public MemoryBean(String place, String activity, String description) {
        this.place = place;
        this.activity = activity;
        this.description = description;
    }

    // Getter and Setter methods
    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
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
}
