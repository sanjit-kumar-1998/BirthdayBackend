# Use an official OpenJDK 21 image
FROM openjdk:21-jdk-slim AS build

# Set working directory inside the container
WORKDIR /app

# Copy everything
COPY . .

# Build the Spring Boot JAR
RUN ./mvnw clean package -DskipTests

# Second stage: smaller runtime image
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080 for Render
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
