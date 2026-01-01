FROM eclipse-temurin:8-jdk
WORKDIR /app
COPY target/*.jar /app/myapp.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "myapp.jar"]