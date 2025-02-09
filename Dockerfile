# Stage 1: Build the app using Gradle
FROM gradle:8.2.1-jdk17 AS builder
WORKDIR /app

# Copy all your project files into the build container
COPY . .

# Run Gradle build (skip tests for faster builds if you want)
RUN gradle clean build -x test

# Stage 2: Create the final runtime image
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy the JAR from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the port that Spring Boot listens on
EXPOSE 8080

# Default command: run the JAR
CMD ["java", "-jar", "app.jar"]
