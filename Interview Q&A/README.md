Stage 1 – Build
FROM maven:3.6.3-adoptopenjdk-11 AS build


Uses a Maven image with JDK 11 installed.
This image has everything needed to compile Java code.
AS build names this stage so we can reference it later.

ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"


Sets JVM options for Maven.
This speeds up JVM startup inside Docker.
Useful for builds, not runtime.

WORKDIR /opt/demo


Sets /opt/demo as the working directory.
All following commands run from this path.

COPY pom.xml .


Copies only pom.xml into the image.
This is intentional. Docker caches this layer.
If source code changes but dependencies don’t, Maven won’t re-download everything.

RUN mvn dependency:go-offline


Downloads all project dependencies in advance.
Ensures faster and more reliable builds.
No internet dependency during later steps.

COPY src ./src


Copies application source code into the image.
Placed after dependency download to preserve caching.

RUN mvn clean install -DskipTests=true


Compiles the code and creates the JAR file.
clean removes old builds.
install builds and places the JAR in target/.
Tests are skipped to speed up container builds.

Stage 2 – Runtime
FROM adoptopenjdk/openjdk11:jre-11.0.9.11-alpine


Uses a lightweight JRE-only image.
No Maven. No compiler. Smaller and safer.
This is what runs in production.

WORKDIR /opt/demo


Sets runtime working directory.
Keeps paths consistent and clean.

COPY --from=build /opt/demo/target/demo.jar demo.jar


Copies the built JAR from the build stage only.
Nothing else comes along.
This is the key benefit of multi-stage builds.

ENTRYPOINT ["java", "-jar", "demo.jar"]


Defines the container startup command.
When the container starts, it runs the Java application.
Without this, the container would exit immediately.

One-line interview summary

“First stage builds the application using Maven. Second stage runs only the JAR using a slim JRE image. This reduces image size, improves security, and speeds up deployments.”
