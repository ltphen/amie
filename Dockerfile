#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY ./ /home/app
CMD mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY ./yago2core.10kseedsSample.compressed.notypes.tsv /home/app/test.tsv
COPY --from=build /home/app/bin/amie3.jar /usr/local/lib/amie3.jar
RUN java -jar /usr/local/lib/amie3.jar /home/app/test.tsv
