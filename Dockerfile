# 1 build python stage
FROM python:3.8 as python
WORKDIR /code

COPY requirements.txt .
COPY local_setup .
RUN pip install -r requirements.txt
RUN python setup.py

# 2 build java stage
FROM adoptopenjdk:11-jre-hotspot

# Add the flyway user and step in the directory
RUN adduser --system --home /flyway --disabled-password --group flyway
WORKDIR /flyway
# Change to the flyway user
USER flyway
# Copy code from python artifact 
COPY --from=python /code ./code
WORKDIR /flyway

ENV FLYWAY_VERSION 7.5.3

RUN curl -L https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz -o flyway-commandline-${FLYWAY_VERSION}.tar.gz \
  && tar -xzf flyway-commandline-${FLYWAY_VERSION}.tar.gz --strip-components=1 \
  && rm flyway-commandline-${FLYWAY_VERSION}.tar.gz

# Copy flyway.conf from python artifact 
COPY --from=python /code/flyway.conf ./conf/flyway.conf
ENV PATH="/flyway:${PATH}"
EXPOSE 80

ENTRYPOINT ["flyway"]
CMD ["info"]