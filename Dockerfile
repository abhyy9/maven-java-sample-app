# -------- Build Stage --------
FROM maven:3.9.6-eclipse-temurin-11 AS build

WORKDIR /home/app

COPY pom.xml .
COPY src ./src

RUN mvn spring-javaformat:apply
RUN mvn clean package


# -------- Package Stage --------
FROM eclipse-temurin:11-jre

WORKDIR /usr/local/lib

COPY --from=build /home/app/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar demo.jar

EXPOSE 8001

ENTRYPOINT ["java","-Dserver.port=8001","-jar","demo.jar"]
