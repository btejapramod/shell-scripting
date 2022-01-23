#!/bin/bash

student_name="RAM"

echo Student is name is ${student_name}
echo Student is name is $student_name


date=23-01-2022

echo todays date is $date

#command substitution
date=$(date +%D)
echo Good Morning, today date is $date

time=$(date +%c)
echo Good Morning, today date and time is $time

#arthimetic substitution
 EXPR1=((2*2+8*2))
 echo EXPR1 Output = $EXPR1