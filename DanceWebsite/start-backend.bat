@echo off
echo ================================================
echo Tamil Culture Heritage - Java Backend Server
echo ================================================
echo.

cd java-backend

echo Checking if Maven is installed...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven is not installed!
    echo Please install Maven from: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)

echo.
echo Starting Spring Boot application...
echo Backend will be available at: http://localhost:8080
echo.

mvn spring-boot:run

pause
