FROM python:3.8 as python
WORKDIR /code
COPY requirements.txt .
COPY local_setup .
RUN pip install -r requirements.txt
RUN python setup.py



# docker run --rm -v C:/Users/WilliamBaker_ln8b51m/Projects/snowflake_flyway/databases/SURVEY:/flyway/sql -v C:/Users/WilliamBaker_ln8b51m/Projects/snowflake_flyway/local_setup:/flyway/conf snowflakeflyway:v.3 migrate

### 1. Get Linux
#FROM centos:7

### 2. Get Java via the package manager
# Install Java
#RUN yum update -y \
#&& yum install java-1.8.0-openjdk -y \
#&& yum clean all \
#&& rm -rf /var/cache/y


#ENV JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk"

### 3. Get Python, PIP

#RUN yum install python3 -y \
#&& pip3 install --upgrade pip setuptools wheel \
#&& if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
#&& if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi \
#&& yum clean all \
#&& rm -rf /var/cache/yum


## 4 Python deps

#RUN echo Mount Migrations > /Mount Migrations
#WORKDIR /code
#RUN echo Mount Migrations > /Mount Migrations
#COPY requirements.txt .
#RUN echo Mount Migrations > /Mount Migrations
#COPY local_setup .
##RUN echo Mount Migrations > /Mount Migrations
#RUN pip install -r requirements.txt
#RUN echo Mount Migrations > /Mount Migrations
#WORKDIR /local_setup
#RUN echo Mount Migrations > /Mount Migrations
# RUN python setup.py
## 5 Flyway deps

FROM adoptopenjdk:11-jre-hotspot

# Add the flyway user and step in the directory
RUN adduser --system --home /flyway --disabled-password --group flyway
WORKDIR /flyway

# Change to the flyway user
USER flyway
COPY --from=python /code ./code
#COPY --from=python /code/flyway.conf ./flyway/conf/flyway.conf
# RUN adduser --system --home /flyway --disabled-password --group flyway
#RUN adduser --system --create-home flyway
#USER flyway
WORKDIR /flyway
#RUN echo Mount Migrations > /Mount Migrations
#COPY ./databases/SURVEY /flyway/sql
#RUN echo Mount flyway.conf > /Mount Migrations
#COPY ./flyway.conf /flyway/conf
# RUN apt-get update
# Change to the flyway user


ENV FLYWAY_VERSION 7.5.3

RUN curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz
  
COPY --from=python /code/flyway.conf ./conf/flyway.conf
#RUN echo Mount Migrations > /Mount Migrations
#COPY ./databases/SURVEY /flyway/sql
#RUN echo Mount flyway.conf > /Mount Migrations
#COPY ./flyway.conf /flyway/conf

#FROM alpine:3.7
#COPY --from=builder ./ /
 
ENV PATH="/flyway:${PATH}"
ENV PATH="/starter:${PATH}"
#ENV PATH="/${JAVA_HOME}:${PATH}"
# FLYWAY_CONFIG_FILES

EXPOSE 80

ENTRYPOINT ["flyway"]
CMD ["-?"]