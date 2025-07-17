# 1. JDK 17 이미지를 기반으로 빌드 환경 구성
FROM openjdk:17-jdk-slim as builder
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY gradlew ./
COPY src ./src
COPY gradle ./gradle
RUN chmod +x ./gradlew
RUN ./gradlew build -x test

# 2. 실제 실행 환경 구성
FROM openjdk:17-jdk-slim
COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]