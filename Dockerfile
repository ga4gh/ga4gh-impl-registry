# JAR and frontend are pre-built by GitHub Actions (./gradlew build -x test)
# before this Dockerfile runs. Docker only packages the result.
FROM eclipse-temurin:21-jre-alpine
 
WORKDIR /app
 
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
 
# Copy the pre-built JAR from build/libs/ on the GitHub Actions runner
COPY build/libs/*.jar app.jar
 
RUN chown appuser:appgroup app.jar
 
USER appuser
 
EXPOSE 8080
 
ENTRYPOINT ["java", "-jar", "app.jar"]