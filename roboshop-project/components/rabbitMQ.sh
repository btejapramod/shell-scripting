#!/bin/bash
source components/common.sh

echo "Install the enlarg dependency for RabbitMQ"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>>$LOG_FILE
STAT $?

echo "Setup the RabbitMQ Repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE
STAT $?

echo "Install the RabbitMQ Server"
yum install rabbitmq-server -y &>>$LOG_FILE
STAT $?

echo "Start RabbitMQ Service"
systemcl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
STAT $?

Echo "Setup the user RabbitMQ Application"
rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_user_tags roboshop administrator &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE