# ---------- Build Stage ----------
FROM eclipse-temurin:21-jdk-jammy AS builder
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# ---------- Runtime Stage ----------
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copy JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
