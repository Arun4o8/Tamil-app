package com.tamilculture.model;

import java.util.List;

/**
 * Model class representing a Dance Form (e.g., Bharatanatyam, Karakattam)
 */
public class DanceForm {
    private Long id;
    private String name;
    private String type; // Classical, Folk, Martial Arts
    private String description;
    private String thumbnailUrl;
    private List<TrainingMethod> trainingMethods;
    private List<CultureDetail> cultureDetails;
    
    // Constructors
    public DanceForm() {}
    
    public DanceForm(Long id, String name, String type, String description) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.description = description;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getThumbnailUrl() {
        return thumbnailUrl;
    }
    
    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }
    
    public List<TrainingMethod> getTrainingMethods() {
        return trainingMethods;
    }
    
    public void setTrainingMethods(List<TrainingMethod> trainingMethods) {
        this.trainingMethods = trainingMethods;
    }
    
    public List<CultureDetail> getCultureDetails() {
        return cultureDetails;
    }
    
    public void setCultureDetails(List<CultureDetail> cultureDetails) {
        this.cultureDetails = cultureDetails;
    }
}
