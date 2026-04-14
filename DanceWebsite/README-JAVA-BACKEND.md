# Tamil Culture Heritage Platform - Java Backend + JavaScript Frontend

## 🏗️ Architecture

This project has been converted to a **full-stack application**:

- **Backend**: Java Spring Boot REST API
- **Frontend**: HTML/CSS/JavaScript (connects to Java API)
- **Data Flow**: Frontend → REST API → Java Service Layer → Data Models

## 📁 Project Structure

```
DanceWebsite/
├── java-backend/                    # Java Spring Boot Backend
│   ├── src/main/java/com/tamilculture/
│   │   ├── model/                   # Data Models
│   │   │   ├── DanceForm.java
│   │   │   ├── TrainingMethod.java
│   │   │   └── CultureDetail.java
│   │   ├── controller/              # REST Controllers
│   │   │   └── DanceFormController.java
│   │   ├── service/                 # Business Logic
│   │   │   └── DanceFormService.java
│   │   └── TamilCultureApplication.java  # Main App
│   ├── src/main/resources/
│   │   └── application.properties   # Configuration
│   └── pom.xml                      # Maven Dependencies
│
├── js/                              # JavaScript Frontend
│   └── api-service.js               # API Client & Training Manager
│
├── viewer.html                      # Main Frontend UI
├── index.html                       # Landing Page
└── README-JAVA-BACKEND.md          # This file
```

## 🚀 How to Run

### Step 1: Start Java Backend

```bash
cd java-backend

# If you have Maven installed:
mvn spring-boot:run

# OR if you have Java 17+ installed:
mvn clean package
java -jar target/tamil-culture-backend-1.0.0.jar
```

The backend will start on: **http://localhost:8080**

### Step 2: Update Frontend

Add this script tag to your `viewer.html` (before closing `</body>` tag):

```html
<script src="js/api-service.js"></script>
```

### Step 3: Open Frontend

Open `viewer.html` in your browser. The JavaScript will automatically connect to the Java backend.

## 📡 API Endpoints

### Get All Dance Forms
```
GET http://localhost:8080/api/danceforms
```

### Get Specific Dance Form
```
GET http://localhost:8080/api/danceforms/Bharatanatyam
```

### Get Training Methods
```
GET http://localhost:8080/api/danceforms/Bharatanatyam/training
```

### Get Dance Forms by Type
```
GET http://localhost:8080/api/danceforms/type/Classical
```

## 🔧 Technologies Used

### Backend
- **Java 17**
- **Spring Boot 3.2.0**
- **Spring Web** (REST API)
- **Maven** (Build tool)

### Frontend
- **JavaScript ES6+** (Fetch API, Async/Await)
- **HTML5**
- **CSS3**

## 📊 Data Models

### DanceForm
```java
{
    id: Long,
    name: String,
    type: String,
    description: String,
    thumbnailUrl: String,
    trainingMethods: List<TrainingMethod>,
    cultureDetails: List<CultureDetail>
}
```

### TrainingMethod
```java
{
    id: Long,
    title: String,
    icon: String,
    description: String,
    referenceImageUrl: String,
    stepNumber: int
}
```

## 🎯 Key Features

1. **RESTful API**: Clean separation between frontend and backend
2. **CORS Enabled**: Frontend can call backend from any origin
3. **Service Layer**: Business logic separated from controllers
4. **Model Classes**: Type-safe data structures
5. **Async JavaScript**: Non-blocking API calls
6. **Error Handling**: Graceful fallbacks for failed requests

## 🔍 Testing the API

### Using Browser Console:
```javascript
// Test API connection
const response = await fetch('http://localhost:8080/api/danceforms');
const data = await response.json();
console.log(data);

// Get Bharatanatyam training methods
const methods = await fetch('http://localhost:8080/api/danceforms/Bharatanatyam/training');
const trainingData = await methods.json();
console.log(trainingData);
```

### Using cURL:
```bash
curl http://localhost:8080/api/danceforms
curl http://localhost:8080/api/danceforms/Bharatanatyam/training
```

## 📝 Next Steps

1. **Add Database**: Replace in-memory data with MySQL/PostgreSQL
2. **Add More Dance Forms**: Expand the DanceFormService
3. **User Authentication**: Add Spring Security
4. **Image Upload**: Allow uploading reference images
5. **Quiz API**: Create endpoints for quiz questions
6. **Progress Tracking**: Store user training progress

## 🐛 Troubleshooting

### Backend won't start?
- Make sure Java 17+ is installed: `java -version`
- Check if port 8080 is available
- Look for errors in console

### Frontend can't connect?
- Make sure backend is running
- Check browser console for CORS errors
- Verify API base URL in `api-service.js`

### Images not loading?
- Check `referenceImageUrl` in TrainingMethod
- Verify image URLs are accessible
- Check browser console for 404 errors

## 📚 Learning Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [REST API Best Practices](https://restfulapi.net/)
- [JavaScript Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API)

---

**Created**: February 2026  
**Version**: 1.0.0  
**License**: MIT
