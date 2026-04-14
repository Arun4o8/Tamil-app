# 🎭 Tamil Culture Heritage Platform - Full Stack Architecture

## 📐 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                      USER BROWSER                            │
│  ┌────────────────────────────────────────────────────┐     │
│  │         viewer.html (Frontend UI)                  │     │
│  │  - HTML5 Structure                                 │     │
│  │  - CSS3 Styling                                    │     │
│  │  - User Interactions                               │     │
│  └────────────────┬───────────────────────────────────┘     │
│                   │                                          │
│                   │ Calls                                    │
│                   ▼                                          │
│  ┌────────────────────────────────────────────────────┐     │
│  │      js/api-service.js (JavaScript Client)         │     │
│  │  - TamilCultureAPI class                           │     │
│  │  - TrainingManager class                           │     │
│  │  - Fetch API calls                                 │     │
│  │  - UI Updates                                      │     │
│  └────────────────┬───────────────────────────────────┘     │
└───────────────────┼──────────────────────────────────────────┘
                    │
                    │ HTTP REST API
                    │ (JSON)
                    ▼
┌─────────────────────────────────────────────────────────────┐
│              JAVA SPRING BOOT BACKEND                        │
│              (http://localhost:8080)                         │
│                                                              │
│  ┌────────────────────────────────────────────────────┐     │
│  │  DanceFormController.java (REST API)               │     │
│  │  - GET /api/danceforms                             │     │
│  │  - GET /api/danceforms/{name}                      │     │
│  │  - GET /api/danceforms/{name}/training             │     │
│  │  - GET /api/danceforms/type/{type}                 │     │
│  └────────────────┬───────────────────────────────────┘     │
│                   │                                          │
│                   │ Calls                                    │
│                   ▼                                          │
│  ┌────────────────────────────────────────────────────┐     │
│  │  DanceFormService.java (Business Logic)            │     │
│  │  - getAllDanceForms()                              │     │
│  │  - getDanceFormByName()                            │     │
│  │  - getTrainingMethods()                            │     │
│  │  - getDanceFormsByType()                           │     │
│  └────────────────┬───────────────────────────────────┘     │
│                   │                                          │
│                   │ Uses                                     │
│                   ▼                                          │
│  ┌────────────────────────────────────────────────────┐     │
│  │  Data Models (Java Classes)                        │     │
│  │  - DanceForm.java                                  │     │
│  │  - TrainingMethod.java                             │     │
│  │  - CultureDetail.java                              │     │
│  └────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Data Flow Example: Starting Bharatanatyam Training

### Step 1: User Clicks "Start" Button
```html
<!-- viewer.html -->
<button onclick="startTraining('Bharatanatyam')">Start</button>
```

### Step 2: JavaScript Calls Java API
```javascript
// js/api-service.js
async startTraining(danceFormName) {
    // Fetch from Java backend
    const methods = await fetch('http://localhost:8080/api/danceforms/Bharatanatyam/training');
    const data = await methods.json();
    // Update UI with data
}
```

### Step 3: Java Controller Receives Request
```java
// DanceFormController.java
@GetMapping("/{name}/training")
public ResponseEntity<List<TrainingMethod>> getTrainingMethods(@PathVariable String name) {
    List<TrainingMethod> methods = danceFormService.getTrainingMethods(name);
    return ResponseEntity.ok(methods);
}
```

### Step 4: Service Returns Data
```java
// DanceFormService.java
public List<TrainingMethod> getTrainingMethods(String danceFormName) {
    DanceForm danceForm = danceFormsData.get(danceFormName);
    return danceForm.getTrainingMethods();
}
```

### Step 5: JSON Response to Frontend
```json
[
  {
    "id": 1,
    "title": "Araimandi Posture",
    "icon": "fa-universal-access",
    "description": "The basic sit-down posture...",
    "referenceImageUrl": "https://images.unsplash.com/...",
    "stepNumber": 1
  },
  ...
]
```

### Step 6: JavaScript Updates UI
```javascript
// Display the training method with reference image
displayCurrentMethod(data[0]);
```

## 🚀 How to Run the Full Stack Application

### Prerequisites
- **Java 17+** installed
- **Maven** installed
- Modern web browser

### Step 1: Start Java Backend
```bash
# Option 1: Double-click
start-backend.bat

# Option 2: Manual
cd java-backend
mvn spring-boot:run
```

**Backend will start on:** `http://localhost:8080`

### Step 2: Open Frontend
Open `viewer.html` in your browser

The JavaScript will automatically connect to the Java backend!

## 📡 API Endpoints Reference

### 1. Get All Dance Forms
```
GET http://localhost:8080/api/danceforms
```
**Response:**
```json
[
  {
    "id": 1,
    "name": "Bharatanatyam",
    "type": "Classical",
    "description": "One of the oldest...",
    "thumbnailUrl": "assets/cultures/bharatanatyam/thumb.png",
    "trainingMethods": [...],
    "cultureDetails": [...]
  }
]
```

### 2. Get Specific Dance Form
```
GET http://localhost:8080/api/danceforms/Bharatanatyam
```

### 3. Get Training Methods
```
GET http://localhost:8080/api/danceforms/Bharatanatyam/training
```

### 4. Filter by Type
```
GET http://localhost:8080/api/danceforms/type/Classical
```

## 🎯 Key Features

### Java Backend
✅ **RESTful API** - Industry standard architecture  
✅ **Spring Boot** - Production-ready framework  
✅ **Type Safety** - Compile-time error checking  
✅ **Scalable** - Easy to add database, authentication  
✅ **CORS Enabled** - Frontend can call from any origin  

### JavaScript Frontend
✅ **Async/Await** - Modern non-blocking code  
✅ **Fetch API** - Native HTTP client  
✅ **Class-based** - Clean OOP structure  
✅ **Error Handling** - Graceful fallbacks  
✅ **Console Logging** - Easy debugging  

## 🔍 Testing

### Test Backend (Browser Console)
```javascript
// Test connection
fetch('http://localhost:8080/api/danceforms')
  .then(r => r.json())
  .then(data => console.log(data));

// Get Bharatanatyam training
fetch('http://localhost:8080/api/danceforms/Bharatanatyam/training')
  .then(r => r.json())
  .then(data => console.log(data));
```

### Test Backend (cURL)
```bash
curl http://localhost:8080/api/danceforms
curl http://localhost:8080/api/danceforms/Bharatanatyam/training
```

## 📂 File Structure

```
DanceWebsite/
├── java-backend/                           # Java Spring Boot
│   ├── src/main/java/com/tamilculture/
│   │   ├── model/                          # Data models
│   │   ├── controller/                     # REST endpoints
│   │   ├── service/                        # Business logic
│   │   └── TamilCultureApplication.java    # Main class
│   ├── src/main/resources/
│   │   └── application.properties          # Config
│   └── pom.xml                             # Dependencies
│
├── js/
│   └── api-service.js                      # JavaScript client
│
├── viewer.html                             # Main UI
├── start-backend.bat                       # Quick start script
└── README-FULL-STACK.md                    # This file
```

## 🐛 Troubleshooting

### Backend won't start?
```bash
# Check Java version
java -version  # Should be 17+

# Check Maven
mvn -version

# Check port 8080
netstat -ano | findstr :8080
```

### Frontend can't connect?
1. Make sure backend is running
2. Check browser console for errors
3. Verify URL: `http://localhost:8080/api/danceforms`
4. Check CORS settings in `application.properties`

### Images not loading?
1. Check browser console for image errors
2. Verify `referenceImageUrl` in TrainingMethod
3. Test image URL directly in browser

## 📚 Next Steps

1. **Add Database** - MySQL/PostgreSQL instead of in-memory
2. **Add More Dance Forms** - Karakattam, Silambattam, etc.
3. **User Authentication** - Spring Security + JWT
4. **Image Upload** - Store reference images locally
5. **Progress Tracking** - Save user training progress
6. **Quiz System** - Add quiz endpoints

## 💡 Why This Architecture?

### Separation of Concerns
- **Frontend**: Focuses on UI/UX
- **Backend**: Handles data and business logic

### Scalability
- Can add mobile app using same API
- Easy to add new features
- Can scale backend independently

### Maintainability
- Clear code organization
- Type safety in Java
- Easy to test and debug

### Industry Standard
- RESTful API design
- Spring Boot best practices
- Modern JavaScript patterns

---

**Version:** 1.0.0  
**Created:** February 2026  
**Stack:** Java 17 + Spring Boot 3.2 + JavaScript ES6+
