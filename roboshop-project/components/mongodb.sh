#!/bin/bash
source components/common.sh
echo "Download mongodb repos"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>LOG_FILE
STAT $?

echo "Install MongoDB"
yum install -y mongodb-org &>>LOG_FILE
STAT $?

echo "Update the mogodb config file"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>LOG_FILE
STAT $?

echo "Start the Mongodb database"
systemctl enable mongod &>>LOG_FILE && systemctl restart mongod &>>LOG_FILE
STAT $?

echo "Download the database schema"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>LOG_FILE
STAT $?

echo "Extract the schema"
unzip -o /tmp/mongodb.zip &>>LOG_FILE
STAT $?

echo "Load the schema"
cd mongodb-main
mongo < catalogue.js &>>LOG_FILE && mongo < users.js &>>LOG_FILE
STAT $?