#!/bin/bash
source components/common.sh

echo "Configuring the repos"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>$LOG_FILE
STAT $?

echo "Install Redis"
yum install redis -y &>>$LOG_FILE
STAT $?

echo "Update Redis Config file"
if [ -f /etc/redis.conf ]; then
sed -i -e "s/127.0.0.0/0.0.0.0/g" /etc/redis.conf &>>$LOG_FILE
elif [ -f /etc/yum.repos.d/redis/repo ]; then
  sed -e "s/127.0.0.0/0.0.0.0/g" e/etc/redis.conf &>>$LOG_FILE
  fi
STAT $?

echo "Start the Redis Database"
systemctl start redis  &>>$LOG_FILE
systemctl enable redis &>>$LOG_FILE
STAT $?
