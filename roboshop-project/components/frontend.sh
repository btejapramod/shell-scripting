#!/bin/bash
source components/common.sh

#Installing nginx package
echo "Installing NGINX"
yum install nginx -y &>>$LOG_FILE #redirecting to the content to /tmp/roboshop.log
STAT $?

#Download frontend code from repo
echo "Downloading the frontend code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG_FILE
STAT $?

#Delete all directories and files in html directory
echo "Delete the old content"
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
STAT $?

#Extracting the frontend.zip file
echo "Extracting the frontend code"
unzip -o /tmp/frontend.zip &>>$LOG_FILE
STAT $?

echo "Copy the extracted content to Nginx path"
cp -r frontend-main/static/* /usr/share/nginx/html &>>$LOG_FILE
STAT $?

echo "Copy the nginx roboshop config"
cp frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$LOG_FILE
STAT $?

echo "Update RoboShop Config"
sed -i -e "/catalogue/ s/localhost/catalogue.roboshop.internal/" -e '/user/ s/localhost/user.roboshop.internal/' -e '/cart/ s/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
STAT $?

echo "Start Nginx Service"
systemctl enable nginx &>>$LOG_FILE
systemctl restart nginx &>>$LOG_FILE
STAT $?