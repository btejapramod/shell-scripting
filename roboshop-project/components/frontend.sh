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
## unzip /tmp/frontend.zip
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
#Installing nginx package

echo "Installing NGINX"
yum install nginx -y >>/tmp/roboshop.log #redirecting to the content to /tmp/roboshop.log

#Download frontend code from repo
echo "Downloading the frontend code"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" >>/tmp/roboshop.log
