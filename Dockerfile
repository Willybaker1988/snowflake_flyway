FROM adoptopenjdk:11-jre-hotspot
# FROM python:3

#FROM alpine:3.7
# Add the flyway user and step in the directory
RUN adduser --system --home /flyway --disabled-password --group flyway
RUN echo hello > /hello
USER flyway
WORKDIR /flyway
#RUN echo Mount Migrations > /Mount Migrations
#COPY ./databases/SURVEY /flyway/sql
#RUN echo Mount flyway.conf > /Mount Migrations
#COPY ./flyway.conf /flyway/conf

# RUN apt-get update
# Change to the flyway user
USER flyway

ENV FLYWAY_VERSION 7.5.3

RUN curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz
  
#RUN echo Mount Migrations > /Mount Migrations
#COPY ./databases/SURVEY /flyway/sql
#RUN echo Mount flyway.conf > /Mount Migrations
#COPY ./flyway.conf /flyway/conf

ENV PATH="/flyway:${PATH}"
ENV PATH="/starter:${PATH}"
# FLYWAY_CONFIG_FILES

EXPOSE 80

ENTRYPOINT ["flyway"]
CMD ["-?"]

