FROM openjdk:8-alpine
COPY target/my-app-1.0-SNAPSHOT.jar /opt/my-app.jar
ENTRYPOINT java -jar /opt/my-app.jar
