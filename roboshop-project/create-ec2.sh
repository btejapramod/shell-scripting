#!/bin/bash

INSTANCE_NAME=$1
if [ -z "$INSTANCE_NAME" ]; then
echo -e "\e[1;33mInstance Name Argument is needed\e[0m"
exit
fi
LOG=/tmp/instnace-create.log
rm -f $LOG

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --query 'Images[*].[ImageId]' --output text)

if [ -z "${AMI_ID}" ]; then
  echo -e "\e[1;31mUnable to find image AMI_ID\e[0m"
  else
    echo -e "\e[1;33mAMI_ID=${AMI_ID}\e[0m"
fi
