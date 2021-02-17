# Introduction
This repository contains a flyway project for database migration using Snowflake as the backend.

The project utlizes Docker to build a development environment locally and all other deployments are handled via Azure DevOps.

The project contains:

* Flyway migration scripts for database "SURVEY".
* Common modules that can be used to set up Azure DevOps pipeline for Snowflake deployment using flyway.
* A local setup configuration to build and run flyway commandline via Docker.

Read about this approach here [Snowflake CI/CD using Flyway and Azure DevOps Pipeline](https://github.com/kulmam92/snowflake_flyway/blob/master/docs/index.md)

# Getting Started
The below are incldued files.
```

├── LICENSE           
└── CICD
│    ├── README.md
│    └── templates
│        ├── azure-pipelines.yml             <- YAML pipeline script
│        └── templates
│            ├── snowflakeFlywayBuild.yml    <- YAML pipeline template for snowflake build using flyway
│            ├── snowflakeFlywayBuild.yml    <- YAML pipeline template for snowflake build using flyway          
│            └── snowflakeFlywayDeploy.yml   <- YAML pipeline template for snowflake deploy using flyway
├── README.md
├── LICENSE
├── databases
│   ├── README.md
│   └── SURVEY
│       ├── V20200120.1__SCHEMA_DEMO_Create.sql
│       ├── V20200120.2__TABLE_DEMO.DEMOTABLE_Create.sql
│       └── V20200123.1__TABLE_DEMO.DEMOTABLE_Alter.sql
│ 
├── local_setup
│    ├── README.md
│    ├── flyway_config.json
│    └── setup.py
│
├──  Dockerfile
└──  requirements.txt
```

## Local Setup

Utilizing Docker we can build and install all dependencies needed for running the Survey Demo project, these are:

- Install flyway with preconfigured drivers and configurations.
- Create Personal Development Database in Snowflake utilizing CLONE of production.
- Create flyway.conf file to run migrations against Personal Development Database.

Using this containerized approach we can package our own image which can be built and run by all that wish to contribute.

## flyway.conf

flyway.conf holds the configuration for connecting to flyways migrations in the existing database. This will be programttically created as part of the setup.


## flyway_config.json

The flyway_config.json holds the key values which will be used in the setup.py for creating your development flyway.conf file and snowflake development database. 

Ensure they are updated with valid Snowflake user credentails.


```
{
    "SF_USER":"USERNAME", -INSERT YOUR SNOWFLAKE USERNAME
    "SF_PWD":"PWD",       -INSERT YOUR SNOWFLAKE PASSWORD
    "SF_ROLE":"SYSADMIN",
    "SF_WH":"LOAD_WH"
}
```


## Local Setup Steps

1. Update flyway_config.json.
2. Build Docker Image locally. Use -t to tag the name of your image. 
The name of the development database created will be listed in the terminal console as part of the build.
```
docker build -t snowflakeflyway:latest .

created flyway.conf file
2021-02-17 09:15:45,704 -setup - INFO - created flyway.conf file
preparing local development database  WILL_BAKER_DEV.
2021-02-17 09:15:45,704 -setup - INFO - preparing local development database  WILL_BAKER_DEV.
```
3. Run the Docker image to validate connection. This should return an example of the migrations in the development database created, the database can be viewed via snowflake and should follow the naming convention
```
docker run --rm -v  snowflakeflyway:latest 

+------------+--------------+----------------------------+------+---------------------+---------+
| Category   | Version      | Description                | Type | Installed On        | State   |
+------------+--------------+----------------------------+------+---------------------+---------+
| Versioned  | 20200208.0.1 | SURVEY.SCHEMA              | SQL  | 2021-02-09 09:05:28 | Future  |
| Versioned  | 20200208.0.2 | KAITO.SCHEMA               | SQL  | 2021-02-09 09:05:36 | Future  |
| Versioned  | 20200208.1   | SURVEY.STG DATA            | SQL  | 2021-02-09 09:05:44 | Future  |
| Versioned  | 20200208.2   | KAITO.STG DATA             | SQL  | 2021-02-09 09:05:53 | Future  |
| Versioned  | 20200208.3   | KAITO.AGENT                | SQL  | 2021-02-09 09:06:03 | Future  |
| Versioned  | 20200208.4   | KAITO.SURVEYS NLP          | SQL  | 2021-02-09 09:06:17 | Future  |
| Versioned  | 20200208.5   | SURVEY.AGENT               | SQL  | 2021-02-09 09:06:27 | Future  |
| Versioned  | 20200208.6   | KAITO.PARQUET FILE FORMAT  | SQL  | 2021-02-09 09:06:33 | Future  |
| Versioned  | 20200208.7   | SURVEY.SURVEYS NLP         | SQL  | 2021-02-09 09:06:48 | Future  |
| Versioned  | 20200208.8   | SURVEY.STAGE SURVEY        | SQL  | 2021-02-09 09:06:57 | Future  |
| Versioned  | 20200208.9   | SURVEY.PARQUET FILE FORMAT | SQL  | 2021-02-09 09:07:06 | Future  |
| Repeatable |              | KAITO.VIEW NLP DETAILS     | SQL  | 2021-02-09 09:07:13 | Missing |
| Repeatable |              | SURVEY.VIEW NLP DETAILS    | SQL  | 2021-02-09 09:07:22 | Missing |
| Repeatable |              | SURVEY.VW AGENT            | SQL  | 2021-02-09 09:07:31 | Missing |
| Repeatable |              | SURVEY.VW NLP ATTRIBUTION  | SQL  | 2021-02-09 09:07:39 | Missing |
| Versioned  | 20200217.10  | KAITO.AGENT REGION         | SQL  | 2021-02-17 08:27:55 | Future  |
+------------+--------------+----------------------------+------+---------------------+---------+

```
4. Mount migrations. To develop against our database we need mount our SQL migrations locally to the container, to do this we can run the following command. This now validates the mounted migrations against the development database, if you compare the output in steps 3 & 4 the states now show as success.
```   
docker run --rm -v C:/Users/WilliamBaker_ln8b51m/Projects/snowflake_flyway/databases/SURVEY:/flyway/sql snowflakeflyway:latest

+------------+--------------+----------------------------+------+---------------------+---------+
| Category   | Version      | Description                | Type | Installed On        | State   |
+------------+--------------+----------------------------+------+---------------------+---------+
| Versioned  | 20200208.0.1 | SURVEY.SCHEMA              | SQL  | 2021-02-09 09:05:28 | Success |
| Versioned  | 20200208.0.2 | KAITO.SCHEMA               | SQL  | 2021-02-09 09:05:36 | Success |
| Versioned  | 20200208.1   | SURVEY.STG DATA            | SQL  | 2021-02-09 09:05:44 | Success |
| Versioned  | 20200208.2   | KAITO.STG DATA             | SQL  | 2021-02-09 09:05:53 | Success |
| Versioned  | 20200208.3   | KAITO.AGENT                | SQL  | 2021-02-09 09:06:03 | Success |
| Versioned  | 20200208.4   | KAITO.SURVEYS NLP          | SQL  | 2021-02-09 09:06:17 | Success |
| Versioned  | 20200208.5   | SURVEY.AGENT               | SQL  | 2021-02-09 09:06:27 | Success |
| Versioned  | 20200208.6   | KAITO.PARQUET FILE FORMAT  | SQL  | 2021-02-09 09:06:33 | Success |
| Versioned  | 20200208.7   | SURVEY.SURVEYS NLP         | SQL  | 2021-02-09 09:06:48 | Success |
| Versioned  | 20200208.8   | SURVEY.STAGE SURVEY        | SQL  | 2021-02-09 09:06:57 | Success |
| Versioned  | 20200208.9   | SURVEY.PARQUET FILE FORMAT | SQL  | 2021-02-09 09:07:06 | Success |
| Repeatable |              | KAITO.VIEW NLP DETAILS     | SQL  | 2021-02-09 09:07:13 | Success |
| Repeatable |              | SURVEY.VIEW NLP DETAILS    | SQL  | 2021-02-09 09:07:22 | Success |
| Repeatable |              | SURVEY.VW AGENT            | SQL  | 2021-02-09 09:07:31 | Success |
| Repeatable |              | SURVEY.VW NLP ATTRIBUTION  | SQL  | 2021-02-09 09:07:39 | Success |
| Versioned  | 20200217.10  | KAITO.AGENT REGION         | SQL  |                     | Pending |
+------------+--------------+----------------------------+------+---------------------+---------+


```

# Developing in Development Environment.

Once the environment is setup you can develop using flyway and flyway command line arguments.

We will develop locally against a git branch then push the branch to our repository once our development is complete.

Migration Scripts

 -  SQL migrations are created following the Flyway standards which are listed https://flywaydb.org/documentation/concepts/migrations#overview.

## Steps

1. Create git branch to develop against. Use either Feat/ OR /Fix to prefix the branch dependent on the context of the development.

```
git checkout master
git pull
git checkout -b "Feat/MYFEATURENAME"
```


2. Create migration and save in directory databases/SURVEY

```   
│   └── SURVEY
│       ├── V20200208.9__SURVEY.PARQUET_FILE_FORMAT.sql
│       ├── V20200217.10__KAITO.AGENT_REGION.sql
│       └── V20200217.11__KAITO.MYEXAMPLE.sql

CREATE TABLE ${flyway:database}.KAITO.MYEXAMPLE (
	NAME VARCHAR(255),
	REGION VARCHAR(255)
);
GRANT REBUILD ON TABLE ${flyway:database}.KAITO.MYEXAMPLE TO ROLE SYSADMIN;
GRANT SELECT ON TABLE ${flyway:database}.KAITO.MYEXAMPLE TO ROLE SYSADMIN;
GRANT TRUNCATE ON TABLE ${flyway:database}.KAITO.MYEXAMPLE TO ROLE SYSADMIN;
```   

3. Run your flyway command against the docker container.

```  

docker run --rm -v C:/Users/WilliamBaker_ln8b51m/Projects/snowflake_flyway/databases/SURVEY:/flyway/sql snowflakeflyway:latest migrate

docker run --rm -v C:/Users/WilliamBaker_ln8b51m/Projects/snowflake_flyway/databases/SURVEY:/flyway/sql snowflakeflyway:latest repair

docker run --rm -v C:/Users/WilliamBaker_ln8b51m/Projects/snowflake_flyway/databases/SURVEY:/flyway/sql snowflakeflyway:latest validate

``` 

4. Commit & push the code when you have validated the migrations run in container and the migrations are applied in the development database.


``` 
git add *
git commit -m "migrations for MYEXAMPLE"
git push
``` 

5. Monitor the CI/CD pipeline through Azure DevOps.

6. If all build pass create a PR (Pull Request) to merge your feature branch into the master branch. Add an approver :smile

# Dependencies.

Docker Desktop installed.
