# ==========================
# 1️⃣ Stage 1: Build project
# ==========================
FROM maven:3.9.8-eclipse-temurin-21 AS builder
WORKDIR /app

# Copy source code
COPY pom.xml .
COPY src ./src

# Build project, skip tests
RUN mvn clean package -DskipTests -Duser.language=en -Duser.country=US -Dfile.encoding=UTF-8

# ==========================
# 2️⃣ Stage 2: Run application
# ==========================
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Copy jar từ stage build
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENV SPRING_PROFILES_ACTIVE=prod
ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT} -Dserver.address=0.0.0.0 -jar app.jar"]
