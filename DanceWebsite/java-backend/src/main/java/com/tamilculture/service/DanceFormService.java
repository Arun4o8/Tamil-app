package com.tamilculture.service;

import com.tamilculture.model.DanceForm;
import com.tamilculture.model.TrainingMethod;

import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Service class for Dance Form business logic
 */
@Service
public class DanceFormService {
    
    private Map<String, DanceForm> danceFormsData;
    
    public DanceFormService() {
        initializeDanceFormsData();
    }
    
    /**
     * Initialize dance forms data (simulating database)
     */
    private void initializeDanceFormsData() {
        danceFormsData = new HashMap<>();
        
        // Bharatanatyam
        DanceForm bharatanatyam = new DanceForm(1L, "Bharatanatyam", "Classical", 
            "One of the oldest and most popular classical dance forms of India");
        bharatanatyam.setThumbnailUrl("assets/cultures/bharatanatyam/thumb.png");
        
        List<TrainingMethod> bharatanatyamMethods = Arrays.asList(
            new TrainingMethod(1L, "Araimandi Posture", "fa-universal-access", 
                "The basic sit-down posture where heels are together and knees are pointed sideways. This builds core stability.",
                "https://images.unsplash.com/photo-1599707334391-7d22f70238e8?w=600&h=400&fit=crop&q=80", 1),
            new TrainingMethod(2L, "Hasta Mudras", "fa-hand-paper",
                "Learn the single-hand gestures (Asamyuta Hastas) used to tell stories and represent nature.",
                "https://images.unsplash.com/photo-1540541338287-41700207dee6?w=600&h=400&fit=crop&q=80", 2),
            new TrainingMethod(3L, "Adavu Footwork", "fa-shoe-prints",
                "Master the basic rhythmic steps and coordination of hands and feet in rhythm.",
                "https://images.unsplash.com/photo-1578944032637-f0c2ece30704?w=600&h=400&fit=crop&q=80", 3),
            new TrainingMethod(4L, "Alarippu", "fa-hands",
                "The first piece of a recital, meaning 'to bloom'. It involves simple rhythmic movements to warm up the body.",
                "https://images.unsplash.com/photo-1582234372722-50d7ccc30ebd?w=600&h=400&fit=crop&q=80", 4),
            new TrainingMethod(5L, "Jatiswaram", "fa-music",
                "A pure dance (Nritta) piece that combines complex rhythmic patterns (Jatis) with melodic notes (Swaras).",
                "https://images.unsplash.com/photo-1545235661-3a4369f9babf?w=600&h=400&fit=crop&q=80", 5),
            new TrainingMethod(6L, "Shabdam", "fa-microphone-alt",
                "The first piece where expressive dance (Abhinaya) is introduced, following the meaning of a poetic song.",
                "https://images.unsplash.com/photo-1493225255756-d9584f8606e9?w=600&h=400&fit=crop&q=80", 6),
            new TrainingMethod(7L, "Varnam", "fa-star",
                "The most important and demanding part of the recital, alternating between pure dance and soulful expressions.",
                "https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=600&h=400&fit=crop&q=80", 7),
            new TrainingMethod(8L, "Padam", "fa-theater-masks",
                "Soulful storytelling through 'Abhinaya', focusing on the emotional resonance of the lyrics.",
                "https://images.unsplash.com/photo-1514525253344-9ecd6ee3914e?w=600&h=400&fit=crop&q=80", 8),
            new TrainingMethod(9L, "Thillana", "fa-bolt",
                "The grand finale, known for its fast-paced rhythmic footwork, stunning poses, and sculptural beauty.",
                "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=600&h=400&fit=crop&q=80", 9)
        );
        bharatanatyam.setTrainingMethods(bharatanatyamMethods);
        
        danceFormsData.put("Bharatanatyam", bharatanatyam);
    }
    
    public List<DanceForm> getAllDanceForms() {
        return new ArrayList<>(danceFormsData.values());
    }
    
    public DanceForm getDanceFormByName(String name) {
        return danceFormsData.get(name);
    }
    
    public List<TrainingMethod> getTrainingMethods(String danceFormName) {
        DanceForm danceForm = danceFormsData.get(danceFormName);
        return danceForm != null ? danceForm.getTrainingMethods() : null;
    }
    
    public List<DanceForm> getDanceFormsByType(String type) {
        return danceFormsData.values().stream()
            .filter(df -> df.getType().equalsIgnoreCase(type))
            .collect(Collectors.toList());
    }
}
