import json
import os
path = os.path.abspath(os.sep)
# print(path)
dir_path = os.path.dirname(os.path.realpath(__file__))

with open(dir_path + os.sep + 'flyway_config.json') as config_file:
    data = json.load(config_file)


snowflake_user = data['snowflake_user']
snowflake_password = data['snowflake_password']
snowflake_role = data['snowflake_role']
cloneable_snowflake_database = snowflake_user + '_DEV'
url = "flyway.url=jdbc:snowflake://bigdatasolutions.west-europe.azure.snowflakecomputing.com/?db='{}'&warehouse=LOAD_WH&role='{}'&authenticator=snowflake".format(cloneable_snowflake_database,snowflake_role)
clone_statement = "CREATE DATABASE {} CLONE DATABASE SURVEY".format(cloneable_snowflake_database)

flyway_conf = """
# Long properties can be split over multiple lines by ending each line with a backslash
flyway.locations=filesystem:databases/survey_demo
flyway.user={}
flyway.password={}
flyway.url={}
# flyway.url=jdbc:snowflake://bigdatasolutions.west-europe.azure.snowflakecomputing.com/?db=SURVEY_DEV&warehouse=LOAD_WH&role=SYSADMIN&authenticator=snowflake

""".format(snowflake_user,snowflake_password,url)

#f.
open(path + "flyway.conf_test","w+")
#write.file("flyway.conf_test")

print(flyway_conf)



