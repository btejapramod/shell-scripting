#!/bin/bash
# for loop
# while loop

for fruit in apple banana orange; do
echo $fruit
done

for number in 100; do
echo $number
done

#For loop is going to iterate number of time based on number of inputs.

#While loop works on expressions that if condition is using.

i=100000
    while [ $i -gt 0 ]; do
    echo Iteration - $i
    i=$(($i-1))
    done



