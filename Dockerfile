FROM maven:3.6.3-jdk-8-slim AS stage1
WORKDIR /home/app
COPY . /home/app/
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:19
EXPOSE 8080
COPY --from=stage1 /home/app/target/kaiburr-rest-api.jar kaiburr-rest-api.jar
ENTRYPOINT ["sh", "-c", "java -jar /kaiburr-rest-api.jar"]