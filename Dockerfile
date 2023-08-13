FROM openjdk:11-jdk AS builder
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN chmod +x ./gradlew
RUN ./gradlew bootJar
FROM openjdk:11-slim
COPY --from=builder build/libs/*.jar apigateway-service.jar
VOLUME /tmp
EXPOSE 8000
ENTRYPOINT ["java", "-jar", "apigateway-service.jar"]