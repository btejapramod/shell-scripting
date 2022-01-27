#!/bin/bash
source components/common.sh

#1. Install Python 3

## yum install python36 gcc python3-devel -y


#1. Create a user for running the application

## useradd roboshop

#
#1. Download the repo.
#

#$ cd /home/roboshop
#$ curl -L -s -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip"
#$ unzip /tmp/payment.zip
#$ mv payment-main payment
#```
#
#1. Install the dependencies
#
#```bash
## cd /home/roboshop/payment
## pip3 install -r requirements.txt
#```
#
#**Note: Above command may fail with permission denied, So run as root user**
#
#1. Update the roboshop user and group id in `payment.ini` file.
#2. Update SystemD service file
#
#    Update `CARTHOST` with cart server ip
#
#    Update `USERHOST` with user server ip
#
#    Update `AMQPHOST` with RabbitMQ server ip.
#
#3. Setup the service
#
#```sql
## mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
## systemctl daemon-reload
## systemctl enable payment
## systemctl start payment
#```
