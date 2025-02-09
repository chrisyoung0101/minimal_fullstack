# Use a base image with Java 17
FROM eclipse-temurin:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the Spring Boot JAR file into the container
# Update this path to match the output of your Gradle build
COPY build/libs/*.jar app.jar

# Expose the port Spring Boot will run on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
