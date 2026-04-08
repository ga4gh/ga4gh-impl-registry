# ── Build stage ────────────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jdk-alpine AS builder

# Install Node.js and npm for the React frontend build
RUN apk add --no-cache nodejs npm

WORKDIR /app

# Copy Gradle wrapper and config first for dependency caching
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Copy frontend source so Gradle can build it
COPY src/main/frontend src/main/frontend

# Copy the rest of the application source
COPY src src

RUN chmod +x gradlew
# Build everything — Gradle will run npm install + npm run build first,
# then compile the Java source and package the JAR
RUN ./gradlew build -x test --no-daemon

# ── Run stage ──────────────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/build/libs/*.jar app.jar

RUN chown appuser:appgroup app.jar

USER appuser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
