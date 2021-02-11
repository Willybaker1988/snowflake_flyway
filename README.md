# Introduction
This repository contains three things.

* Sample flyway migration script for database "SURVEY".
* Common modules that can be used to set up Azure DevOps pipeline for Snowflake deployment using flyway.
* local setup configuration for configuring flyway and snowflake development environment locally.

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
├── flyway.conf
└──  requirements.txt
```