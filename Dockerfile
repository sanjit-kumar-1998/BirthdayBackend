# Step 1: Use Java 21 base image
FROM openjdk:21-jdk-slim

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy all files
COPY . .

# Step 4: Give permission to mvnw
RUN chmod +x mvnw

# Step 5: Build the JAR
RUN ./mvnw clean package -DskipTests

# Step 6: Expose the port your app runs on
EXPOSE 8080

# Step 7: Run the JAR (⚠️ replace filename below)
CMD ["java", "-jar", "target/birthday-backend-0.0.1-SNAPSHOT.jar"]
