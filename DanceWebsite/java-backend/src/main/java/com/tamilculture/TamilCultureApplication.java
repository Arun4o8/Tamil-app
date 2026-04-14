package com.tamilculture;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Main Spring Boot Application for Tamil Culture Heritage Platform
 */
@SpringBootApplication
public class TamilCultureApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(TamilCultureApplication.class, args);
        System.out.println("==============================================");
        System.out.println("Tamil Culture Heritage API is running!");
        System.out.println("API Base URL: http://localhost:8080/api");
        System.out.println("==============================================");
    }
}
