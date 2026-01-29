#!/bin/bash

NUMBER  =$1

# -gt -> greater than
# -lt -> less than
# -eq -> equal
# -ne -> not equal
if [ $NUMBER -gt 20 ]; then
    echo "Given number: $NUMBER is greater than 20"
 fi