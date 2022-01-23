#!/bin/bash

###String Expressions###
a=abc1
if [ $a = "abc" ]
then
  echo okay
fi

if [ $a != "abc" ]
then
  echo not okay
  fi

if [ -z "$d" ]; then
  echo d is empty/not declared varaible
  fi

###Number Expressions###

a=100
if [ $a -eq 100 ]; then
  echo  a is super okay
  fi
