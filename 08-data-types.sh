#!/bin/bash

NUM1=100
NUM2=sivakumar

SUM=$(($NUM1+$NUM2))

echo "Sum is: $SUM"

# Array
FRUITS=("Apple" "Banana" "Pomo")

echo "FRUITS are: ${FRUITS[@]}"
echo "First Fruit is: ${FRUITS[0]}"
echo "Second Fruit is: ${FRUITS[1]}"
echo "Third Fruit is: ${FRUITS[2]}"
