FROM maven:3.8.4-openjdk-17 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:17
VOLUME /tmp
COPY --from=build /home/app/target/jenkinsTest-0.0.1-SNAPSHOT.jar  app.jar
EXPOSE 81
ENTRYPOINT exec java $JAVA_OPTS  -jar /app.jar