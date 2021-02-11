# local Setup

This local setup creates a personal development environment including the creation of flyway configuration file to connect to flyway and a cloned production snowflake database to develop against.

The below are incldued files.
```

├── local_setup
│    ├── README.md
│    ├── flyway_config.json
│    └── setup.py
├── flyway.conf
└──  requirements.txt
```

# Getting Started

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

# Setup Steps

1. Create Python Env

```
virtualenv venv -p python3
source venv/bin/activate
pip install -r requirements.txt
```

2. Run setup.py

```
python setup.py
```

3. Validate the setup by running flyway validate command line command ```flyway validate -outputType=json```. The output should look something like below.

```
{
  "validationError": null,
  "errorDetails": null,
  "invalidMigrations": [],
  "validationSuccessful": true,
  "validateCount": 15,
  "flywayVersion": "7.5.2",
  "database": "USERNAME_DEV",
  "warnings": [],
  "operation": "validate"
}
```




