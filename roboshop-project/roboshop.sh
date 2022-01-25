#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0   ]; then
  echo -e "\e[1;31mYou should be root user to execute the script\e[0m"
  exit
fi

if [ -f components/$1.sh ]; then
bash components/$1.sh
else
  echo -e  "\e[1;31mInvalid Input\e[0m"
  echo -e "\e[1;33mAvailable Inputs - frontend|mongodb|catalogue|redis|user|cart|mysql|shipping|payment|rabbitmq|dispatch\e[0m"
  fi
