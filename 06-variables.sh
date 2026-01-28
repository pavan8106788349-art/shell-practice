#!/bin/bash

START_TIME=$(date +%s)

echo "Script executed at : $TIMESTAMP"

sleep 10

END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME-$START_TIME))

echo "Script executed in: $TOTAL_TIME"