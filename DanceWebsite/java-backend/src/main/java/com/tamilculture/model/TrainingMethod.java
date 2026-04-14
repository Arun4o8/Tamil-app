package com.tamilculture.model;

/**
 * Model class representing a Training Method/Step
 */
public class TrainingMethod {
    private Long id;
    private String title;
    private String icon;
    private String description;
    private String referenceImageUrl;
    private int stepNumber;
    private Long danceFormId;
    
    // Constructors
    public TrainingMethod() {}
    
    public TrainingMethod(Long id, String title, String icon, String description, String referenceImageUrl, int stepNumber) {
        this.id = id;
        this.title = title;
        this.icon = icon;
        this.description = description;
        this.referenceImageUrl = referenceImageUrl;
        this.stepNumber = stepNumber;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getIcon() {
        return icon;
    }
    
    public void setIcon(String icon) {
        this.icon = icon;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getReferenceImageUrl() {
        return referenceImageUrl;
    }
    
    public void setReferenceImageUrl(String referenceImageUrl) {
        this.referenceImageUrl = referenceImageUrl;
    }
    
    public int getStepNumber() {
        return stepNumber;
    }
    
    public void setStepNumber(int stepNumber) {
        this.stepNumber = stepNumber;
    }
    
    public Long getDanceFormId() {
        return danceFormId;
    }
    
    public void setDanceFormId(Long danceFormId) {
        this.danceFormId = danceFormId;
    }
}
