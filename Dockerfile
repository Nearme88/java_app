# FROM openjdk:8-jdk-alpine
FROM alpine:latest
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "app.jar"]