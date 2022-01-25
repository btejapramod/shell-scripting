#!/bin/bash
#
#1. Install Redis.
#
#```bash
#
## curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
## yum install redis -y
#```
#
#2. Update the BindIP from `127.0.0.1` to `0.0.0.0` in config file `/etc/redis.conf` & `/etc/redis/redis.conf`
#
#3. Start Redis Database
#
#```bash
## systemctl enable redis
## systemctl start redis
#```
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
  sed -e "s/127.0.0.0/0.0.0.0/g" etc/yum.repos.d/redis.repo &>>$LOG_FILE
  fi
STAT $?

echo "Start the Redis Database"
systemctl start redis  &>>$LOG_FILE
systemctl enable redis &>>$LOG_FILE
STAT $?
