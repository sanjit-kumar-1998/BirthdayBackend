# Step 1: Use official OpenJDK 21 image
FROM openjdk:21-jdk-slim

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy Maven build files and project source
COPY . .

# Step 4: Build the Spring Boot JAR using Maven
RUN ./mvnw clean package -DskipTests

# Step 5: Expose port (match with your Spring Boot server port, usually 8080)
EXPOSE 8080

# Step 6: Run the JAR file
CMD ["java", "-jar", "target/*.jar"]
