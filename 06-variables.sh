#!/bin/bash

START_TIME=$(date +%s)

echo "Script executed at : $START_TIME"

Sleep 10

END_TIME=$(date +%S)
TOTAL_TIME=$((START_TIME-END_TIME))

ech0 "Script executed in: $TOTAL_TIME"

