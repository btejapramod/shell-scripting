#!/bin/bash

## yum install nginx -y
## systemctl enable nginx
## systemctl start nginx

#Let's download the HTDOCS content and deploy under the Nginx path.

## curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
#
#Deploy in Nginx Default Location.
#
## cd /usr/share/nginx/html
## rm -rf *
##
## mv frontend-main/* .
## mv static/* .
## rm -rf frontend-master README.md
## mv localhost.conf /etc/nginx/default.d/roboshop.conf
#
#Finally restart the service once to effect the changes.

## systemctl restart nginx
#***********************************************************************
#Delete the old content in the log file everytime we execute the script
rm -f /tmp/roboshop.log
#Variable is created for /tmp/roboshop.lof file.
LOG_FILE=/tmp/roboshop.log
#Installing nginx package

echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE #redirecting to the content to /tmp/roboshop.log

#Download frontend code from repo
echo "Downloading the frontend code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE

#Delete all directories and files in html directory
echo "Delete the old content"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE

#Extracting the frontend.zip file
echo "Extracting the frontend code"
unzip -o /tmp/frontend.zip &>>$LOG_FILE

echo "Copy the extracted content to Nginx path"
cp -r frontend-main/static/* /usr/share/nginx/html &>>$LOG_FILE

echo "Copy the nginx roboshop config"
cp frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE

echo "Start Nginx Service"
systemctl enable nginx &>>$LOG_FILE
systemctl start nginx &>>$LOG_FILE