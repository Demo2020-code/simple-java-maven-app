FROM openjdk:8-alpine
COPY target/my-app.jar /opt/my-app.jar
ENTRYPOINT java -jar /opt/my-app.jar
