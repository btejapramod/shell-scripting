#!/bin/bash
#
#1. Setup MongoDB repos.
#
#curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
#
#1. Install Mongo & Start Service.
## yum install -y mongodb-org
## systemctl enable mongod
## systemctl start mongod
#
#1. Update Listen IP address from 127.0.0.1 to 0.0.0.0 in config file
#Config file: `/etc/mongod.conf`
#then restart the service
#
## systemctl restart mongod
#
### Every Database needs the schema to be loaded for the application to work.
#Download the schema and load it.
#
## curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
#
## cd /tmp
## unzip mongodb.zip
## cd mongodb-main
## mongo < catalogue.js
## mongo < users.js

source components/common.sh
echo "Download mongodb repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>LOG_FILE

echo "Install MongoDB"
yum install -y mongodb-org &>>LOG_FILE

echo "Update the mogodb config file"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>LOG_FILE

echo "Start the Mongodb database"
systemctl enable mongod &>>LOG_FILE
systemctl start mongod &>>LOG_FILE

echo "Download the database schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>LOG_FILE

echo "Extract the schema"
unzip -o /tmp/mongodb.zip &>>LOG_FILE

echo "Load the schema"
cd mongodb-main
mongo < catalogue.js &>>LOG_FILE
mongo < users.js &>>LOG_FILE
