#!/bin/bash
LOG=/tmp/instance-create.log
rm -f $LOG

INSTANCE_NAME=$1
if [ -z "$INSTANCE_NAME" ]; &>>$LOG
then
   echo -e "\e[1;33mInstance Name Argument is needed\e[0m"
  exit
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text) &>>$LOG

if [ -z "${AMI_ID}" ]; &>>$LOG
then
  echo -e "\e[1;31mUnable to find image AMI_ID\e[0m" &>>$LOG
  exit
  else
  echo -e "\e[1;33mAMI_ID=${AMI_ID}\e[0m" &>>$LOG
fi

#aws ec2 describe-instances --filters Name=name,Values=${INSTANCE_NAME}

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --output text --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${INSTANCE_NAME}}]" &>>$LOG