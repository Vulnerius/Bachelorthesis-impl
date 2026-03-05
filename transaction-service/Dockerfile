# Build stage
FROM gradle:9.3.1-jdk21-jammy AS builder
WORKDIR /app

COPY build.gradle.kts settings.gradle.kts gradle.properties ./
COPY src ./src

RUN gradle buildFatJar --no-daemon

#Run stage
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

COPY --from=builder /app/build/libs/*-all.jar ./transaction-service.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "transaction-service.jar"]