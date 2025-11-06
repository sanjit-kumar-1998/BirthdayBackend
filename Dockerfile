# ---------- Build Stage ----------
FROM eclipse-temurin:21-jdk-jammy AS builder
WORKDIR /app

# Copy project files
COPY . .

# Give execute permission to mvnw
RUN chmod +x mvnw

# Build the app
RUN ./mvnw clean package -DskipTests

# ---------- Runtime Stage ----------
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copy the JAR from builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
