package com.tamilculture.controller;

import com.tamilculture.model.DanceForm;
import com.tamilculture.model.TrainingMethod;
import com.tamilculture.service.DanceFormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * REST Controller for Dance Form operations
 */
@RestController
@RequestMapping("/api/danceforms")
@CrossOrigin(origins = "*")
public class DanceFormController {
    
    @Autowired
    private DanceFormService danceFormService;
    
    /**
     * Get all dance forms
     * @return List of all dance forms
     */
    @GetMapping
    public ResponseEntity<List<DanceForm>> getAllDanceForms() {
        List<DanceForm> danceForms = danceFormService.getAllDanceForms();
        return ResponseEntity.ok(danceForms);
    }
    
    /**
     * Get a specific dance form by name
     * @param name Dance form name (e.g., "Bharatanatyam")
     * @return Dance form details
     */
    @GetMapping("/{name}")
    public ResponseEntity<DanceForm> getDanceFormByName(@PathVariable String name) {
        DanceForm danceForm = danceFormService.getDanceFormByName(name);
        if (danceForm != null) {
            return ResponseEntity.ok(danceForm);
        }
        return ResponseEntity.notFound().build();
    }
    
    /**
     * Get training methods for a specific dance form
     * @param name Dance form name
     * @return List of training methods
     */
    @GetMapping("/{name}/training")
    public ResponseEntity<List<TrainingMethod>> getTrainingMethods(@PathVariable String name) {
        List<TrainingMethod> methods = danceFormService.getTrainingMethods(name);
        if (methods != null && !methods.isEmpty()) {
            return ResponseEntity.ok(methods);
        }
        return ResponseEntity.notFound().build();
    }
    
    /**
     * Get dance forms by type (Classical, Folk, Martial Arts)
     * @param type Dance form type
     * @return List of dance forms of that type
     */
    @GetMapping("/type/{type}")
    public ResponseEntity<List<DanceForm>> getDanceFormsByType(@PathVariable String type) {
        List<DanceForm> danceForms = danceFormService.getDanceFormsByType(type);
        return ResponseEntity.ok(danceForms);
    }
}
