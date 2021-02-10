import json
import os
import logging
import snowflake.connector
from snowflake.connector.errors import DatabaseError

# create log file
logging.basicConfig(level=logging.INFO, filename='app.log', filemode='w', format='%(asctime)s -%(name)s - %(levelname)s - %(message)s')
#logging.warning('This will get logged to a file')

dir_path = os.path.dirname(os.path.realpath(__file__))
with open(dir_path + os.sep + 'flyway_config.json') as config_file:
    environ = json.load(config_file)

dir_path = dir_path.replace("local_setup","")

SNOWFLAKE_USER = environ['SF_USER']
SNOWFLAKE_PWD = environ['SF_PWD']
SNOWFLAKE_ROLE = environ['SF_ROLE']
SNOWFLAKE_WH = environ['SF_WH']
SNOWFLAKE_ACCOUNT = "bigdatasolutions.west-europe.azure"
SNOWFLAKE_DATABASE = "SURVEY_PROD"
SNOWFLAKE_SCHEMA = "PUBLIC"
CONCAT = "SNOWFLAKE_USER: {}/n SNOWFLAKE_PWD: {}/n".format(
    SNOWFLAKE_USER,
    SNOWFLAKE_PWD)

CLONE_DEV_DATABASE = SNOWFLAKE_USER + '_DEV'

URL = "flyway.url=jdbc:snowflake://{}.com/?db={}&warehouse={}&role={}&authenticator=snowflake".format(
            SNOWFLAKE_ACCOUNT,
            CLONE_DEV_DATABASE,
            SNOWFLAKE_WH,
            SNOWFLAKE_ROLE
        )

flyway_conf = """
# Long properties can be split over multiple lines by ending each line with a backslash
flyway.locations=filesystem:databases/survey_demo
flyway.user={}
flyway.password={}
flyway.defaultSchema={}
flyway.url={}
""".format(SNOWFLAKE_USER,SNOWFLAKE_PWD,SNOWFLAKE_SCHEMA,URL)

# Auth to create Snowflake Cursor.
def auth():
    ctx = snowflake.connector.connect(
        user=SNOWFLAKE_USER,
        role=SNOWFLAKE_ROLE,
        password=SNOWFLAKE_PWD,
        account=SNOWFLAKE_ACCOUNT,
        warehouse=SNOWFLAKE_WH, 
        database=SNOWFLAKE_DATABASE,
        schema=SNOWFLAKE_SCHEMA
        )
    return ctx.cursor()

def create_flyway_conf(path, filename, contents):
    f = open(dir_path + filename,"w+")
    f.write(contents)
    f.close()


"""
f = open(dir_path + "flyway.conf","w+")
f.write(flyway_conf)
f.close() 
"""


def main():
    logging.info("creating flyway.conf")
    logging.info("variables set are %s", CONCAT)
    conf = create_flyway_conf(path=dir_path,filename="flyway.conf",contents=flyway_conf)
    if os.path.isfile(dir_path + 'flyway.conf') == True:
        logging.info("created flyway.conf file")
        logging.info("preparing local development database  %s.", CLONE_DEV_DATABASE)
        cs=auth()
        try:
            sql = "DROP DATABASE IF EXISTS {};".format(CLONE_DEV_DATABASE)
            cs.execute(sql)
            logging.info("queryid %s", cs.sfqid)
            sql = "CREATE DATABASE {} CLONE {};".format(CLONE_DEV_DATABASE,SNOWFLAKE_DATABASE)
            cs.execute(sql)
            logging.info("queryid %s", cs.sfqid)
        finally:
            cs.close()
    else:
        logging.error("flyway.conf file hasn't been created in root")
            
main()



