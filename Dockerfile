# -----------------------
# STAGE 1: BUILD
# -----------------------
FROM gradle:8.2.1-jdk17 AS builder

# Set a custom Gradle cache directory to avoid permission issues
ENV GRADLE_USER_HOME=/app/.gradle-cache

WORKDIR /app

# Copy everything into the container
COPY . .

# Make sure the gradlew script is executable
RUN chmod +x gradlew

# Build the project using the Gradle wrapper
# -x test to skip tests if you want faster builds
# --no-daemon to avoid daemon permission issues
RUN ./gradlew clean build -x test --no-daemon

# -----------------------
# STAGE 2: RUNTIME
# -----------------------
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy the generated JAR from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
