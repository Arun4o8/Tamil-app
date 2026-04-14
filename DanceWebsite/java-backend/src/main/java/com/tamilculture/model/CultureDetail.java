package com.tamilculture.model;

/**
 * Model class representing Culture Details (sections like Overview, History, etc.)
 */
public class CultureDetail {
    private Long id;
    private String section;
    private String content;
    private Long danceFormId;
    
    // Constructors
    public CultureDetail() {}
    
    public CultureDetail(Long id, String section, String content) {
        this.id = id;
        this.section = section;
        this.content = content;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getSection() {
        return section;
    }
    
    public void setSection(String section) {
        this.section = section;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public Long getDanceFormId() {
        return danceFormId;
    }
    
    public void setDanceFormId(Long danceFormId) {
        this.danceFormId = danceFormId;
    }
}
