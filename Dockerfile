# Step 1: Use official OpenJDK 21 image
FROM openjdk:21-jdk-slim

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy Maven build files and project source
COPY . .

# Step 4: Give execute permission to mvnw
RUN chmod +x mvnw

# Step 5: Build the Spring Boot JAR using Maven
RUN ./mvnw clean package -DskipTests

# Step 6: Expose port (default 8080)
EXPOSE 8080

# Step 7: Run the JAR file
CMD ["java", "-jar", "target/*.jar"]
