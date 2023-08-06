FROM openjdk:8-jdk-alpine
# FROM adoptopenjdk:8-jdk-hotspot
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "app.jar"]