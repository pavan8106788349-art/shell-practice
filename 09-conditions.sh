#!/bin/bash

NUMBER=$1

if [ -z "$NUMBER" ]; then
  echo "Please provide a number"
  exit 1
fi

if [ "$NUMBER" -gt 20 ]; then
  echo "Given number: $NUMBER is greater than 20"
fi