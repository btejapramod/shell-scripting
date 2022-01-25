#!/bin/bash

source components/common.sh

echo "Setup NodeJS Repo"
curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash - &>>LOG_FILE
STAT $?

echo "Install NodeJS"
yum install nodejs gcc-c++ -y &>>LOG_FILE
STAT $?

echo "Create APP User"
useradd roboshop &>>LOG_FILE
STAT $?

echo "Downloading the catalogue code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>LOG_FILE
STAT $?

echo "Extract the Catalogue code"
unzip /tmp/catalogue.zip &>>LOG_FILE
STAT $?

echo "Clean old content"
rm -rf /home/roboshop/catalogue
STAT $?

echo "Copy catalogue content"
cp -r catalogue-main catalogue &>>LOG_FILE
STAT $?

echo "Install the dependencies"
cd /home/roboshop/catalogue
npm install &>>LOG_FILE
STAT $?

chown roboshop:roboshop /home/roboshop/ -R
echo "Update SystemD file"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service &>>$LOG_FILE
STAT $?

echo "Setup Catalogue SystemD file"
mv /home/roboshop/catalogue/systemd.service  /etc/systemd/system/catalogue.service &>>$LOG_FILE
STAT $?

echo "Start Catalogue"
systemctl daemon-relaod  &>>$LOG_FILE
systemctl enable catalogue &>>$LOG_FILE
systemctl start catalogue &>>$LOG_FILE
STAT $?
