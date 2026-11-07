#!/bin/bash

count=1

while [ $count -le 5 ]
do
echo "Count is $count"
sleep 1
 #Increment the counter
((count++)) 
done