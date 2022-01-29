#!/bin/bash
source components/common.sh

echo "Configure YUM Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE
STAT $?

echo "Install Rabbitmq and Erlang"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm rabbitmq-server -y &>>$LOG_FILE
STAT $?

echo "Install the RabbitMQ Server"
yum install rabbitmq-server -y &>>$LOG_FILE
STAT $?

echo "Start RabbitMQ Service"
systemcl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
STAT $?


Echo "Setup the user for RabbitMQ Application"
sudo rabbitmqctl list_users | grep roboshop &>>LOG_FILE
  if [ $? -ne 0 ]; then
    sudo rabbitmqctl add_user roboshop roboshop123  &>>$LOG_FILE
  fi
STAT $?

echo "Setup permissions for APP User"
sudo rabbitmqctl set_user_tags roboshop administrator &>>$LOG_FILE
sudo rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
STAT $?
