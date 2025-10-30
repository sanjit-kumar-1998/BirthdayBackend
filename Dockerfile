FROM openjdk:21-jdk-slim AS build

WORKDIR /app

# Copy everything into the container
COPY . .

# ✅ Fix permission issue for mvnw
RUN chmod +x mvnw

# ✅ Build the Spring Boot JAR file
RUN ./mvnw clean package -DskipTests

# ---------- Runtime Image ----------
FROM openjdk:21-jdk-slim
WORKDIR /app

# Copy only the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
